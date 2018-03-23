//
//  ViewController.m
//  不规则Collection
//
//  Created by 姜泽东 on 2017/10/14.
//  Copyright © 2017年 MaiTian. All rights reserved.
//

#import "ViewController.h"
#import "MTAbnormalCollectionCell.h"
#import "AbnormalityLayout.h"
#import <Masonry.h>
#import "MTAbnormalityLabelView.h"
#import "UIView+MTCorner.h"
#import "MTCardView.h"

@interface ViewController ()<UICollectionViewDelegateFlowLayout>
{
    NSArray *_dataSource;
    MTAbnormalityLabelView *_amview;
    NSArray *_testArray;
}
@property (strong, nonatomic) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSArray *array = @[@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",
                       @"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",@"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",
                       @"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",@"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",
                       @"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",@"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",
                       @"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",@"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",
                       @"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",@"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",
                       @"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",@"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",
                       @"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",@"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",
                       @"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",@"w23r23"];
    MTAbnormalityLabelView *abview = [MTAbnormalityLabelView createWithTitles:array config:nil];
    abview.backgroundColor = [UIColor redColor];
    [self.view addSubview:abview];
    [abview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.leading.trailing.equalTo(self.view);
        make.height.equalTo(@100);
    }];
    
    MTCardView *cardView = [[MTCardView alloc] initWithFrame:CGRectZero];
    cardView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:cardView];
    [cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(abview.mas_bottom);
        make.leading.trailing.equalTo(@0);
        make.height.equalTo(@500);
    }];
}


@end
