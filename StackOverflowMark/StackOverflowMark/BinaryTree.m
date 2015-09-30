//
//  BinaryTree.m
//  StackOverflowMark
//
//  Created by Mark Lin on 9/28/15.
//  Copyright © 2015 Mark Lin. All rights reserved.
//

#import "BinaryTree.h"
#import "Node.h"

@interface BinaryTree ()
@property (retain, nonatomic) Node *root;
@end

@implementation BinaryTree

-(BOOL)addValue:(NSInteger)value{
  if (!self.root) {
    Node *root = [[Node alloc]init];
    root.value = value;
    self.root = root;
    return true;
  }else{
    return [self.root addValue:value];
  }
  

}


@end
