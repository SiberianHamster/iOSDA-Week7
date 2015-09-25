//
//  Errors.h
//  StackOverflowMark
//
//  Created by Mark Lin on 9/16/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kStackOverFlowErrorDomain;

typedef enum : NSUInteger {
  StackOverFlowTooManyAttempts,
  StackOverFlowInvalidParameter,
  StackOverFlowNeedAuthentication,
  StackOverFlowGeneralError,
  StackOverFlowConnectionDown
  
} StackOverFlowErrorCodes;