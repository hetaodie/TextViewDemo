//
//  ChangeFrameViewController.m
//  TextViewDemo
//
//  Created by Weixu on 16/5/6.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ChangeFrameViewController.h"

@interface ChangeFrameViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *maxHeightTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewMaxHeightLayoutConstraint;

@end

@implementation ChangeFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBorderOfTextView];
    [self.textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)addBorderOfTextView{
    //设置边框宽度
    self.textView.layer.borderWidth = 1.0;
    //设置边框颜色
    self.textView.layer.borderColor = [UIColor grayColor].CGColor;
    //设置圆角
    self.textView.layer.cornerRadius = 5.0;
}

- (void)textViewDidChange:(UITextView *)textView{
    CGFloat maxWidth = self.textView.frame.size.width;
    UIFont *aFont = self.textView.font;
    
    CGSize size = [textView.text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:aFont} context:nil].size;
    
    self.textViewHeight.constant = size.height+16;
}

- (IBAction)changeMaxheightBtnPress:(id)sender {
    
    CGFloat maxHeight = [self.maxHeightTextField.text floatValue];
    if (maxHeight > 50) {
        self.textViewMaxHeightLayoutConstraint.constant = maxHeight;
    }
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
