//
//  CustomTextView.m
//  TextViewDemo
//
//  Created by Weixu on 16/5/6.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "CustomTextView.h"

@implementation CustomTextView



/* 选中文字后是否能够呼出菜单 */
- (BOOL)canBecameFirstResponder {
    return YES;
}

//主要是屏蔽掉系统弹出的状态值
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

@end
