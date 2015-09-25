//
//  Question.h
//  StackOverflowMark
//
//  Created by Mark Lin on 9/17/15.
//  Copyright © 2015 Mark Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Question : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *avatarURL;
@property (strong, nonatomic) UIImage *profileImage;
@property (strong, nonatomic) NSString *displayName;

@end
