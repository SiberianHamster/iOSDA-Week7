//
//  Node.h
//  StackOverflowMark
//
//  Created by Mark Lin on 9/28/15.
//  Copyright © 2015 Mark Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject
@property (nonatomic) NSInteger value;
@property (strong, nonatomic) Node *leftNode;
@property (strong, nonatomic) Node *rightNode;

-(BOOL)addValue:(NSInteger)value;

@end
