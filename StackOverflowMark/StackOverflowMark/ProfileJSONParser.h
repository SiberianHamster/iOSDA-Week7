//
//  ProfileJSONParser.h
//  StackOverflowMark
//
//  Created by Mark Lin on 9/21/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileJSONParser : NSObject


+(NSArray *)profilesFromJson:(NSDictionary *)jsonInfo;


@end
