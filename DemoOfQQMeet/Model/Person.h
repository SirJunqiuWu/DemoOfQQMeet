//
//  Person.h
//  DemoOfQQMeet
//
//  Created by Jian HU on 15/5/8.
//  Copyright (c) 2015年 Wujunqiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

{
    NSMutableArray *allPersonsArray;
}

/**
 *  头像
 */
@property (nonatomic,strong) NSString *personImageUrl;

/**
 *  名字
 */
@property (nonatomic,strong) NSString *personName;

+ (Person *)shareManager;

- (NSMutableArray *)allPersons;

- (NSMutableArray *)creatPersonWithDic:(NSDictionary *)dic;


@end
