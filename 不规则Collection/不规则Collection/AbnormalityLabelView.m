//
//  AbnormalityLabelView.m
//  不规则Collection
//
//  Created by 姜泽东 on 2017/11/15.
//  Copyright © 2017年 MaiTian. All rights reserved.
//

#import "AbnormalityLabelView.h"
#import "MTAbnormalCollectionCell.h"
#import "AbnormalityLayout.h"
#import <Masonry.h>
#import "LayoutModel.h"
#import "CYLDBManager.h"

static float const kCollectionViewToLeftMargin    = 10;
static float const kCollectionViewToTopMargin     = 10;
static float const kCollectionViewToRightMargin   = 5;
static float const kCollectionViewToBottomtMargin = 15;

static float const kCollectionViewCellsHorizonMargin = 12;

@interface AbnormalityLabelView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateAlignedLayout>

{
    NSArray *_dataSource;
}
@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation AbnormalityLabelView

+ (AbnormalityLabelView *)create
{
    return [[self alloc] initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self uiConfig];
    }
    return self;
}

- (void)uiConfig
{
    AbnormalityLayout *layout = [[AbnormalityLayout alloc] init];
    layout.amLayoutDelegate = self;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[MTAbnormalCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.backgroundColor = [UIColor redColor];
    [self addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    _dataSource = [CYLDBManager allTags];
    [_collectionView reloadData];
}

- (void)layoutSubviews
{
    
    
}

- (void)completeLayoutHeight:(CGFloat)height
{
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MTAbnormalCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    CGSize size = [self collectionView:collectionView layout:[UICollectionViewLayout new] sizeForItemAtIndexPath:indexPath];
    cell.titleButton.frame = CGRectMake(0, 0, size.width, size.height);
    NSString *text = _dataSource[indexPath.row];
//    [cell.titleButton setTitle:text forState:UIControlStateNormal];
//    [cell.titleButton setTitle:text forState:UIControlStateSelected];
    cell.titleButton.text = text;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataSource.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = _dataSource[indexPath.row];
    CGSize size = [text sizeWithAttributes:
                   @{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    float width = [self checkCellLimitWidth:ceilf(size.width)] ;
    return CGSizeMake(width, 30);
}

- (float)checkCellLimitWidth:(float)cellWidth {
    
    float limitWidth = (self.collectionView.contentSize.width - kCollectionViewToLeftMargin - kCollectionViewToRightMargin);
    if (cellWidth >= limitWidth) {
        cellWidth = limitWidth - kCollectionViewCellsHorizonMargin;
        return cellWidth < 0 ? 0:cellWidth;
    }
    return cellWidth < 0 ? 0:cellWidth  + 16 ;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return kCollectionViewCellsHorizonMargin;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(kCollectionViewToTopMargin, kCollectionViewToLeftMargin, kCollectionViewToBottomtMargin, kCollectionViewToRightMargin);
}


@end
