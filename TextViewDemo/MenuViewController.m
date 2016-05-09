//
//  MenuViewController.m
//  TextViewDemo
//
//  Created by Weixu on 16/5/6.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "MenuViewController.h"
#import "CustomTextView.h"

@interface MenuViewController ()<UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *beginPoint;

@property (weak, nonatomic) IBOutlet UITextField *lengthPoint;

@property (weak, nonatomic) IBOutlet CustomTextView *customTextView;

@end

@implementation MenuViewController

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMenuItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onShowMenu:) name:@"UIMenuControllerWillShowMenuNotification" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onChangeMenuFrame:) name:@"UIMenuControllerMenuFrameDidChangeNotification" object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)onChangeMenuFrame:(NSNotification *)notification{
     NSDictionary *info = [notification userInfo];
     CGRect frame = [UIMenuController sharedMenuController].menuFrame;
    NSLog(@"frame = %@",frame);
}

// 通知用来告诉系统
- (void)onShowMenu:(NSNotification *)notification{
    
    NSDictionary *info = [notification userInfo];
    
    CGRect frame = [UIMenuController sharedMenuController].menuFrame;
    
    
    CGRect textViewsubFrame = [self.view convertRect:frame toView:self.customTextView];
//    [self addNewViewTest:textViewsubFrame];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)selectBtnPress:(id)sender {
}


- (IBAction)scrollBtnPress:(id)sender {
}


- (IBAction)editBtnPress:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button.selected) {
        
        if ([self isCanSelect]) {
            self.beginPoint.enabled = NO;
            self.lengthPoint.enabled = NO;
            
            NSInteger loc = self.beginPoint.text.integerValue;
            NSInteger len = self.lengthPoint.text.integerValue;
            
            [self.customTextView becomeFirstResponder];  //这个必须设置，不然无法显示指定选择的内容
            
            NSRange selectRange =NSMakeRange(loc, len);
            self.customTextView.selectedRange =selectRange;
            
            [self.customTextView scrollRangeToVisible:selectRange];

            button.selected = NO;
        }
        else{
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"错误"
                                                                           message:@"输入出错，输入的数不能小于0和大于文本长度"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            
            
            
            [self presentViewController:alert animated:YES completion:nil];
        
        }
    }
    else{
        self.beginPoint.enabled = YES;
        self.lengthPoint.enabled = YES;
        
        button.selected = YES;
    }
}

- (void)addNewViewTest:(CGRect )frame{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [view setBackgroundColor:[UIColor redColor]];
    [self.customTextView addSubview:view];

}
- (BOOL)isCanSelect{
    NSInteger loc = self.beginPoint.text.integerValue;
    NSInteger len = self.lengthPoint.text.integerValue;
    NSUInteger textLength = self.customTextView.text.length;
    if (loc < 0 || len < 0 || loc > textLength || len > textLength) {
        return NO;
    }
    
    return YES;
}



- (void)addMenuItem{
    // 自定义text view选中文字后的菜单
    UIMenuItem *selectItem = [[UIMenuItem alloc] initWithTitle:@"选择文字" action:@selector(callSelectText:)];
    UIMenuItem *cancelItem = [[UIMenuItem alloc] initWithTitle:@"取消选中" action:@selector(cancelSelection:)];
    
    [UIMenuController sharedMenuController].menuItems = @[selectItem, cancelItem];

}


#pragma mark - Menu Item Actions

- (void)callSelectText:(id)sender {
    
    NSRange selectRange = self.customTextView.selectedRange;
    
    NSString *selectContent = [self.customTextView.text substringWithRange:selectRange];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"选中的内容为"
                                                                   message:selectContent
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    
    
    
    [self presentViewController:alert animated:YES completion:nil];
}



- (void)cancelSelection:(id)sender {
    
}


- (void)textViewDidChangeSelection:(UITextView *)textView {
    NSLog(@"Selection changed");

//    NSString *string = [self.customTextView.text substringWithRange:self.customTextView.selectedRange];
    
    self.beginPoint.text = [NSString stringWithFormat:@"%lu",self.customTextView.selectedRange.location];
    self.lengthPoint.text = [NSString stringWithFormat:@"%lu",self.customTextView.selectedRange.length];
    
    NSRange range = self.customTextView.selectedRange;
    
    UITextPosition *beginning = textView.beginningOfDocument;
    UITextPosition *start = [textView positionFromPosition:beginning offset:range.location];
    UITextPosition *end = [textView positionFromPosition:start offset:range.length];
    UITextRange *textRange = [textView textRangeFromPosition:start toPosition:end];
    
    CGRect startframe = [textView caretRectForPosition:start];
    CGRect endframe = [textView caretRectForPosition:end];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    
//    [self addNewViewTest:startframe];
//    [self addNewViewTest:endframe];
    
    CGRect frame = [self frameOfTextRange:range inTextView:textView];
    [self addNewViewTest:frame];
}

- (CGRect)frameOfTextRange:(NSRange)range inTextView:(UITextView *)textView
{
    UITextPosition *beginning = textView.beginningOfDocument;
    UITextPosition *start = [textView positionFromPosition:beginning offset:range.location];
    UITextPosition *end = [textView positionFromPosition:start offset:range.length];
    UITextRange *textRange = [textView textRangeFromPosition:start toPosition:end];
    CGRect rect = [textView firstRectForRange:textRange];
    return [textView convertRect:rect fromView:textView.textInputView];
}

@end
