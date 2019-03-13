//
//  MainView.m
//  TestProject
//
//  Created by 刘云阳 on 2019/3/13.
//  Copyright © 2019 LYY. All rights reserved.
//

#import "MainView.h"
#import "MainCollectionViewCell.h"
#import "UIViewExt.h"
#import "NSString+JCAdaptiveSize.h"

///屏宽
#define KMainWidth [UIScreen mainScreen].bounds.size.width
///屏高
#define KMainHeight [UIScreen mainScreen].bounds.size.height

#define ZLMIXUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MainView()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIScrollView *headScrollView;


@property (nonatomic, strong) UIView *headLineView;

@property (nonatomic, assign) CGFloat contentOffsetX;

@end
@implementation MainView
- (id)initWithFrame:(CGRect)frame{
    self=  [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headScrollView];
        [self addSubview:self.collectionView];
    }
    return self;
}
- (void)headButtonClick:(UIButton *)button{
    NSInteger tag = button.tag  - 1000;
    [UIView animateWithDuration:0.4 animations:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tag inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }];
    MainCollectionViewCell *cell =(MainCollectionViewCell *) [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:tag inSection:0]];
    cell.dic = [self.headDataArray objectAtIndex:tag];
    
    
}
- (void)reloadHeadScrollView{
    [self.headScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat width = 0;
    
    CGFloat floatW = 0;
    for (int i = 0; i < self.headDataArray.count; i ++) {
        NSDictionary *dic = [self.headDataArray objectAtIndex:i];
        NSString *name = [dic objectForKey:@"name"];
        CGFloat w = [NSString labelSizeWithAttributesWithTitle:name withFont:[UIFont systemFontOfSize:13]].width;
        if (w < KMainWidth/5 - 20) {
            w = KMainWidth/5 - 20;
        }
        
        floatW = w + 20;
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(width, 0, w + 20, 44)];
        width = width + w + 20;
        [button setTitle:name forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.tag = i + 1000;
        if (i ==0) {
            button.selected = YES;
        }
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.numberOfLines = 0;
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button setTitleColor:ZLMIXUIColorFromRGB(0xA5D3FF) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(headButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headScrollView addSubview:button];
    }
    _headScrollView.contentSize = CGSizeMake(width, 44);
    self.headLineView = [[UIView alloc]initWithFrame:CGRectMake(10, 42.5, floatW - 20, 1.5)];
    [self.headLineView setBackgroundColor:[UIColor redColor]];
    [_headScrollView addSubview:self.headLineView];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.headDataArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dic = [self.headDataArray objectAtIndex:indexPath.row];
    NSLog(@"indexPath.row ==== %ld", (long)indexPath.row);
    if (dic) {
        cell.dic = [self.headDataArray objectAtIndex:indexPath.row];
    }
    return cell;
}
- (void)didSelectNewsCell:(NSDictionary *)dic{
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.collectionView == scrollView) {
        NSInteger tag =  self.collectionView.contentOffset.x / KMainWidth;
        UIButton *btn ;
        for (UIView *view in self.headScrollView.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)view;
                if (tag + 1000 == button.tag) {
                    button.selected = YES;
                    btn = button;
                }else{
                    button.selected = NO;
                }
            }
        }
        [UIView animateWithDuration:0.4 animations:^{
            self.headLineView.frame = CGRectMake(btn.left + 10, 42.5, btn.width - 20, 1.5);
        }];
        if (self.headDataArray.count > 5) {
            if (tag>=3 && tag< self.headDataArray.count - 3) {
                [self.headScrollView setContentOffset:CGPointMake(btn.left   - KMainWidth/2 + btn.width/2, 0) animated:YES];
            }
            if (tag<=2) {
                [self.headScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                }
            if (tag>=self.headDataArray.count - 3) {
                [self.headScrollView setContentOffset:CGPointMake(self.headScrollView.contentSize.width - KMainWidth, 0) animated:YES];
            }
        }
        
    }
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing                       = 0.0;
        layout.scrollDirection                          = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(KMainWidth, KMainHeight - 40 - 44);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40 + 44, KMainWidth,KMainHeight - 40 - 44) collectionViewLayout:layout];
        _collectionView.delegate                       = self;
        _collectionView.dataSource                     = self;
        _collectionView.pagingEnabled                  = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor                = [UIColor clearColor];
        [_collectionView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (UIScrollView *)headScrollView{
    if (!_headScrollView) {
        _headScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, KMainWidth, 44)];
        _headScrollView.showsHorizontalScrollIndicator = NO;
        [_headScrollView setBackgroundColor:[UIColor greenColor]];
        _headScrollView.delegate = self;
    }
    return _headScrollView;
}

- (void)setHeadDataArray:(NSMutableArray *)headDataArray{
    _headDataArray = headDataArray;
    [self reloadHeadScrollView];
}
@end
