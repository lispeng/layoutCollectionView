//
//  LSPCollectionViewCell.m
//  CustomFlowLayout
//
//  Created by mac on 15-12-5.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "LSPCollectionViewCell.h"
@interface LSPCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end
@implementation LSPCollectionViewCell

/**
 *  从XIB从加载文件时会调用
 */
- (void)awakeFromNib
{
    //设置边框
    self.layer.borderWidth = 5;
    //设置边框颜色
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    //设置边框圆角
    self.layer.cornerRadius = 3;
    //超出边框的部分裁剪掉
    self.layer.masksToBounds = YES;
    
}

- (void)setImage:(NSString *)image
{
    _image = [image copy];
    
    self.imageView.image = [UIImage imageNamed:image];
}
@end
