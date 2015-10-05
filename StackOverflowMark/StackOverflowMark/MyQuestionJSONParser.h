//
//  MyQuestionJSONParser.h
//  StackOverflowMark
//
//  Created by Mark Lin on 10/5/15.
//  Copyright © 2015 Mark Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyQuestionJSONParser : NSObject

+(NSMutableArray *)myQuestionFromJSON:(NSDictionary *)jsonInfo;

@end
