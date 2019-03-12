//
//  LBAbnormalCell.h
//  DrawER
//
//  Created by zidonj on 2018/12/10.
//  Copyright © 2018 langlib. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBAbnormalModel.h"

NS_ASSUME_NONNULL_BEGIN

static CGFloat fontSize = 14;

@interface LBAbnormalCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *label;


- (void)setContentText:(__kindof LBAbnormalModel *)model configModel:(LBAbnormalConfigModel *)cmodel;

@end

NS_ASSUME_NONNULL_END
