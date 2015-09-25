//
//  QuestionJSONParser.h
//  StackOverflowMark
//
//  Created by Mark Lin on 9/17/15.
//  Copyright © 2015 Mark Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionJSONParser : NSObject

+(NSArray *)questionsResultsFromJSON:(NSDictionary *)jsonInfo;

@end
