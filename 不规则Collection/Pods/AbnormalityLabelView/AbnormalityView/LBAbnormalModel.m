//
//  LBAbnormalModel.m
//  DrawER
//
//  Created by zidonj on 2018/12/10.
//  Copyright © 2018 langlib. All rights reserved.
//

#import "LBAbnormalModel.h"

@implementation LBAbnormalModel

- (NSIndexPath *)indexPath {
    
    if (!_indexPath) {
        _indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    }
    return _indexPath;
}

@end

@implementation LBAbnormalConfigModel



@end
