//
//  SearchQuestionsViewController.m
//  StackOverflowMark
//
//  Created by Mark Lin on 9/15/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

#import "SearchQuestionsViewController.h"
#import "StackOverflowService.h"
#import <AFNetworking.h>
#import "Errors.h"
//#import "Question.h"
#import "QuestionJSONParser.h"
#import "QuestionTableViewCell.h"
#import "StackOverflowMark-Swift.h"

 
@interface SearchQuestionsViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSString *searched;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *jsonData;


@end

@implementation SearchQuestionsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  self.searchBar.delegate = self;
  

    // Do any additional setup after loading the view.
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
  self.searched = searchBar.text;
  [self.view endEditing:YES];

  
  [StackOverflowService questionsForSearchTerm:self.searched completionHandler:^(NSArray *results, NSError *error) {

    if (error) {
      NSLog(@"error: %@", error);
      
    } else {
      self.jsonData = [[NSMutableArray alloc]init];
      
      dispatch_group_t imagesGroup = dispatch_group_create();
      dispatch_queue_t imageQueue = dispatch_queue_create("com.marklin.stackoverflows", DISPATCH_QUEUE_CONCURRENT);
      
      for (Question *question in results) {
        
        dispatch_group_async(imagesGroup, imageQueue, ^{
          
        
//      //do the stuff with the results array
        Question *questionObject = [[Question alloc]init];
        questionObject.title = question.title;
      
        NSURL *avatarImageURL = [NSURL URLWithString:question.avatarURL];
        questionObject.displayName = question.displayName;
        NSData *imagefromurl = [NSData dataWithContentsOfURL:avatarImageURL];
        questionObject.profileImage = [UIImage imageWithData:imagefromurl];
        [self.jsonData addObject:questionObject];
        NSLog(@"Counting: %lu",(unsigned long)self.jsonData.count);

        });
        

        }
      
      dispatch_group_notify(imagesGroup, dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Finished Images" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *done = [UIAlertAction actionWithTitle:@"Yippie" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
          [alert dismissViewControllerAnimated:true completion:nil];
        }];
        [alert addAction:done];
        [self presentViewController:alert animated:true completion:nil];

      NSLog(@"%lu",(unsigned long)self.jsonData.count);
      NSLog(@"%lu",(unsigned long)results.count);
      [self.tableView reloadData];
      }
                            );}
  }];}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  QuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  Question *searched = self.jsonData[indexPath.row];
  cell.Title.text = searched.title;
  cell.Name.text = searched.displayName;
  cell.imageView.image = searched.profileImage;
  return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.jsonData.count;
//  return 23;
}


@end
