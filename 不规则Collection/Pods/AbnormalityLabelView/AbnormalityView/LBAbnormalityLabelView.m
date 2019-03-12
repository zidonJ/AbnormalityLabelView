//
//  LBAbnormalityLabelView.m
//  DrawER
//
//  Created by zidonj on 2018/12/10.
//  Copyright © 2018 langlib. All rights reserved.
//

#import "LBAbnormalityLabelView.h"
#import "LBAbnormalityLayout.h"
#import "LBAbnormalCell.h"
#import <Masonry/Masonry.h>

float kCollectionViewToLeftMargin    = 20;
float kCollectionViewToTopMargin     = 5;
float kCollectionViewToRightMargin   = 20;
float kCollectionViewToBottomtMargin = 5;

static float const kCollectionViewCellsHorizonMargin = 20;

static CGFloat const kAbnormalItemHeight = 25;

static NSString *const kAbNormalityLabelIdentifer = @"abNormalityLabelIdentifer";
static NSString *const kAbNormalityHeaderIdentifer = @"AbNormalityHeaderIdentifer";
static NSString *const kAbNormalityFooterIdentifer = @"AbNormalityFooterIdentifer";

@interface LBAbnormalityLabelView ()
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateAlignedLayout> {
    
    LBAbnormalConfigModel *_configrations;
    
    BOOL _multSelect;
    BOOL _useCommonStyle;
    
    NSInteger _part;
    NSIndexPath *_currentIndex;
    LBAbnormalityLayout *_layout;
}

@property (nonatomic,strong) Class reusableHeaderClass;
@property (nonatomic,strong) Class reusableFooterClass;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign) CGFloat abnormalHeight;
@property (strong, nonatomic) UICollectionView *collectionView;
/** 支持多选的时候 所有选中的标签数据对象*/
@property (strong, nonatomic) NSMutableArray<LBAbnormalModel *> *selectModels;
@property (strong, nonatomic) NSMutableArray<NSNumber *> *configSelectTitles;

@end

@implementation LBAbnormalityLabelView

#pragma mark -- constructor

+ (LBAbnormalityLabelView *)createWithConfigModel:(LBAbnormalConfigModel *)configModel {
    
    return [[self alloc] initWithFrame:CGRectZero config:configModel];
}

#pragma mark -- init

- (instancetype)initWithFrame:(CGRect)frame config:(nullable LBAbnormalConfigModel *)configModel {
    
    self = [super initWithFrame:frame];
    if (self) {
        _canOpsiteSelect = YES;
        _part = configModel.divedebyPart;
        _reusableHeaderClass = configModel.reusableHeaderClass;
        _reusableFooterClass = configModel.reusableFooterClass;
        _currentIndex = nil;
        _configrations = configModel;
        _useCommonStyle = _part != 0;
        _headerHeight = 40;
        _footerHeight = 30;
        [self layoutUI];
    }
    return self;
}

#pragma mark -- public

//单选(手动设置)
- (void)selectAtIndex:(NSIndexPath *)indexPath {
    
    [self setSelectOrNot:YES index:indexPath];
}

- (void)cancelSelectAtIndex:(NSIndexPath *)indexPath {
    
    [self setSelectOrNot:NO index:indexPath];
}

- (void)setSelectOrNot:(BOOL)select index:(NSIndexPath *)indexPath {
    
    if (self.dataSource.count) {
        [_dataSource enumerateObjectsUsingBlock:^(NSArray  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (obj.count && idx == indexPath.section) {
                [obj enumerateObjectsUsingBlock:^(LBAbnormalModel *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (idx == indexPath.item) {
                        obj.selected = select;
                        self->_currentIndex = select?indexPath:nil;
                    }else{
                        obj.selected = NO;
                    }
                }];
            }
        }];
        
    }
    [self.collectionView reloadData];
    
}

- (void)reloadWithTitles:(NSArray<__kindof LBAbnormalModel *> *)titles {
    
    [self.dataSource removeAllObjects];
    [self reloadSectionsWithTitles:@[titles]];
}

- (void)reloadSectionsWithTitles:(NSArray<NSArray<__kindof LBAbnormalModel *> *> *)titles {
    
    [self.dataSource removeAllObjects];
    
    [titles enumerateObjectsUsingBlock:^(NSArray<__kindof LBAbnormalModel *> * _Nonnull objArr, NSUInteger idx, BOOL * _Nonnull stop) {
        [objArr enumerateObjectsUsingBlock:^(__kindof LBAbnormalModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.title = [obj valueForKey:self->_configrations.keyTitle];
            obj.selected = NO;
        }];
    }];
    [self.dataSource addObjectsFromArray:titles];
    [self.collectionView reloadData];
}

#pragma mark -- private
#pragma mark -- UI
- (void)layoutUI {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark -- private func
- (NSString *)getTextWithTitle:(NSIndexPath *)indexPath {
    
    LBAbnormalModel *model = [self getModel:indexPath];
    return [model valueForKey:_configrations.keyTitle.length ? _configrations.keyTitle:@""];
}

- (LBAbnormalModel *)getModel:(NSIndexPath *)indexPath {
    
    if (indexPath.section > _dataSource.count) {
        return nil;
    }
    if (indexPath.item > [_dataSource[indexPath.section] count]) {
        return nil;
    }
    return _dataSource[indexPath.section][indexPath.item];
}

- (float)checkCellLimitWidth:(float)cellWidth {
    
    float limitWidth = (self.collectionView.frame.size.width - kCollectionViewToLeftMargin - kCollectionViewToRightMargin);
    if (cellWidth >= limitWidth) {
        cellWidth = limitWidth - kCollectionViewCellsHorizonMargin;
        return cellWidth < 0 ? 0:cellWidth;
    }
    return cellWidth < 0 ? 0:cellWidth  + 16;
}

#pragma mark -- layoutSubviews

- (void)updateViewHeight {
    
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView.collectionViewLayout prepareLayout];
    //仅修改self.collectionView的高度,xyw值不变
    CGRect rect = CGRectMake(CGRectGetMinX(self.collectionView.frame),
                                           CGRectGetMinY(self.collectionView.frame),
                                           CGRectGetWidth(self.collectionView.frame),
                                           self.collectionView.contentSize.height +
                                           kCollectionViewToTopMargin +
                                           kCollectionViewToBottomtMargin);
    [self completeLayoutHeight:rect.size.height];
}

#pragma mark -- UICollectionViewDelegateAlignedLayout
- (void)completeLayoutHeight:(CGFloat)height {
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
    _abnormalHeight = height;
    if (self.abnormalDelegate && [self.abnormalDelegate respondsToSelector:@selector(completeLayoutHeight:)]) {
        //[self.abnormalDelegate completeLayoutAbnormalHeight:height];
    }
}

- (void)configMutiSelectArray:(__kindof LBAbnormalModel *)model {
    
    if (model.selected) {
        if (![self.selectModels containsObject:model]) {
            [self.selectModels addObject:model];
        }
    }else{
        [self.selectModels removeObject:model];
    }
}

#pragma mark -- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    __kindof LBAbnormalModel *model = [self getModel:indexPath];
    model.indexPath = indexPath;
    if (_multSelect) {//多选
        model.selected = !model.selected;
        [self configMutiSelectArray:model];
    }else{//单选
        if (!_canOpsiteSelect) {//在不能反选的情况下 选中的一定是YES状态
            model.selected = YES;
        }else {
            model.selected = !model.selected;
        }
        if (_currentIndex) { // 默认选中效果
            
            if (![_currentIndex isEqual:indexPath]) {
                LBAbnormalModel *modelBefore = [self getModel:_currentIndex];
                modelBefore.selected = NO;
            }
        }
        _currentIndex = indexPath;
        [self.selectModels removeAllObjects];
        [self.selectModels addObject:model];
    }
    [collectionView reloadData];
    
    if (self.abnormalDelegate && [self.abnormalDelegate respondsToSelector:@selector(singleSelectBack:)]) {
        [self.abnormalDelegate singleSelectBack:model];
    }
    if (self.abnormalDelegate && [self.abnormalDelegate respondsToSelector:@selector(mutilSelectBack:)]) {
        [self.abnormalDelegate mutilSelectBack:self.selectModels];
    }
}

#pragma mark -- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.dataSource.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *view =
        [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                           withReuseIdentifier:kAbNormalityHeaderIdentifer
                                                  forIndexPath:indexPath];
        
        if (self.abnormalDelegate && [self.abnormalDelegate respondsToSelector:@selector(headerSetting:indexPath:)]) {
            [self.abnormalDelegate headerSetting:view indexPath:indexPath];
        }
        return view;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *view =
        [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                           withReuseIdentifier:kAbNormalityFooterIdentifer
                                                  forIndexPath:indexPath];
        view.backgroundColor = [UIColor whiteColor];
        if (self.abnormalDelegate && [self.abnormalDelegate respondsToSelector:@selector(footerSetting:indexPath:)]) {
            [self.abnormalDelegate footerSetting:view indexPath:indexPath];
        }
        return view;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LBAbnormalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAbNormalityLabelIdentifer forIndexPath:indexPath];
    
    CGSize size = [self collectionView:collectionView layout:[UICollectionViewLayout new] sizeForItemAtIndexPath:indexPath];
    cell.label.frame = CGRectMake(0, 0, size.width, size.height);
    cell.label.font = !self.itemFont?[UIFont systemFontOfSize:14]:self.itemFont;
    [cell setContentText:_dataSource[indexPath.section][indexPath.item] configModel:_configrations];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.dataSource[section] count];
}

#pragma mark -- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //不规则的自定义布局需要一个一个的计算标签的宽度 不能一次性返回 相比等分的样式需要更多次数的布局计算
    if (!_useCommonStyle) {
        NSString *text = [self getTextWithTitle:indexPath];
        UIFont *font = !self.itemFont?[UIFont systemFontOfSize:14]:self.itemFont;
        
        CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
        float width = [self checkCellLimitWidth:ceilf(size.width)];
        return CGSizeMake(width, kAbnormalItemHeight);
    }else{
        CGFloat width = self.bounds.size.width
        - kCollectionViewToLeftMargin - kCollectionViewToRightMargin - (_part - 1)*kCollectionViewCellsHorizonMargin;
        return CGSizeMake(width/_part, kAbnormalItemHeight);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return kCollectionViewCellsHorizonMargin;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    return self.reusableHeaderClass ? CGSizeMake(self.frame.size.width, self.headerHeight):CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {

    return self.reusableFooterClass ? CGSizeMake(self.frame.size.width, self.footerHeight):CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(kCollectionViewToTopMargin, kCollectionViewToLeftMargin, kCollectionViewToBottomtMargin, kCollectionViewToRightMargin);
}

#pragma mark -- setters

- (void)setItemInsets:(UIEdgeInsets)itemInsets {
    
    kCollectionViewToLeftMargin = itemInsets.left;
    kCollectionViewToTopMargin = itemInsets.top;
    kCollectionViewToRightMargin = itemInsets.right;
    kCollectionViewToBottomtMargin = itemInsets.bottom;
    _itemInsets = itemInsets;
}

#pragma mark -- getters

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        _layout = [[LBAbnormalityLayout alloc] init];
        _layout.amLayoutDelegate = self;
        _layout.minimumLineSpacing = 20;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        [_collectionView registerClass:[LBAbnormalCell class] forCellWithReuseIdentifier:kAbNormalityLabelIdentifer];
        if (self.reusableHeaderClass) {
            [_collectionView registerClass:self.reusableHeaderClass
                forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                       withReuseIdentifier:kAbNormalityHeaderIdentifer];
        }
        if (self.reusableFooterClass) {
            [_collectionView registerClass:self.reusableFooterClass
                forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                       withReuseIdentifier:kAbNormalityFooterIdentifer];
        }
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (NSMutableArray<LBAbnormalModel *> *)selectModels {
    
    if (!_selectModels) {
        _selectModels = [NSMutableArray array];
    }
    return _selectModels;
}

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)setCollectionInset:(UIEdgeInsets)collectionInset {
    
    _collectionView.contentInset = collectionInset;
    _collectionInset = collectionInset;
}

- (void)dealloc {
    
    NSLog(@"不规则标签释放");
}

@end
