//
//  Node.m
//  StackOverflowMark
//
//  Created by Mark Lin on 9/28/15.
//  Copyright © 2015 Mark Lin. All rights reserved.
//

#import "Node.h"

@implementation Node


-(BOOL)addValue:(NSInteger)value {
  if (value == self.value) {
    return false;
  } else{
    if (value < self.value) {
            //move left
      if (!self.leftNode) {
        Node *node = [[Node alloc]init];
        node.value = value;
        self.leftNode = node;
        return true;
      } else
      {return [self.leftNode addValue:value];}
    }
    else {
      //move right
      if (!self.rightNode){
        Node *node = [[Node alloc]init];
        node.value = value;
        self.rightNode = node;
        return true;
      }else{
        return [self.rightNode addValue:value];
      }
    }
  }
}

@end
