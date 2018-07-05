//
//  XFPasswordTextField.h
//  PasswordTextFieldDemo
//
//  Created by liaoxf on 2018/4/20.
//  Copyright © 2018年 liaoxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnumerationDefines.h"

@interface XFPasswordTextField : UIView

/// 密码位数
@property (assign, nonatomic) NSInteger maxPasswordLength;
/// 方格间隙
@property (assign, nonatomic) CGFloat dotViewSpacing;
/// 暗文样式
@property (assign, nonatomic) XFPasswordTextFieldDotStyle dotStyle;
/// 输入完成后的回调
@property (copy, nonatomic) void (^editEndBlock)(NSString *text);
/// 让内部的 textfield 成为第一响应者
- (void)becomeFirstResponder;

- (void)createUI;

@property (copy, nonatomic) void (^textFieldValueChangedBlock)(UITextField *tf);

@end
