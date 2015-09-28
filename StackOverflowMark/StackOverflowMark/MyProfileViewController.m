//
//  MyProfileViewController.m
//  StackOverflowMark
//
//  Created by Mark Lin on 9/15/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

#import "MyProfileViewController.h"
#import "StackOverflowService.h"
#import "ProfileJSONParser.h"
#import "Profile.h"

@interface MyProfileViewController ()
@property (retain, nonatomic) IBOutlet UIImageView *imageOfProfile;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *reputationLabel;
@property (retain, nonatomic) NSMutableArray *profiles;
@property (nonatomic) BOOL isDownloading;

@end

@implementation MyProfileViewController



- (void)viewDidLoad {
    [super viewDidLoad];
  
  [self addObserver:self forKeyPath:@"isDownloading" options:NSKeyValueObservingOptionNew context:nil];

  
  self.profiles = [[NSMutableArray alloc]init];

  [StackOverflowService completionHandlerForUser:^(NSArray *results, NSError *error) {
    
    if(error){
      NSLog(@"error: %@", error);
    }
    else{
      
      for (Profile *profile in results){
        self.isDownloading = true;
        Profile *myProfile = [[Profile alloc]init];
        myProfile.profileName = profile.profileName;
        myProfile.avatarURL = [NSString stringWithFormat:@"%@",profile.profileImage ];
        myProfile.reputation = profile.reputation;
        NSURL *profileURL = [NSURL URLWithString:myProfile.avatarURL];
        NSData *imageFromURL = [NSData dataWithContentsOfURL:profileURL];
        myProfile.profileImage = [UIImage imageWithData:imageFromURL];
        [self.profiles addObject: myProfile];
        [myProfile release];
      }
      Profile *myProfile = self.profiles[0];
      self.imageOfProfile.image = myProfile.profileImage;
      [self.nameLabel setText:myProfile.profileName];
      [self.reputationLabel setText:[NSString stringWithFormat:@"%@", myProfile.reputation]];
      self.isDownloading = false;
    }
  }
];
  [self.profiles release];
  
  
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
  BOOL newValue = [(NSNumber *) change[NSKeyValueChangeNewKey]boolValue];
  if (newValue){
    [self.activityIndicator stopAnimating];
  }
 }


@end
