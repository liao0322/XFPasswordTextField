//
//  XFPasswordTextField.m
//  PasswordTextFieldDemo
//
//  Created by liaoxf on 2018/4/20.
//  Copyright © 2018年 liaoxf. All rights reserved.
//

#import "XFPasswordTextField.h"
#import "XFSingleDotView.h"

@interface XFPasswordTextField ()<UITextFieldDelegate>

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) NSArray<XFSingleDotView *> *dotViews;

@end

@implementation XFPasswordTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _dotViewSpacing = 0;
        _maxPasswordLength = 4;
        _dotStyle = XFPasswordTextFieldDotStyleEasterisk;
        [self addSubview:self.textField];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self createDotView];
}

- (void)createDotView {
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:self.maxPasswordLength];
    
    for (int i = 0; i < self.maxPasswordLength; i++) {
        XFSingleDotView *dotView = [[XFSingleDotView alloc] init];
        dotView.dotStyle = XFPasswordTextFieldDotStyleNone;
        dotView.tag = i;
        [self addSubview:dotView];
        [tempArray addObject:dotView];
    }
    self.dotViews = [tempArray copy];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    self.textField.frame = CGRectMake(0, 0, width, height);

    __block CGFloat dotViewX = 0;
    CGFloat dotViewY = 0;
    CGFloat dotViewH = height;
    CGFloat dotViewW = (width - self.dotViewSpacing * (self.maxPasswordLength - 1)) / self.maxPasswordLength;
    
    [self.dotViews enumerateObjectsUsingBlock:^(XFSingleDotView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dotViewX = idx * dotViewW;
        obj.frame = CGRectMake(dotViewX + idx*self.dotViewSpacing - idx*0.5, dotViewY, dotViewW, dotViewH);
    }];
}

- (void)textFieldDidChanged:(UITextField *)tf {
    if (tf.text.length == self.maxPasswordLength) {
        [tf resignFirstResponder];
    }

    [self.dotViews enumerateObjectsUsingBlock:^(XFSingleDotView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < tf.text.length) {
            obj.dotStyle = self.dotStyle;
        } else {
            obj.dotStyle = XFPasswordTextFieldDotStyleNone;
        }
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.length > 0) { // 回删
        return YES;
    }
    
    if (string.length > 1) { // 防止粘贴
        return NO;
    }
    
    if (textField.text.length == self.maxPasswordLength) { // 密码最多只能输入6位
        return NO;
    }
    if (textField.text.length == self.maxPasswordLength - 1) {
        if (self.editEndBlock) {
            self.editEndBlock(textField.text);
        }
    }

    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField becomeFirstResponder];
}

- (void)becomeFirstResponder {
    [self.textField becomeFirstResponder];
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.hidden = YES;
        _textField.delegate = self;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        [_textField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

@end
