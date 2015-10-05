//
//  MyQuestionJSONParser.m
//  StackOverflowMark
//
//  Created by Mark Lin on 10/5/15.
//  Copyright © 2015 Mark Lin. All rights reserved.
//

#import "MyQuestionJSONParser.h"
#import "StackOverflowMark-Swift.h"

@implementation MyQuestionJSONParser

+(NSMutableArray *)myQuestionFromJSON:(NSDictionary *)jsonInfo {
  
  NSArray *questions = [[NSArray alloc] init];
  NSMutableArray *questionz = [[NSMutableArray alloc] init];
  
  questions = jsonInfo[@"items"];
  for(NSDictionary *item in questions) {
    Question *question = [[Question alloc] init];
    question.title = item[@"title"];
    [questionz addObject:question];
  }
  
  return questionz;
}
@end
