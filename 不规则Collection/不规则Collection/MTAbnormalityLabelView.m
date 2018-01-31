//
//  AbnormalityLabelView.m
//  不规则Collection
//
//  Created by 姜泽东 on 2017/11/15.
//  Copyright © 2017年 MaiTian. All rights reserved.
//

#import "MTAbnormalityLabelView.h"
#import "MTAbnormalCollectionCell.h"
#import "AbnormalityLayout.h"
#import <Masonry.h>

static float const kCollectionViewToLeftMargin    = 10;
static float const kCollectionViewToTopMargin     = 5;
static float const kCollectionViewToRightMargin   = 10;
static float const kCollectionViewToBottomtMargin = 5;

static float const kCollectionViewCellsHorizonMargin = 12;

static CGFloat const kAbnormalItemHeight = 30;

@interface MTAbnormalityLabelView()
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateAlignedLayout>

{
    NSArray *_dataSource;
    MTAbnormalConfigModel *_configrations;
    
    BOOL _useModel;
    BOOL _multSelect;
    BOOL _useCommonStyle;
    
    BOOL _isStable;
    NSInteger _part;
    NSInteger _currentIndex;
}

@property (nonatomic,assign) CGFloat abnormalHeight;
@property (strong, nonatomic) UICollectionView *collectionView;
/** 支持多选的时候 所有选中的标签数据对象*/
@property (strong, nonatomic) NSMutableArray<MTAbnormalModel *> *selectModels;
@property (strong, nonatomic) NSMutableArray<NSNumber *> *configSelectTitles;

@end

@implementation MTAbnormalityLabelView

#pragma mark -- constructor

+ (MTAbnormalityLabelView *)createWithTitles:(NSArray<NSString *> *)titles config:(MTAbnormalConfigModel *)configrations
{
    return [[self alloc] initWithFrame:CGRectZero titles:titles useModel:NO divedeby:0 config:configrations];
}

+ (MTAbnormalityLabelView *)createWithModels:(NSArray<__kindof MTAbnormalModel *> *)models
                                      config:(MTAbnormalConfigModel *)configrations
{
    return [[self alloc] initWithFrame:CGRectZero titles:models useModel:YES divedeby:0 config:configrations];
}

+ (MTAbnormalityLabelView *)createWithCommonStyle:(NSArray<__kindof MTAbnormalModel *> *)models divedeby:(NSInteger)part config:(MTAbnormalConfigModel *)configrations
{
    return [[self alloc] initWithFrame:CGRectZero titles:models useModel:YES divedeby:part config:configrations];
}

+ (MTAbnormalityLabelView *)createTitlesCommonStyle:(NSArray<NSString *> *)titles divedeby:(NSInteger)part config:(MTAbnormalConfigModel *)configrations
{
    return [[self alloc] initWithFrame:CGRectZero titles:titles useModel:NO divedeby:part config:configrations];
}

#pragma mark -- init

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles useModel:(BOOL)useModel divedeby:(NSInteger)part config:(MTAbnormalConfigModel *)configrations
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _part = part;
        [self dataSource:titles useModel:useModel config:configrations];
        [self uiConfig];
    }
    return self;
}

#pragma mark -- public

- (void)setDefaultSelect:(NSInteger)index
{
    _currentIndex = index;
    if (_useModel && _dataSource.count && _currentIndex != -1) {
        _currentIndex = index;
        MTAbnormalModel *model = _dataSource[index];
        model.selected = YES;
        [self configMutiSelectArray:model];
    }
}

- (void)setDefaultSelected:(NSNumber *)indexs, ...
{
    [self setDefaultSelect:indexs.integerValue];
    NSNumber *param;
    va_list arg_list;
    va_start(arg_list, indexs);
    if (index >= 0) {
        while ((param = va_arg(arg_list, NSNumber *))) {
            
            NSInteger tempIndex = param.integerValue;
            [self setDefaultSelect:tempIndex];
        }
        //取完之后毁掉va_list指针
        va_end(arg_list);
    }
}

//单选(手动设置)
- (void)selectAtIndex:(NSInteger)index {
    _currentIndex = index;
    if (_useModel && _dataSource.count && _currentIndex != -1) {
        _currentIndex = index;
        [_dataSource enumerateObjectsUsingBlock:^(MTAbnormalModel *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.selected = false;
        }];
        MTAbnormalModel *model = _dataSource[index];
        model.selected = YES;
    }
    [self.collectionView reloadData];
}

- (void)cancelSelectAtIndex:(NSInteger)index {
    MTAbnormalModel *model = [_dataSource objectAtIndex:index];
    model.selected = false;
    [self.collectionView reloadData];
}

- (void)canMultipleSelect:(BOOL)multSelect
{
    _multSelect = multSelect;
}

- (void)setOneLineHeightStable:(BOOL)stable
{
    _isStable = stable;
}

- (void)reloadWithData:(NSArray<MTAbnormalModel *> *)models
{
    _dataSource = models;
    //[self.selectModels removeAllObjects];
    //_currentIndex = -1;
    [self setDefaultSelect:_currentIndex];
    [_dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MTAbnormalModel *model = (MTAbnormalModel *)obj;
        [self configMutiSelectArray:model];
    }];
    [self.collectionView reloadData];
}

- (void)reloadWithTitles:(NSArray<NSString *> *)titles
{
    _dataSource = titles;
    [self.configSelectTitles removeAllObjects];
    //记住单选时的选中效果
    for(int i=0; i < _dataSource.count; i++){
        if (_currentIndex >= 0) {
            [self.configSelectTitles addObject:@YES];
        }else{
            [self.configSelectTitles addObject:@NO];
        }
    }
    [self.collectionView reloadData];
}

#pragma mark -- private
#pragma mark -- UI
- (void)uiConfig
{
    AbnormalityLayout *layout = [[AbnormalityLayout alloc] init];
    layout.amLayoutDelegate = self;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[MTAbnormalCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark -- private func
- (NSString *)getTextWithRow:(NSInteger)row
{
    return _useModel?[_dataSource[row] valueForKey:@"text"]:_dataSource[row];
}

- (float)checkCellLimitWidth:(float)cellWidth {
    
    float limitWidth = (self.collectionView.contentSize.width - kCollectionViewToLeftMargin - kCollectionViewToRightMargin);
    if (cellWidth >= limitWidth) {
        cellWidth = limitWidth - kCollectionViewCellsHorizonMargin;
        return cellWidth < 0 ? 0:cellWidth;
    }
    return cellWidth < 0 ? 0:cellWidth  + 16;
}

- (void)dataSource:(NSArray *)dataSource useModel:(BOOL)useModel config:(MTAbnormalConfigModel *)configrations
{
    _currentIndex = -1;
    _dataSource = dataSource;
    _useModel = useModel;
    _configrations = configrations;
    _useCommonStyle = _part != 0;
    if (!_useModel) {
        for(int i=0;i<dataSource.count;i++){
            [self.configSelectTitles addObject:@NO];
        }
    }
}

#pragma mark -- layoutSubviews
- (void)layoutSubviews
{
    [_collectionView reloadData];
}

#pragma mark -- UICollectionViewDelegateAlignedLayout
- (void)completeLayoutHeight:(CGFloat)height
{
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
    _abnormalHeight = height;
    if (self.abnormalDelegate && [self.abnormalDelegate respondsToSelector:@selector(completeLayoutHeight:)]) {
        [self.abnormalDelegate completeLayoutAbnormalHeight:height];
    }
}

- (BOOL)isStableHeight
{
    return _isStable;
}

- (void)configMutiSelectArray:(__kindof MTAbnormalModel *)model
{
    if (model.selected) {
        [self.selectModels addObject:model];
    }else{
        [self.selectModels removeObject:model];
    }
}

#pragma mark -- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MTAbnormalCollectionCell *cell = (MTAbnormalCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (_useModel) {
        MTAbnormalModel *model = (MTAbnormalModel *)_dataSource[indexPath.item];
        model.selected = !model.selected;
        [cell setContentText:model];
        
        if (_multSelect) {//多选
            [self configMutiSelectArray:model];
        }else{//单选
            if (_currentIndex >= 0) {
                if (_currentIndex != indexPath.item) {
                    MTAbnormalModel *modelBefore = (MTAbnormalModel *)_dataSource[_currentIndex];
                    modelBefore.selected = NO;
                    NSIndexPath *index = [NSIndexPath indexPathForItem:_currentIndex inSection:0];
                    [collectionView reloadItemsAtIndexPaths:@[index]];
                }
            }
            _currentIndex = indexPath.item;
        }
        
        if (self.abnormalDelegate && [self.abnormalDelegate respondsToSelector:@selector(clickCallBack:index:)]) {
            [self.abnormalDelegate clickCallBack:model index:indexPath.item];
        }
        
        if (self.abnormalDelegate &&
            [self.abnormalDelegate respondsToSelector:@selector(clickCallBack:mutilArray:index:)]) {
            [self.abnormalDelegate clickCallBack:model mutilArray:self.selectModels index:indexPath.item];
        }
    }else{
        
        self.configSelectTitles[indexPath.item] = @(![self.configSelectTitles[indexPath.item] boolValue]);
        BOOL selected = [self.configSelectTitles[indexPath.item] boolValue];
        if (_currentIndex >= 0) {
            if (_currentIndex != indexPath.item) {
                
                self.configSelectTitles[_currentIndex] = @NO;
                NSIndexPath *index = [NSIndexPath indexPathForItem:_currentIndex inSection:0];
                [collectionView reloadItemsAtIndexPaths:@[index]];
            }
        }
        _currentIndex = indexPath.item;
        [cell setContentText:_dataSource[indexPath.item] select:selected];
        if (self.abnormalDelegate && [self.abnormalDelegate respondsToSelector:@selector(clickTitlesBack:index:selected:)]) {
            [self.abnormalDelegate clickTitlesBack:_dataSource[indexPath.item] index:indexPath.item selected:selected];
        }
    }
}

#pragma mark -- UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MTAbnormalCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    CGSize size = [self collectionView:collectionView layout:[UICollectionViewLayout new] sizeForItemAtIndexPath:indexPath];
    cell.label.frame = CGRectMake(0, 0, size.width, size.height);
    NSString *text = [self getTextWithRow:indexPath.item];
    [cell setStyleConfig:_configrations];
    if (_useModel) {
        
        [cell setContentText:_dataSource[indexPath.item]];
    }else{
        //cell.label.text = text;
        [cell setContentText:_dataSource[indexPath.item] select:[self.configSelectTitles[indexPath.item] boolValue]];
    }
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataSource.count;
}


#pragma mark -- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //不规则的自定义布局需要一个一个的计算标签的宽度 不能一次性返回 相比等分的样式需要更多次数的布局计算
    if (!_useCommonStyle) {
        NSString *text = [self getTextWithRow:indexPath.row];
        UIFont *font = (_configrations==nil || _configrations.fontSize<=0)?[UIFont systemFontOfSize:fontSize]:[UIFont systemFontOfSize:_configrations.fontSize];
        //[UIFont systemFontOfSize:fontSize]
        CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
        float width = [self checkCellLimitWidth:ceilf(size.width)];
        return CGSizeMake(width, kAbnormalItemHeight);
    }else{
        CGFloat width = [UIScreen mainScreen].bounds.size.width
        - kCollectionViewToLeftMargin - kCollectionViewToRightMargin - (_part - 1)*kCollectionViewCellsHorizonMargin;
        return CGSizeMake(width/_part, kAbnormalItemHeight);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return kCollectionViewCellsHorizonMargin;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(kCollectionViewToTopMargin, kCollectionViewToLeftMargin, kCollectionViewToBottomtMargin, kCollectionViewToRightMargin);
}

#pragma mark -- getters

- (NSMutableArray<MTAbnormalModel *> *)selectModels
{
    if (!_selectModels) {
        _selectModels = [NSMutableArray array];
    }
    return _selectModels;
}

- (NSMutableArray<NSNumber *> *)configSelectTitles
{
    if (!_configSelectTitles) {
        _configSelectTitles = [NSMutableArray array];
    }
    return _configSelectTitles;
}
@end

