//
//  YZLTabBar.m
//  YZL_DIYTabBar
//
//  Created by YZL on 16/3/7.
//  Copyright © 2016年 YZL. All rights reserved.
//

#import "YZLTabBar.h"
#import "UIView+Extension.h"
@interface YZLTabBar ()
/* 控制器个数 **/
@property (nonatomic, assign) NSInteger vcCount;
@end

@implementation YZLTabBar
@dynamic delegate;

- (instancetype)initWithViewControllerCount:(NSInteger)vcCount{
    if (self = [super init]) {
        self.vcCount = vcCount;
    }
    return self;
}

//中间按钮的所有设置
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *centerButton = [[UIButton alloc] init];
        [centerButton addTarget:self action:@selector(centerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:centerButton];
        self.centerButton = centerButton;
    }
    return self;
}

/**
 *  中间按钮点击
 */
- (void)centerBtnClick {
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickCenterButton:)]) {
        [self.delegate tabBarDidClickCenterButton:self.centerButton];
    }
}

/**
 *  想要重新排布系统控件subview的布局，推荐重写layoutSubviews，在调用父类布局后重新排布。
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    // 1.设置中间按钮的位置，尺寸
    self.centerButton.centerX = self.width * 0.5;
    self.centerButton.centerY = self.height * 0.5;
//    self.centerButton.y = -10;
    self.centerButton.size = CGSizeMake(self.centerButton.currentBackgroundImage.size.width, self.centerButton.currentBackgroundImage.size.height);
    // 2.设置其他tabbarButton的frame
    CGFloat tabBarButtonW = 0.0;
    if (self.isShowCenterButton) {
        tabBarButtonW = self.width / (self.vcCount + 1);
    }else {
        tabBarButtonW = self.width / self.vcCount;
    }
    CGFloat tabBarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            // 设置x
            child.x = tabBarButtonIndex * tabBarButtonW;
            // 设置宽度
            child.width = tabBarButtonW;
            // 增加索引
            tabBarButtonIndex++;
            if (self.isShowCenterButton) {
                if (tabBarButtonIndex == (self.vcCount + 1) / 2) {
                    self.centerButton.hidden = NO;
                    tabBarButtonIndex++;
                }
            }else {
                self.centerButton.hidden = YES;
            }
        }
    }
}

#pragma mark - set methods
- (void)setIsShowCenterButton:(BOOL)isShowCenterButton {
    _isShowCenterButton = isShowCenterButton;
    [self layoutSubviews];
}

- (void)setBgImgStr:(NSString *)bgImgStr {
    _bgImgStr = bgImgStr;
    [self.centerButton setBackgroundImage:[UIImage imageNamed:self.bgImgStr] forState:UIControlStateNormal];
}

- (void)setImgStr:(NSString *)imgStr {
    _imgStr = imgStr;
    [self.centerButton setImage:[UIImage imageNamed:self.imgStr] forState:UIControlStateNormal];
}

- (void)setBgImgSelectedStr:(NSString *)bgImgSelectedStr {
    _bgImgSelectedStr = bgImgSelectedStr;
    [self.centerButton setBackgroundImage:[UIImage imageNamed:bgImgSelectedStr] forState:UIControlStateHighlighted];
}

- (void)setImgSelectedStr:(NSString *)imgSelectedStr {
    _imgSelectedStr = imgSelectedStr;
    [self.centerButton setImage:[UIImage imageNamed:imgSelectedStr] forState:UIControlStateHighlighted];
    
}
@end
