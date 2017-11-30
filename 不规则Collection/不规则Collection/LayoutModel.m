//
//  LayoutModel.m
//  MaiTian
//  Created by 姜泽东 on 2017/11/15.
//  Copyright © 2017年 姜泽东. All rights reserved.
//

#import "LayoutModel.h"


@implementation LayoutModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id",@"DESCRIPTION":@"discription"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"Items" : @"LayoutModelItem"};
}
+ (instancetype)modelWithJson:(id)json
{
    id model = nil;
    if ([json isKindOfClass:[NSString class]] || [json isKindOfClass:[NSDictionary class]]){
        model = [self mj_objectWithKeyValues:json];
    }else if([json isKindOfClass:[NSArray class]]){
        model = [self mj_objectArrayWithKeyValuesArray:json];
    }
    return model;
}

@end


@implementation LayoutModelItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id",@"DESCRIPTION":@"discription"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{};
}

@end
