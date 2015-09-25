//
//  Profile.h
//  StackOverflowMark
//
//  Created by Mark Lin on 9/21/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Profile : NSObject

@property (strong, nonatomic) NSString *profileName;
@property (strong, nonatomic) NSString *avatarURL;
@property (strong, nonatomic) UIImage *profileImage;
@property (strong, nonatomic) NSString *reputation;

@end
