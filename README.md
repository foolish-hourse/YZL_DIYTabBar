# YZL_DIYTabBar
```objc
自定义tabbar
/* step1:导入YZLTabBar_ArcVersion_1.0工具包
 * step2:AppDelegate.m文件中#import "YZLTabBarController.h"，在Assets.xcassets中准备需要的资源文件
 * step3:在
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions中
 初始化YZLTabBarController，
 调用
 - (instancetype)initWithViewControllers:(NSArray <UIViewController *>*)viewControllers titles:(NSArray <NSString *>*)titles images:(NSArray <NSString *>*)images selectedImages:(NSArray <NSString *>*)selectedImages.
 其中viewControllers代表控制器视图数组，titles代表tabbar内各控制器视图的标题数组，images代表tabbar内各控制器视图的图片数组，selectedImages代表tabbar内各控制器视图被选中时的图片数组
 * step4:如果需要中间的特殊按钮，设置tab属性isShowCenterButton为yes
 * step5.在isShowCenterButton为yes的情况下，设置下列属性配置弹出菜单
 //弹出菜单标题数组
 tab.menuTitleArr = @[@"摄像",@"签到",@"照片",@"更多"];
 //弹出菜单图片数组
 tab.menuImgArr = @[@"tabbar_compose_camera",@"tabbar_compose_idea",@"tabbar_compose_photo",@"tabbar_compose_more"];
 //中间按钮背景图
 tab.centerButtonBackgroundImg = @"tabbar_compose_button";
 //中间按钮图片
 tab.centerButtonImg = @"tabbar_compose_icon_add";
 //中间按钮被选择时背景图
 tab.centerButtonBackgroundSelectedImg = @"tabbar_compose_button_highlighted";
 //中间按钮被选择时图片
 tab.centerButtonSelectedImg = @"tabbar_compose_icon_add_highlighted";
 //可选 默认字体颜色为黑色
 tab.menuTitleColor = [UIColor blueColor];
 step6:设置tab为根视图  self.window.rootViewController = tab;
 */
```
