//
//  LSPCircleLayout.m
//  CustomFlowLayout
//
//  Created by mac on 15-12-6.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPCircleLayout.h"

@implementation LSPCircleLayout
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < count; i ++) {
        
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [array addObject:attrs];
    }
    return array;
}
/**
 *  每一个item的属性设置
 *
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attr.size = CGSizeMake(50, 50);
    //圆的半径
    CGFloat radius = 60;
    //圆心设置
    CGPoint radiusPoint = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    //item目标总数
    NSInteger count = [self.collectionView numberOfItemsInSection:indexPath.section];
    //角度设置
    CGFloat angle = M_PI * 2.0 / count;
    
    //计算当前item的角度
    CGFloat currentAngle = indexPath.item * angle;
    //设置每一个item的中心点的位置在圆的边上
    attr.center = CGPointMake(radiusPoint.x + radius * cosf(currentAngle), radiusPoint.y - radius * sinf(currentAngle));
    
    //zIndex
    attr.zIndex = indexPath.item;
  
    return attr;
}

@end
