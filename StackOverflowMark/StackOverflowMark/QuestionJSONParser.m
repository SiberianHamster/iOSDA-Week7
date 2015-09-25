//
//  QuestionJSONParser.m
//  StackOverflowMark
//
//  Created by Mark Lin on 9/17/15.
//  Copyright © 2015 Mark Lin. All rights reserved.
//

#import "QuestionJSONParser.h"
#import "Question.h"


@implementation QuestionJSONParser

+(NSArray *)questionsResultsFromJSON:(NSDictionary *)jsonInfo {
  
  NSMutableArray *questions = [[NSMutableArray alloc] init];
  
  NSArray *items = jsonInfo[@"items"];
  for(NSDictionary *item in items) {
    Question *question = [[Question alloc] init];
    question.title = item[@"title"];
    NSDictionary *owner = item[@"owner"];
    question.displayName= owner[@"display_name"];
    question.avatarURL = owner[@"profile_image"];
    [questions addObject:question];
    
  }
  return questions;
}

@end
