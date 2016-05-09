//
//  PlaceholderViewController.m
//  TextViewDemo
//
//  Created by Weixu on 16/5/6.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "PlaceholderViewController.h"
#import "UIPlaceholderTextView.h"

@interface PlaceholderViewController ()

@property (weak, nonatomic) IBOutlet UIPlaceholderTextView *placeholderTextView;
@end

@implementation PlaceholderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.placeholderTextView.placeholder = @"请随意输入和删除数据，用来测试textView的Placeholder";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
