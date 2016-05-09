//
//  ViewController.m
//  TextViewDemo
//
//  Created by Weixu on 16/5/6.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ViewController.h"
#import "MenuViewController.h"
#import "ChangeFrameViewController.h"
#import "PlaceholderViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)selectBtn:(id)sender {
    
    MenuViewController *menuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    
    [self presentViewController:menuViewController animated:YES completion:nil];
    
}


- (IBAction)changeFrameBtnPress:(id)sender {
    
    ChangeFrameViewController *changeFrameViewController = [[ChangeFrameViewController alloc] initWithNibName:@"ChangeFrameViewController" bundle:nil];
    
    [self presentViewController:changeFrameViewController animated:YES completion:nil];
    
}

- (IBAction)showPlaceholderButtonPress:(id)sender {
    
    PlaceholderViewController *placeholderViewController = [[PlaceholderViewController alloc] initWithNibName:@"PlaceholderViewController" bundle:nil];
    
    [self presentViewController:placeholderViewController animated:YES completion:nil];
}


- (IBAction)cellChangeBtnPress:(id)sender {
    
}


@end
