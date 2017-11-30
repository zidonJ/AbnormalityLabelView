//
//  LayoutModel.h
//  MaiTian
//  Created by 姜泽东 on 2017/11/15.
//  Copyright © 2017年 姜泽东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h" 
@class LayoutModelItem;

@interface LayoutModel : NSObject

/** <#Items#>*/
@property (nonatomic, strong) NSArray<LayoutModelItem *> *Items;

/** <#Type#>*/
@property (nonatomic, copy) NSString *Type;


+ (instancetype)modelWithJson:(id)json;

@end


@interface LayoutModelItem : NSObject

/** <#Picture#>*/
@property (nonatomic, copy) NSString *Picture;

/** <#Item_Title#>*/
@property (nonatomic, copy) NSString *Item_Title;

@end

