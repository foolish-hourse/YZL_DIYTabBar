//
//  YZLTabBarController.h
//  YZL_DIYTabBar
//
//  Created by YZL on 16/3/7.
//  Copyright © 2016年 YZL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZLTabBar.h"

@interface YZLTabBarController : UITabBarController
/* 初始化自定义tabbar **/
- (instancetype)initWithViewControllers:(NSArray <UIViewController *>*)viewControllers titles:(NSArray <NSString *>*)titles images:(NSArray <NSString *>*)images selectedImages:(NSArray <NSString *>*)selectedImages;
/* 设置中间按钮是否显示 
 * 默认是NO,不显示
 **/
@property (nonatomic, assign) BOOL isShowCenterButton;
/** tab中间按钮的背景图片 */
@property (nonatomic, strong) NSString *centerButtonBackgroundImg;
/** tab中间按钮的图片 */
@property (nonatomic, strong) NSString *centerButtonImg;
/** tab中间按钮的背景图片被选中 */
@property (nonatomic, strong) NSString *centerButtonBackgroundSelectedImg;
/** tab中间按钮的图片被选中 */
@property (nonatomic, strong) NSString *centerButtonSelectedImg;

@property (nonatomic, strong) YZLTabBar *myTabBar;

/** 菜单标题数组 */
@property (nonatomic, strong) NSArray *menuTitleArr;
/** 菜单图片数组 */
@property (nonatomic, strong) NSArray *menuImgArr;
/* 菜单标题文字颜色
 * 默认为black
 * */
@property (nonatomic, strong) UIColor *menuTitleColor;
@end
