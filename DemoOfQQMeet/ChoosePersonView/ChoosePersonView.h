//
//  ChoosePersonView.h
//  DemoOfQQMeet
//
//  Created by Jian HU on 15/5/8.
//  Copyright (c) 2015年 Wujunqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDCSwipeToChoose.h"
#import "Person.h"

//可以对该view进行定制
@interface ChoosePersonView : MDCSwipeToChooseView

/**
 *  该view对应的person,方便在拖拽时读取
 */
@property (nonatomic,strong) Person *person;

/**
 *  对外方法：view初始化的数据源
 *
 *  @param model Person对象
 */
- (void)initChoosePersonViewWithModel:(Person*)model;

@end
