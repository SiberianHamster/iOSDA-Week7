//
//  ProfileJSONParser.m
//  StackOverflowMark
//
//  Created by Mark Lin on 9/21/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

#import "ProfileJSONParser.h"
#import "Profile.h"







@implementation ProfileJSONParser




+(NSMutableArray *)profilesFromJson:(NSDictionary *)jsonInfo {
  NSLog(@"json: %@",jsonInfo);
  
  NSArray *profiles = [[NSArray alloc] init];
  NSMutableArray *profilez = [[NSMutableArray alloc] init];

  profiles = jsonInfo[@"items"];
  for(NSDictionary *item in profiles) {
    Profile *profile = [[Profile alloc] init];
    profile.profileName = item[@"display_name"];
    profile.profileImage = item[@"profile_image"];
    profile.reputation = item[@"reputation"];
    [profilez addObject:profile];
  }
  
  return profilez;
}
@end
