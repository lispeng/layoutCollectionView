//
//  LSPHorizontalLayout.m
//  CustomFlowLayout
//
//  Created by mac on 15-12-5.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPHorizontalLayout.h"
//#define LSPCellSize 100;
static const CGFloat LSPCellSize = 100;
@implementation LSPHorizontalLayout
/**
 *  初始化布局调用的方法
 */
- (void)prepareLayout
{
    [super prepareLayout];
    //设置每一个cell的尺寸
    CGFloat sizeWH = 100;
    self.itemSize = CGSizeMake(sizeWH, sizeWH);
    //设置每一个cell之间的距离
    self.minimumLineSpacing = 78;
    //设置边距
    CGFloat insert= (self.collectionView.frame.size.width - LSPCellSize) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(5, insert, 5, insert);
    //设置流水布局的滚动方向为水平方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

/**
 *  当cell的位置发生改变的时候是否需要布局
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
/**
 *  取得所有cell的属性进行相应的布局操作
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
    CGFloat collectionWidth = self.collectionView.frame.size.width * 0.5;
    CGFloat centerX = self.collectionView.contentOffset.x + collectionWidth;
    
    /**
     *  计算可见的矩形框
     */
    CGRect visiable;
    visiable.size = self.collectionView.frame.size;
    visiable.origin = self.collectionView.contentOffset;
    
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        
        //判断取出的item是否在可显示的的范围内
        if(!CGRectIntersectsRect(visiable, attr.frame)) continue;
        
        CGFloat itemCenterX = attr.center.x;
        CGFloat scale = 1 + (1 - ABS(itemCenterX - centerX) / collectionWidth);
        attr.transform3D = CATransform3DMakeScale(scale, scale, 0);
    }
    
    return attrs;
}
/**
 *  用来设置collectionView停止滚动的那一刻的位置
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //就算出屏幕显示出的范围
    CGRect lastRect;
    lastRect.size = self.collectionView.frame.size;
    lastRect.origin = proposedContentOffset;
    
    //计算屏幕最中间的X值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    //取出cell内的所有属性
    NSArray *sttrs = [self layoutAttributesForElementsInRect:lastRect];
    //遍历取出的属性值,获取与中点最小的差值
    CGFloat maxNum = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in sttrs) {
        
        if (ABS(attr.center.x - centerX) < maxNum) {
            
            maxNum = attr.center.x - centerX;
        }
        
    }
    
    return CGPointMake(proposedContentOffset.x + maxNum, proposedContentOffset.y);
}
@end
