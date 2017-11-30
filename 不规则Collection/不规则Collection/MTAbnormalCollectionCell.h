//
//  CollectionViewCell.h
//  不规则Collection
//
//  Created by 姜泽东 on 2017/10/14.
//  Copyright © 2017年 MaiTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTAbnormalModel.h"

static CGFloat fontSize = 14;

@interface MTAbnormalCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *label;


- (void)setStyleConfig:(MTAbnormalConfigModel *)model;
- (void)setContentText:(__kindof MTAbnormalModel *)model;

- (void)setContentText:(NSString *)title select:(BOOL)isSelected;

@end
