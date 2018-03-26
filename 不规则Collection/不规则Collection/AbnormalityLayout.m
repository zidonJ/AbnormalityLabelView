//
//  AbnormalityLayout.m
//  不规则Collection
//
//  Created by 姜泽东 on 2017/10/14.
//  Copyright © 2017年 MaiTian. All rights reserved.
//

#import "AbnormalityLayout.h"

@interface UICollectionViewLayoutAttributes (LeftAligned)

- (void)alignFrameWithSectionInset:(UIEdgeInsets)sectionInset;

@end

@implementation UICollectionViewLayoutAttributes (LeftAligned)

- (void)alignFrameWithSectionInset:(UIEdgeInsets)sectionInset
{
    CGRect frame = self.frame;
    frame.origin.x = sectionInset.left;
    self.frame = frame;
}

@end

@interface AbnormalityLayout()
{
    CGFloat _completeContentSizeHeight;
}

@end

@implementation AbnormalityLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.maxSizeHeight = 500;
    }
    return self;
}

#pragma mark - UICollectionViewLayout

//第一次布局的时候还没有获取到代理返回的宽度(不规则标签需要单独计算每个Item的宽度 不能一次行全部返回)
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    NSArray *attributesToReturn = [[NSArray alloc] initWithArray:array copyItems:YES];
    BOOL isStable = false;
    if (self.amLayoutDelegate && [self.amLayoutDelegate respondsToSelector:@selector(isStableHeight)]) {
         isStable = [self.amLayoutDelegate isStableHeight];
    }
    
    UICollectionViewLayoutAttributes *last = attributesToReturn.lastObject;
    for (UICollectionViewLayoutAttributes *attributes in attributesToReturn) {
        //header or footer。为cell时 则为nil
        if (nil == attributes.representedElementKind) {
            NSIndexPath *indexPath = attributes.indexPath;
            attributes.frame = [self layoutAttributesForItemAtIndexPath:indexPath].frame;
            if (CGRectGetMaxY(attributes.frame) > self.collectionView.frame.size.height && isStable) {
                attributes.hidden = YES;
            }
        }
    }
    
    CGFloat height = -1;
    if (attributesToReturn.count) {
        UIEdgeInsets sectionInset;
        if (!isStable) {
            sectionInset = [self evaluatedSectionInsetForItemAtIndex:0];
            height = last.frame.origin.y + last.frame.size.height + sectionInset.bottom;
            _completeContentSizeHeight = height;
            [self.amLayoutDelegate completeLayoutHeight:MIN(self.maxSizeHeight, _completeContentSizeHeight)];
            
        }else{
            id<UICollectionViewDelegateAlignedLayout> delegate = (id<UICollectionViewDelegateAlignedLayout>)self.collectionView.delegate;
            CGSize size = [delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
            sectionInset = [self evaluatedSectionInsetForItemAtIndex:0];
            height = size.height + sectionInset.top + sectionInset.bottom;
            _completeContentSizeHeight = height;
            [self.amLayoutDelegate completeLayoutHeight:MIN(self.maxSizeHeight, _completeContentSizeHeight)];
        }
    }
    /*
     当更新后的高度与实际高度相等的时候 不规则标签会发生错乱
     这个时候不规则标签的宽度还是0 没有确定下来 需要更多次数的布局
     */
    if (last.frame.size.width == 0 && height == self.collectionView.frame.size.height) {
        [self.collectionView reloadData];
    }
    
    return attributesToReturn;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *currentItemAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    UIEdgeInsets sectionInset = [self evaluatedSectionInsetForItemAtIndex:indexPath.section];
    
    BOOL isFirstItemInSection = indexPath.item == 0;

    CGFloat layoutWidth = CGRectGetWidth(self.collectionView.frame) - sectionInset.left - sectionInset.right;
    if (isFirstItemInSection) {
        [currentItemAttributes alignFrameWithSectionInset:sectionInset];
        return currentItemAttributes;
    }
    
    NSIndexPath *previousIndexPath = [NSIndexPath indexPathForItem:indexPath.item-1 inSection:indexPath.section];
    CGRect previousFrame = [self layoutAttributesForItemAtIndexPath:previousIndexPath].frame;
    
    CGFloat previousFrameRightPoint = previousFrame.origin.x + previousFrame.size.width;
    CGRect currentFrame = currentItemAttributes.frame;
    CGRect strecthedCurrentFrame = CGRectMake(sectionInset.left,
                                              currentFrame.origin.y,
                                              layoutWidth,
                                              currentFrame.size.height);
    
    // if the current frame, once left aligned to the left and stretched to the full collection view
    // widht intersects the previous frame then they are on the same line
    BOOL isFirstItemInRow = !CGRectIntersectsRect(previousFrame, strecthedCurrentFrame);
    
    if (isFirstItemInRow) {
        // make sure the first item on a line is left aligned
        [currentItemAttributes alignFrameWithSectionInset:sectionInset];
        return currentItemAttributes;
    }
    
    CGRect frame = currentItemAttributes.frame;
    frame.origin.x = previousFrameRightPoint + [self evaluatedMinimumInteritemSpacingForItemAtIndex:indexPath.item];
    currentItemAttributes.frame = frame;
    return currentItemAttributes;
}

- (CGFloat)evaluatedMinimumInteritemSpacingForItemAtIndex:(NSInteger)index
{
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        id<UICollectionViewDelegateAlignedLayout> delegate = (id<UICollectionViewDelegateAlignedLayout>)self.collectionView.delegate;
        
        return [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:index];
    } else {
        return self.minimumLineSpacing;
    }
}

- (UIEdgeInsets)evaluatedSectionInsetForItemAtIndex:(NSInteger)index
{
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        id<UICollectionViewDelegateAlignedLayout> delegate = (id<UICollectionViewDelegateAlignedLayout>)self.collectionView.delegate;
        
        return [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:index];
    } else {
        return self.sectionInset;
    }
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.frame.size.width, _completeContentSizeHeight);
}

@end

