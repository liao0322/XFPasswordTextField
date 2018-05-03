//
//  XFSingleDotView.m
//  PasswordTextFieldDemo
//
//  Created by liaoxf on 2018/4/20.
//  Copyright © 2018年 liaoxf. All rights reserved.
//

#import "XFSingleDotView.h"

@interface XFSingleDotView ()
@property (strong, nonatomic) UILabel *dotLabel;
@end

@implementation XFSingleDotView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor colorWithRed:227/255.0f green:227/255.0f blue:227/255.0f alpha:1].CGColor;
        self.layer.borderWidth = 0.5f;
        [self addSubview:self.dotLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    CGFloat dotLabelRadius = 10;
    
    self.dotLabel.frame = CGRectMake(0, 0, dotLabelRadius, dotLabelRadius);
    
    self.dotLabel.center = CGPointMake(width * 0.5, height * 0.5);
    self.dotLabel.layer.cornerRadius = dotLabelRadius * 0.5;
    self.dotLabel.layer.masksToBounds = YES;
    
}

- (void)setDotStyle:(XFPasswordTextFieldDotStyle)dotStyle {
    _dotStyle = dotStyle;
    if (dotStyle == XFPasswordTextFieldDotStyleDot) {
        _dotLabel.hidden = NO;
        _dotLabel.text = nil;
        _dotLabel.backgroundColor = [UIColor blackColor];
    } else if (dotStyle == XFPasswordTextFieldDotStyleEasterisk) {
        _dotLabel.hidden = NO;
        _dotLabel.text = @"*";
        _dotLabel.backgroundColor = [UIColor clearColor];
    } else {
        _dotLabel.hidden = YES;
    }
}

- (UILabel *)dotLabel {
    if (!_dotLabel) {
        _dotLabel = [[UILabel alloc] init];
        _dotLabel.font = [UIFont fontWithName:@"Menlo" size:14];
        _dotLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dotLabel;
}

@end
