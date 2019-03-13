//
//  ViewController.m
//  TestProject
//
//  Created by 刘云阳 on 2019/3/13.
//  Copyright © 2019 LYY. All rights reserved.
//

#import "ViewController.h"
#import "MainView.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MainView *mainView = [[MainView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:mainView];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray: @[@{@"name":@"首页"},@{@"name":@"推荐"},@{@"name":@"动漫"},@{@"name":@"体育资讯"},@{@"name":@"财经周刊"},@{@"name":@"国际新闻"},@{@"name":@"本地旅游"}]];
    mainView.headDataArray = array;
}


@end
