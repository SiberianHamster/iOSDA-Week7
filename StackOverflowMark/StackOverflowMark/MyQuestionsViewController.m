//
//  MyQuestionsViewController.m
//  StackOverflowMark
//
//  Created by Mark Lin on 9/15/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

#import "MyQuestionsViewController.h"
#import "MyQuestionCell.h"
#import "StackOverflowMark-Swift.h"
#import "StackOverflowService.h"

@interface MyQuestionsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *questions;


@end

@implementation MyQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  
  [StackOverflowService showMeMyPosts:^(NSArray *questions, NSError *error) {
    if (error) {
      NSLog(@"error: %@", error);
      
    } else {
      self.questions = [[NSMutableArray alloc]init];
      
      for (Question *question in questions) {
        [self.questions addObject:question];
}
    }
  }
   ];
  [self.tableView reloadData];

  NSLog(@"%lu",(unsigned long)self.questions.count);}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MyQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  Question *question = [[Question alloc]init];
  question = self.questions[indexPath.row];
  cell.myQuestionLabel.text = question.title;
  return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.questions.count;
}

@end
