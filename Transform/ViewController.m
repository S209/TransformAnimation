//
//  ViewController.m
//  Transform
//
//  Created by tuhaisheng on 16/12/28.
//  Copyright © 2016年 tuhaisheng. All rights reserved.
//

#import "ViewController.h"
#import "UserGuidView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
    UserGuidView * guidView = [[UserGuidView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:guidView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
