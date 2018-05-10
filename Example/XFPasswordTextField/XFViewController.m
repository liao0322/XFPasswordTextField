//
//  XFViewController.m
//  XFPasswordTextField
//
//  Created by liao0322 on 05/03/2018.
//  Copyright (c) 2018 liao0322. All rights reserved.
//

#import "XFViewController.h"
#import "XFPasswordTextField.h"

@interface XFViewController ()
@property (strong, nonatomic) XFPasswordTextField *psTextField;
@end

@implementation XFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    _psTextField = [[XFPasswordTextField alloc] initWithFrame:CGRectMake(50, 100, 180, 30)];
    _psTextField.maxPasswordLength = 6;
    //    psTextField.dotViewSpacing = 0;
    //    psTextField.dotStyle = XFPasswordTextFieldDotStyleDot;
    _psTextField.dotStyle = XFPasswordTextFieldDotStyleEasterisk;
    _psTextField.editEndBlock = ^(NSString *text) {
        NSLog(@"输入完成 %@", text);
    };
    
    [self.view addSubview:_psTextField];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_psTextField becomeFirstResponder];
}

@end
