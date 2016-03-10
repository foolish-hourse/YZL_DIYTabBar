//
//  YZLTabBarController.m
//  YZL_DIYTabBar
//
//  Created by YZL on 16/3/7.
//  Copyright © 2016年 YZL. All rights reserved.
//

#import "YZLTabBarController.h"
#import "YZLTabBar.h"
#import "UIView+Extension.h"

@interface YZLTabBarController () <YZLTabBarDelegate>
/* 中间按钮当前的角度**/
@property (nonatomic, assign) CGFloat angle;
/* 中间按钮旋转次数**/
@property (nonatomic, assign) NSInteger count;
/** 黑色背景视图 */
@property (nonatomic, strong) UIView *blackView;
@end

#define krgb(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]// RGB颜色
#define kWindowH   [UIScreen mainScreen].bounds.size.height //应用程序的屏幕高度
#define kWindowW    [UIScreen mainScreen].bounds.size.width  //应用程序的屏幕宽度

/* 设置tabbar各种属性的宏定义 可在这里对tabbar进行配置 **/
/* 暂不可改 **/
//目前尺寸还是不要改，没做好
#define menuItemSize CGSizeMake(60, 60)

@implementation YZLTabBarController

#pragma mark - lazy Method

- (UIView *)blackView {
    if (!_blackView) {
        _blackView = [[UIView alloc] init];
        _blackView.frame = CGRectMake(0, 20, kWindowW, kWindowH - 20);
        //  创建需要的毛玻璃特效类型
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        //  毛玻璃view 视图
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        //添加到要有毛玻璃特效的控件中
        effectView.frame = _blackView.bounds;
        [_blackView addSubview:effectView];
        //设置模糊透明度
        effectView.alpha = 0.3;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackViewPressed)];
        [_blackView addGestureRecognizer:tap];
    }
    return _blackView;
}


#pragma mark - init Method
- (instancetype)initWithViewControllers:(NSArray <UIViewController *>*)viewControllers titles:(NSArray <NSString *>*)titles images:(NSArray <NSString *>*)images selectedImages:(NSArray <NSString *>*)selectedImages{
    if (self = [super init]) {
        for (int i = 0; i < viewControllers.count; i++) {
            // 添加子控制器
            [self addChildVc:viewControllers[i] title:titles[i] image:images[i] selectedImage:selectedImages[i]];
        }
        self.myTabBar = [[YZLTabBar alloc] initWithViewControllerCount:viewControllers.count];
        self.myTabBar.delegate = self;
        //使用kvc替换系统的tabBar
        [self setValue:self.myTabBar forKey:@"tabBar"];
    }
    return self;
}

#pragma mark - set Method
- (void)setCenterButtonBackgroundImg:(NSString *)centerButtonBackgroundImg {
    self.myTabBar.bgImgStr = centerButtonBackgroundImg;
}

- (void)setCenterButtonImg:(NSString *)centerButtonImg {
    self.myTabBar.imgStr = centerButtonImg;
}

- (void)setCenterButtonBackgroundSelectedImg:(NSString *)centerButtonBackgroundSelectedImg {
    self.myTabBar.bgImgSelectedStr = centerButtonBackgroundSelectedImg;
}

- (void)setCenterButtonSelectedImg:(NSString *)centerButtonSelectedImg {
    self.myTabBar.imgSelectedStr = centerButtonSelectedImg;
}

#pragma mark - view Func
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - toolMethods
/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.title = title;
    // 设置子控制器的tabBarItem图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    // 禁用图片渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置文字的样式
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : krgb(123, 123, 123)} forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]} forState:UIControlStateSelected];
    // 为子控制器包装导航控制器
    UINavigationController *navigationVc = [[UINavigationController alloc] initWithRootViewController:childVc];
    // 添加子控制器
    [self addChildViewController:navigationVc];
    // 如果未设置标题（一般是图片里有标题），则重新设置子控制器的tabBarItem图片的位置
    if (title == nil) {
        childVc.tabBarItem.imageInsets = UIEdgeInsetsMake(3, 0, -3, 0);
    }
}

#pragma mark - YZLTabBarDelegate
/**
 *  中间按钮点击
 */
- (void)tabBarDidClickCenterButton:(UIButton *)centerButton {
    //弹出选项菜单 － 动画效果
    [self menuAnimateMethod];
}

#pragma mark - CABasicAnimation Delegate
//CABasicAnimation动画结束时回调的函数 flag = 1表示结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.count % 2 == 0) {
        [self hideMenu];
    }else {
        [self showMenu];
    }
}

#pragma mark - methods
/**
 * isShowCenterButton set方法
 */
- (void)setIsShowCenterButton:(BOOL)isShowCenterButton {
    self.myTabBar.isShowCenterButton = isShowCenterButton;
}

/**
 * 显示菜单方法
 */
- (void)showMenu{
    NSInteger numberOfItems = 0;
    if (self.menuImgArr.count) {
        numberOfItems = self.menuImgArr.count;
    }else if(self.menuTitleArr.count){
        numberOfItems = self.menuTitleArr.count;
    }
    CGFloat angle = 0.0;
    angle = M_PI / numberOfItems;
    [self.view addSubview:self.blackView];
    for(int i = 0; i < numberOfItems; i++) {
        CGFloat buttonX = (kWindowW / 2 - menuItemSize.width) * cosf((angle * i) + angle / 2) + kWindowW / 2 - menuItemSize.width / 2;
        CGFloat buttonY = kWindowH - 64 - 49 - (kWindowW / 2 - menuItemSize.width) * sinf((angle * i) + angle / 2) - menuItemSize.height;
        UIButton *itemButton = [[UIButton alloc] init];
        itemButton.frame = CGRectMake(buttonX, buttonY, menuItemSize.width, menuItemSize.height);
        itemButton.tag = 100 + itemButton.tag + numberOfItems - 1 - i;
        [itemButton setImage:[UIImage imageNamed:self.menuImgArr[itemButton.tag - 100]] forState:UIControlStateNormal];
        itemButton.imageEdgeInsets = UIEdgeInsetsMake(5,5,5,itemButton.titleLabel.bounds.size.width);
        if (self.menuTitleColor == nil) {
            self.menuTitleColor = [UIColor blackColor];
        }
        [itemButton setTitleColor:self.menuTitleColor forState:UIControlStateNormal];
        [itemButton setTitle:self.menuTitleArr[itemButton.tag - 100] forState:UIControlStateNormal];
        itemButton.titleLabel.font = [UIFont systemFontOfSize:16];
        itemButton.titleEdgeInsets = UIEdgeInsetsMake(menuItemSize.height + 20, -itemButton.titleLabel.bounds.size.width - 17 * menuItemSize.height / 40.0 - menuItemSize.width / 2 - 10, 0, 0);
        itemButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.blackView addSubview:itemButton];
        [itemButton addTarget:self action:@selector(itemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    };
}

/**
 * 隐藏菜单方法
 */
- (void)hideMenu {
    [self.blackView removeFromSuperview];
}

/**
 * 动画方法
 */
- (void)menuAnimateMethod {
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform"];
    rotation.delegate = self;
    rotation.fillMode = kCAFillModeForwards;
    rotation.removedOnCompletion = NO;
    rotation.fromValue = [NSValue valueWithCATransform3D:self.myTabBar.centerButton.imageView.layer.transform];
    if (self.count % 2 == 0) {
        rotation.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.myTabBar.centerButton.imageView.layer.transform, M_PI_4 * 3, 0, 0, 1.0)];
    }else {
        rotation.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.myTabBar.centerButton.imageView.layer.transform, M_PI_4 * 2, 0, 0, 1.0)];
    }
    self.count ++;
    [self.myTabBar.centerButton.imageView.layer setValue:rotation.fromValue forKeyPath:@"transform"];
    rotation.duration = 0.2;
    [self.myTabBar.centerButton.imageView.layer addAnimation:rotation forKey:nil];
}

/**
 * 黑色背景点击事件方法
 */
- (void)blackViewPressed {
    [self menuAnimateMethod];
}

/**
 * 菜单按钮点击事件方法
 */
- (void)itemButtonClick:(UIButton *)sender{
    NSInteger index = sender.tag - 100;
    NSLog(@"%ld",index);
}

@end
