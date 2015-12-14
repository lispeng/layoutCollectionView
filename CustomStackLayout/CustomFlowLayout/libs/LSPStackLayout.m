//
//  LSPStackLayout.m
//  CustomFlowLayout
//
//  Created by mac on 15-12-6.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPStackLayout.h"

@implementation LSPStackLayout

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
    NSArray *angles = @[@(0),@(-0.3),@(0.35),@(-0.1),@(0.4)];
    //取出当前的item的属性
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attr.size = CGSizeMake(100, 100);
    //设置中心点的位置
    CGFloat centerX = self.collectionView.frame.size.width * 0.5;
    CGFloat centerY = self.collectionView.frame.size.height * 0.5;
    attr.center = CGPointMake(centerX, centerY);
    
    if (indexPath.item >= 5) {
        attr.hidden = YES;
    }else{
        attr.transform = CGAffineTransformMakeRotation([angles[indexPath.item] floatValue]);
        //zIndex越大就越在最上面
        attr.zIndex = [self.collectionView numberOfItemsInSection:0] - indexPath.item;
    }
    return attr;
}
@end
