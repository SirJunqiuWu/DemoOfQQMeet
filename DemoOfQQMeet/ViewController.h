//
//  ViewController.h
//  DemoOfQQMeet
//
//  Created by Jian HU on 15/5/8.
//  Copyright (c) 2015年 Wujunqiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoosePersonView.h"

@interface ViewController : UIViewController <MDCSwipeToChooseDelegate>

@property (nonatomic, strong) Person *currentPerson;
@property (nonatomic, strong) ChoosePersonView *frontCardView;
@property (nonatomic, strong) ChoosePersonView *backCardView;
@property (nonatomic, strong) NSMutableArray *persons;

@end

