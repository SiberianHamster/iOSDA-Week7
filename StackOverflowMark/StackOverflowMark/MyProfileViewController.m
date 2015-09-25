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
@property (retain, nonatomic) IBOutlet UIView *imageOfProfile;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *reputationLabel;
@property (retain, nonatomic) NSMutableArray *profiles;

@end

@implementation MyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  [StackOverflowService completionHandlerForUser:^(NSArray *results, NSError *error) {
    
    if(error){
      NSLog(@"error: %@", error);
    }
    else{
      
      for (Profile *profile in results){
        Profile *myProfile = [[Profile alloc]init];
        myProfile.profileName = profile.profileName;
        myProfile.avatarURL = profile.avatarURL;
        myProfile.reputation = profile.reputation;
        NSURL *profileURL = [NSURL URLWithString:myProfile.avatarURL];
        NSData *imageFromURL = [NSData dataWithContentsOfURL:profileURL];
        myProfile.profileImage = [UIImage imageWithData:imageFromURL];
        [self.profiles addObject: myProfile];

      }
      Profile *myProfile = self.profiles[0];
//      self.imageOfProfile.image = myProfile.profileImage;
      [self.nameLabel setText:myProfile.profileName];
      [self.reputationLabel setText:myProfile.reputation];
      //cool stuff
    }
    
    
  }
  
  
   ];}



@end
