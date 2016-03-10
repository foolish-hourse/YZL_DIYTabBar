//
//  YZLTabBar.h
//  YZL_DIYTabBar
//
//  Created by YZL on 16/3/7.
//  Copyright © 2016年 YZL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YZLTabBar;
@protocol YZLTabBarDelegate <UITabBarDelegate>

@optional
//tabBar中间按钮点击时触发的事件
- (void)tabBarDidClickCenterButton:(UIButton *)centerButton;

@end

@interface YZLTabBar : UITabBar
/* 初始化方法 **/
- (instancetype)initWithViewControllerCount:(NSInteger)vcCount;
//中间按钮
@property (nonatomic, weak) UIButton *centerButton;
@property (nonatomic, assign) id<YZLTabBarDelegate> delegate;
/* 是否显示中间按钮 **/
@property (nonatomic, assign) BOOL isShowCenterButton;
/* 中间按钮背景图片名 **/
@property (nonatomic, strong) NSString *bgImgStr;
/* 中间按钮图片名 **/
@property (nonatomic, strong) NSString *imgStr;
/* 中间按钮背景图片名 **/
@property (nonatomic, strong) NSString *bgImgSelectedStr;
/* 中间按钮图片名 **/
@property (nonatomic, strong) NSString *imgSelectedStr;
@end
