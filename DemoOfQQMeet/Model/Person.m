//
//  Person.m
//  DemoOfQQMeet
//
//  Created by Jian HU on 15/5/8.
//  Copyright (c) 2015年 Wujunqiu. All rights reserved.
//

#import "Person.h"

static Person *myPerson = nil;

@implementation Person

+(Person *)shareManager
{
    @synchronized(self){
        static dispatch_once_t pred;
        dispatch_once(&pred,^{
            myPerson = [[self alloc]init];
        });
    }
    return myPerson;
}

- (id)init
{
    self = [super init];
    if (self) {
        allPersonsArray = [NSMutableArray array];
    }
    return self;
}

- (NSMutableArray *)allPersons
{
    return [self creatPersonWithDic:nil];;
}

- (NSMutableArray *)creatPersonWithDic:(NSDictionary *)dic
{
    [allPersonsArray removeAllObjects];
    NSArray *images = @[@"finn",@"prince",@"jake",@"prince"];
    for (int  i = 0; i <4; i ++) {
        Person *person = [[Person alloc]init];
        person.personImageUrl = images[i];
        person.personName = images[i];
        [allPersonsArray addObject:person];
    }
    return allPersonsArray;
}

@end
