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
#import "LayoutModel.h"
#import "CYLDBManager.h"
#import "MTAbnormalityLabelView.h"

static float const kCollectionViewToLeftMargin    = 10;
static float const kCollectionViewToTopMargin     = 5;
static float const kCollectionViewToRightMargin   = 5;
static float const kCollectionViewToBottomtMargin = 15;

static float const kCollectionViewCellsHorizonMargin = 12;


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegateAlignedLayout>
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
    
//    NSInteger temp = 20;
//    void (^test) (NSInteger a) = ^(NSInteger a){
//
////        NSInteger b = a + 5;
////        NSLog(@"%ld",(long)b);
//        NSLog(@"%ld",temp);
//    };
//    temp = 10;
//    test(temp);
//
//    AbnormalityLayout *layout = [[AbnormalityLayout alloc] init];
//    layout.amLayoutDelegate = self;
//    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
////    _collectionView.delegate = self;
////    _collectionView.dataSource = self;
//    [_collectionView registerClass:[MTAbnormalCollectionCell class] forCellWithReuseIdentifier:@"cell"];
//    _collectionView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:_collectionView];
//    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.top.trailing.equalTo(self.view);
//        make.height.equalTo(@(self.view.frame.size.height));
//    }];
//    _collectionView.hidden = YES;
//
//    [self.view layoutIfNeeded];

    _dataSource = [CYLDBManager allTags];
//    [_collectionView reloadData];
    
    
//    MTAbnormalityLabelView *amview = [MTAbnormalityLabelView createWithTitles:_dataSource config:nil];
//    [self.view addSubview:amview];
//    _amview = amview;
//    [amview mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.leading.top.trailing.equalTo(self.view);
//        make.height.equalTo(@(10));
//    }];
    
    NSArray *array = @[@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",@"w23r23",@"askdjfhkasjdf",@"历史江东索朗多吉疯了",@"jojo",@"123456789",@"w23r23"];
    MTAbnormalityLabelView *abview = [MTAbnormalityLabelView createWithTitles:array config:nil];
    abview.backgroundColor = [UIColor redColor];
    //MTAbnormalityLabelView *abview = [MTAbnormalityLabelView createTitlesCommonStyle:array divedeby:4 config:nil];
    //abview.abnormalDelegate = self;
    //[abview setOneLineHeightStable:YES];
    [self.view addSubview:abview];
    [abview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.leading.trailing.equalTo(self.view);
        make.height.equalTo(@100);
    }];
}

//- (void)completeLayoutHeight:(CGFloat)height
//{
//    [_collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@(height));
//    }];
//}

//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    MTAbnormalCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
////    [cell.titleButton setTitle:[NSString stringWithFormat:@"%ld",indexPath.row] forState:UIControlStateNormal];
//
//    CGSize size = [self collectionView:collectionView layout:nil sizeForItemAtIndexPath:indexPath];
//    cell.titleButton.frame = CGRectMake(0, 0, size.width, size.height);
//    NSString *text = _dataSource[indexPath.row];
////    [cell.titleButton setTitle:text forState:UIControlStateNormal];
////    [cell.titleButton setTitle:text forState:UIControlStateSelected];
//
//    return cell;
//}
//
//- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//
//    return _dataSource.count;
//}

//- (CGSize)collectionView:(UICollectionView *)collectionView
//                  layout:(UICollectionViewLayout *)collectionViewLayout
//  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *text = _dataSource[indexPath.row];
//    CGSize size = [text sizeWithAttributes:
//                   @{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
//    float width = [self checkCellLimitWidth:ceilf(size.width)] ;
//    return CGSizeMake(width, 30);
//}
//
//- (float)checkCellLimitWidth:(float)cellWidth {
//
//    float limitWidth = (self.collectionView.contentSize.width - kCollectionViewToLeftMargin - kCollectionViewToRightMargin);
//    if (cellWidth >= limitWidth) {
//        cellWidth = limitWidth - kCollectionViewCellsHorizonMargin;
//        return cellWidth;
//    }
//    return cellWidth + 16 ;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//
//    return kCollectionViewCellsHorizonMargin;
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
//                        layout:(UICollectionViewLayout *)collectionViewLayout
//        insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(kCollectionViewToTopMargin, kCollectionViewToLeftMargin, kCollectionViewToBottomtMargin, kCollectionViewToRightMargin);
//}

@end
