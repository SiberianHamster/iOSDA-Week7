//
//  QuestionTableViewCell.h
//  StackOverflowMark
//
//  Created by Mark Lin on 9/20/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *Image;
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *Title;

@end
