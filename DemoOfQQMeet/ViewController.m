//
//  ViewController.m
//  DemoOfQQMeet
//
//  Created by Jian HU on 15/5/8.
//  Copyright (c) 2015年 Wujunqiu. All rights reserved.
//

#import "ViewController.h"

static const CGFloat ChoosePersonButtonHorizontalPadding = 80.f;
static const CGFloat ChoosePersonButtonVerticalPadding = 20.f;

@interface ViewController ()

@end

@implementation ViewController
@synthesize persons;
@synthesize frontCardView,backCardView;

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"巧遇";
        persons = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    persons = [[Person shareManager]allPersons];
    
    frontCardView = [self popPersonViewWithFrame:[self frontCardViewFrame]];
    [self.view addSubview:frontCardView];
    
    backCardView = [self popPersonViewWithFrame:[self backCardViewFrame]];
    [self.view insertSubview:backCardView belowSubview:frontCardView];
    
    [self crateDeleteButton];[self createLikedButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (ChoosePersonView *)popPersonViewWithFrame:(CGRect)frame {
    if ([persons count] == 0) {
        /**
         *  这样赋值，可以循环拖拽
         */
        persons = [[Person shareManager]allPersons];
    }
    MDCSwipeToChooseViewOptions *options = [[MDCSwipeToChooseViewOptions alloc]init];
    options.delegate = self;
    options.threshold = 160.f;
    options.nopeText = @"Delete";
    options.likedText = @"Like";
    options.onPan = ^(MDCPanState *state){
        CGRect frame = [self backCardViewFrame];
        self.backCardView.frame = CGRectMake(frame.origin.x,
                                             frame.origin.y - (state.thresholdRatio * 10.f),
                                             CGRectGetWidth(frame),
                                             CGRectGetHeight(frame));
    };
    
    ChoosePersonView *personView = [[ChoosePersonView alloc] initWithFrame:frame options:options];
    [personView initChoosePersonViewWithModel:persons[0]];
    [persons removeObjectAtIndex:0];
    return personView;
}


#pragma mark - Get View Rect

- (CGRect)frontCardViewFrame {
    CGFloat horizontalPadding = 20.f;
    CGFloat topPadding = 80.f;
    CGFloat bottomPadding = 200.f;
    return CGRectMake(horizontalPadding,
                      topPadding,
                      CGRectGetWidth(self.view.frame) - (horizontalPadding * 2),
                      CGRectGetHeight(self.view.frame) - bottomPadding);
}

- (CGRect)backCardViewFrame {
    /**
     *  后面的view.frame.origin.y 比前一个大10，可以调节错位显示
     */
    CGRect frontFrame = [self frontCardViewFrame];
    return CGRectMake(frontFrame.origin.x,
                      frontFrame.origin.y + 10.f,
                      CGRectGetWidth(frontFrame),
                      CGRectGetHeight(frontFrame));
}

#pragma mark - MDCSwipeToChooseDelegate

// This is called when a user didn't fully swipe left or right.
- (void)viewDidCancelSwipe:(UIView *)view {
    if ([view isKindOfClass:[ChoosePersonView class]]) {
        ChoosePersonView *tempChooseView = (ChoosePersonView *) view;
        NSLog(@"You couldn't decide on person:%@",tempChooseView.person.personName);
    }
}

// This is called then a user swipes the view fully left or right.
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    // MDCSwipeToChooseView shows "NOPE" on swipes to the left,
    // and "LIKED" on swipes to the right.
    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"You noped");
        //可以针对该视图做相应处理,根据它的属性Person对象
    } else {
        NSLog(@"You liked");
    }
    
    // MDCSwipeToChooseView removes the view from the view hierarchy
    // after it is swiped (this behavior can be customized via the
    // MDCSwipeOptions class). Since the front card view is gone, we
    // move the back card to the front, and create a new back card.
    
    self.frontCardView = self.backCardView;
    if ((self.backCardView = [self popPersonViewWithFrame:[self backCardViewFrame]])) {
        // Fade the back card into view.
        self.backCardView.alpha = 0.f;
        [self.view insertSubview:self.backCardView belowSubview:self.frontCardView];
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.backCardView.alpha = 1.f;
                         } completion:nil];
    }
}

#pragma mark - Create Delete And Like Button

- (void)crateDeleteButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *image = [UIImage imageNamed:@"nope"];
    button.frame = CGRectMake(ChoosePersonButtonHorizontalPadding,
                              CGRectGetMaxY(self.backCardView.frame) + ChoosePersonButtonVerticalPadding,
                              image.size.width,
                              image.size.height);
    [button setImage:image forState:UIControlStateNormal];
    [button setTintColor:[UIColor colorWithRed:247.f/255.f
                                         green:91.f/255.f
                                          blue:37.f/255.f
                                         alpha:1.f]];
    [button addTarget:self  action:@selector(deleteFrontCardView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)createLikedButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *image = [UIImage imageNamed:@"liked"];
    button.frame = CGRectMake(CGRectGetMaxX(self.view.frame) - image.size.width - ChoosePersonButtonHorizontalPadding,
                              CGRectGetMaxY(self.backCardView.frame) + ChoosePersonButtonVerticalPadding,
                              image.size.width,
                              image.size.height);
    [button setImage:image forState:UIControlStateNormal];
    [button setTintColor:[UIColor colorWithRed:29.f/255.f
                                         green:245.f/255.f
                                          blue:106.f/255.f
                                         alpha:1.f]];
    [button addTarget:self action:@selector(likeFrontCardView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark Control Events

- (void)deleteFrontCardView {
    [self.frontCardView mdc_swipe:MDCSwipeDirectionLeft];
}

- (void)likeFrontCardView {
    [self.frontCardView mdc_swipe:MDCSwipeDirectionRight];
}


@end
