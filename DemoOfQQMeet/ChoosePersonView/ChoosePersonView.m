//
//  ChoosePersonView.m
//  DemoOfQQMeet
//
//  Created by Jian HU on 15/5/8.
//  Copyright (c) 2015年 Wujunqiu. All rights reserved.
//

#import "ChoosePersonView.h"

@implementation ChoosePersonView
@synthesize person;

- (id)initWithFrame:(CGRect)frame options:(MDCSwipeToChooseViewOptions *)options
{
    self = [super initWithFrame:frame options:options];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleBottomMargin;
    }
    return self;
}

- (void)initChoosePersonViewWithModel:(Person*)model
{
    self.imageView.image = [UIImage imageNamed:model.personImageUrl];
    self.imageView.autoresizingMask = self.autoresizingMask;
    person = model;
}


@end
