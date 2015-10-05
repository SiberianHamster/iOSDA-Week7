//
//  StackOverflowService.h
//  StackOverflowMark
//
//  Created by Mark Lin on 9/16/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StackOverflowService : NSObject

+ (void)questionsForSearchTerm:(NSString *)searched completionHandler:(void (^)(NSArray *results, NSError *error))completionHandler;

+ (void)completionHandlerForUser:(void (^) (NSArray *result, NSError *error))completionHandlerForUser;

+ (void)showMeMyPosts:(void(^)(NSArray *questions, NSError *error)) completionHandler;


@end
