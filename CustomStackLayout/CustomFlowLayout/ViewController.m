//
//  ViewController.m
//  CustomFlowLayout
//
//  Created by mac on 15-12-5.
//  Copyright (c) 2015年 Lispeng. All rights reserved.
//

#import "ViewController.h"
#import "LSPCollectionViewCell.h"
#import "LSPHorizontalLayout.h"
#import "LSPStackLayout.h"
#import "LSPCircleLayout.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong,nonatomic) NSMutableArray *images;
@property (nonatomic,weak) UICollectionView *collectionView;

@end

@implementation ViewController

- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
        for (int i = 1; i <= 27; i ++) {
            
            NSString *image = [NSString stringWithFormat:@"%d.jpg",i];
            [self.images addObject:image];
        }
    }
    return _images;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    //创建UICollectionView
    [self addCollectionView];

}
- (void)addCollectionView
{
    LSPStackLayout *flowLayout = [[LSPStackLayout alloc] init];
    CGFloat width = self.view.frame.size.width;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, width, 210) collectionViewLayout:flowLayout];
    //设置数据源代理
    collectionView.dataSource = self;
    //设置代理
    collectionView.delegate = self;
    
    //注册一个可重复使用的cell
    [collectionView registerNib:[UINib nibWithNibName:@"LSPCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[LSPStackLayout class]]) {
       // [self.collectionView setCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        [self.collectionView setCollectionViewLayout:[[LSPCircleLayout alloc] init] animated:YES];
    }else
    {
        //[self.collectionView setCollectionViewLayout:[[LSPHorizontalLayout alloc] init]];
        [self.collectionView setCollectionViewLayout:[[LSPStackLayout alloc] init] animated:YES];
    }
}
#pragma mark---UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LSPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.image = self.images[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.images removeObjectAtIndex:indexPath.item];
    
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
