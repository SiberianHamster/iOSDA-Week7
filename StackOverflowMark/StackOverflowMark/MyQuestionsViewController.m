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

@interface MyQuestionsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *questions;


@end

@implementation MyQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  
  //!!!!!!!!!!!!!!call StackOverflowService Method(need to implement) to make a call to stack, then that method calls a JsonParser (need to implement) on it and save each object into self.questions array here  Might actually get away with using a non mutable array if my method passes entire array.!!!!!!!!!!!!!!
  
  
  
}

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
