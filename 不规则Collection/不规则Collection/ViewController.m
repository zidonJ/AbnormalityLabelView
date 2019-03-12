//
//  ViewController.m
//  不规则Collection
//
//  Created by 姜泽东 on 2017/10/14.
//  Copyright © 2017年 MaiTian. All rights reserved.
//

#import "ViewController.h"
#import "LBAbnormalityLabelView.h"
#import "LBDrawerShowView.h"
#import <Masonry.h>
#import "UIView+Corner.h"
#import "MTCardView.h"
#import "MTSimpleFuncAble.h"

@interface ViewController ()<LBAbnormalityLabelViewDelegate>
{
    NSArray *_dataSource;
    NSArray *_testArray;
    LBAbnormalityLabelView *_abView;
}
@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic,strong) LBDrawerShowView *drawerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MTCardView *cardView = [[MTCardView alloc] initWithFrame:CGRectZero];
    cardView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:cardView];
    [cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.leading.trailing.equalTo(@0);
        make.height.equalTo(@500);
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSArray *array = @[@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",
                       @"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",@"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",
                       @"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",@"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",
                       @"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",@"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",
                       @"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",@"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",
                       @"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",@"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",
                       @"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",@"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",
                       @"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",@"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",
                       @"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",@"w23r23"];
    
    NSMutableArray *mtarr = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LBAbnormalModel *model = [LBAbnormalModel new];
        model.title = obj;
        [mtarr addObject:model];
    }];
    _abView = [LBAbnormalityLabelView createWithConfigModel:[self simpleGetConfigModel]];
    _abView.multSelect = NO;
    _abView.canOpsiteSelect = NO;
    _abView.collectionInset = UIEdgeInsetsMake(30 + (IsXScreen() ? 15:0), 0, 0, 0);
    _abView.abnormalDelegate = self;
    [self.drawerView addSubview:_abView];
    [_abView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.leading.equalTo(@0);
        make.width.equalTo(@(260));
        make.bottom.equalTo(@0);
    }];
    [self.drawerView setNeedShowView:_abView width:260];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self->_abView reloadWithTitles:mtarr];
        [self.drawerView show];
    });
    
}

- (LBDrawerShowView *)drawerView {
    if (!_drawerView) {
        _drawerView = [[LBDrawerShowView alloc] initWithDrawerType:RightDrawer];
    }
    return _drawerView;
}

- (LBAbnormalConfigModel *)simpleGetConfigModel {
    
    LBAbnormalConfigModel *model = [LBAbnormalConfigModel new];
    model.reusableFooterClass = UICollectionReusableView.class;
    model.backGroundColor = ssRGBHex(0xF8F8F9);
    model.selectBackGroundColor = ssRGBHex(0xF8A920);
    model.textColor = ssRGBHex(0x333333);
    model.selectTextColor = ssRGBHex(0xFFFFFF);
    model.radius = 15;
    model.keyTitle = @"title";
    return model;
}


@end
