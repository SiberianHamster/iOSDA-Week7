//
//  StackOverflowService.m
//  StackOverflowMark
//
//  Created by Mark Lin on 9/16/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

#import "StackOverflowService.h"
#import <AFNetworking/AFNetworking.h>
#import "QuestionJSONParser.h"
#import "Errors.h"
#import "SearchQuestionsViewController.h"
//#import "Question.h"
#import "ProfileJSONParser.h"
#import "StackOverflowMark-Swift.h"
#import "MyQuestionJSONParser.h"



@interface StackOverflowService ()

@property (strong, nonatomic ) NSString *searched;

@end



@implementation StackOverflowService

+ (void)showMeMyPosts:(void(^)(NSArray *results, NSError *error)) completionHandler;
{NSString *baseurl = @"https://api.stackexchange.com/2.2/me/posts?order=desc&sort=activity&site=stackoverflow";
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSString *token = [userDefaults stringForKey:@"token"];
  NSString *key = [userDefaults stringForKey:@"key"];
  NSString *url = [NSString stringWithFormat:@"%@&access_token=%@&key=%@",baseurl, token, key];
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    
    NSLog(@"%ld",operation.response.statusCode);
    NSLog(@"%@",responseObject);
    NSArray *jsonArray = [MyQuestionJSONParser myQuestionFromJSON:responseObject];
    dispatch_async(dispatch_get_main_queue(), ^{
      completionHandler(jsonArray,nil);
      
    });
    
    
  } failure:^(AFHTTPRequestOperation *operation , NSError *error) {
    {if (operation.response) {
      NSError *stackOverflowError = [self errorForStatusCode:operation.response.statusCode];
      
      dispatch_async(dispatch_get_main_queue(), ^{
        completionHandler(nil,stackOverflowError);
      });
      
    } else {
      NSError *reachabilityError = [self checkReachability];
      if (reachabilityError) {
        completionHandler(nil, reachabilityError);
      }
    }
    }
  }];
}
    
    


+ (void)completionHandlerForUser:(void (^) (NSArray *results, NSError *error))completionHandlerForUser
{
  NSString *baseurl = @"https://api.stackexchange.com/2.2/me?order=desc&sort=reputation&site=stackoverflow";
  
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSString *token = [userDefaults stringForKey:@"token"];
  NSString *key = [userDefaults stringForKey:@"key"];
  NSString *url = [NSString stringWithFormat:@"%@&access_token=%@&key=%@",baseurl, token, key];
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
    
    NSLog(@"%ld",operation.response.statusCode);
    NSLog(@"%@",responseObject);
    NSArray *jsonArray = [ProfileJSONParser profilesFromJson:responseObject];
    dispatch_async(dispatch_get_main_queue(), ^{
      completionHandlerForUser(jsonArray,nil);
    });
    
    
  } failure:^(AFHTTPRequestOperation *operation , NSError *error) {
  {if (operation.response) {
    NSError *stackOverflowError = [self errorForStatusCode:operation.response.statusCode];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      completionHandlerForUser(nil,stackOverflowError);
    });
    
  } else {
    NSError *reachabilityError = [self checkReachability];
    if (reachabilityError) {
      completionHandlerForUser(nil, reachabilityError);
    }
  }
  }
  }];
}





+ (void)questionsForSearchTerm:(NSString *)searched completionHandler:(void (^)(NSArray *results, NSError *error))completionHandler
{

  NSString *baseurl = @"https://api.stackexchange.com/2.2/search?";
  
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSString *token = [userDefaults stringForKey:@"token"];
  NSString *key = [userDefaults stringForKey:@"key"];
  NSString *url = [NSString stringWithFormat:@"%@access_token=%@&key=%@&order=desc&sort=activity&intitle=%@&site=stackoverflow",baseurl, token, key, searched];

  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  

  [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"%ld",operation.response.statusCode);
    NSLog(@"%@",responseObject);
    
    NSArray *jsonArray = [QuestionJSONParser questionsResultsFromJSON:responseObject];
    dispatch_async(dispatch_get_main_queue(), ^{
      completionHandler(jsonArray,nil);
    });
    
    
    
  } failure:^(AFHTTPRequestOperation *operation, NSError * error) {if (operation.response) {
    NSError *stackOverflowError = [self errorForStatusCode:operation.response.statusCode];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      completionHandler(nil,stackOverflowError);
    });

  } else {
    NSError *reachabilityError = [self checkReachability];
    if (reachabilityError) {
      completionHandler(nil, reachabilityError);
    }
  }
  }];
}



+(NSError *)errorForStatusCode:(NSInteger)statusCode {
  
  NSInteger errorCode;
  NSString *localizedDescription;
  NSLog(@"ErrorCode: %ld",(long)statusCode);
  switch (statusCode) {
    case 502:
      localizedDescription = @"Server is not pleased with your many attempts, please slow down";
      errorCode = StackOverFlowTooManyAttempts;
      break;
    case 400:
      localizedDescription = @"Server doesn't understand what you are looking for, please try searching for something else";
      errorCode = StackOverFlowInvalidParameter;
      break;
    case 401:
      localizedDescription = @"You haven't signed in yet";
      errorCode = StackOverFlowNeedAuthentication;
      break;
    default:
      localizedDescription = @"Something is not quite right, please try again in a bit";
      errorCode = StackOverFlowGeneralError;
      break;
  }
  NSError *error = [NSError errorWithDomain:kStackOverFlowErrorDomain code:errorCode userInfo:@{NSLocalizedDescriptionKey : localizedDescription}];
  return error;
}


+(NSError *)checkReachability {
  if (![AFNetworkReachabilityManager sharedManager].reachable) {
    NSError *error = [NSError errorWithDomain:kStackOverFlowErrorDomain code:StackOverFlowConnectionDown userInfo:@{NSLocalizedDescriptionKey : @"Could not connect to servers, please try again when you have a connection"}];
    return error;
  }
  return nil;
}





@end
