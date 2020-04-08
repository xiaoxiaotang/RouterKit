//
//  XZRouter.h
//  RouterKit
//
//  Created by 小站 on 2020/4/8.
//

#import "XZRouterProtocolHandle.h"

NS_ASSUME_NONNULL_BEGIN

//XZRouterOptions 枚举 来决定用什么方式来打开控制器
typedef NS_OPTIONS(NSUInteger, XZRouterOptions) {
    XZRouterActionPresent          = 1 << 0,   //调用 presentViewController:animated:completion:
    XZRouterActionPush             = 1 << 1,   //调用 pushViewController:animated:

    XZRouterPresentPresentStyleAutomatic    = 1 << 10, // iOS 13.0+
    XZRouterPresentPresentStyleFullScreen    = 1 << 11,
    XZRouterPresentPresentStylePageSheet   = 1 << 12,
    XZRouterPresentPresentStyleFormSheet    = 1 << 13,
    XZRouterPresentPresentStyleCurrentContext    = 1 << 14,
    XZRouterPresentPresentStyleCustom    = 1 << 15,
    XZRouterPresentPresentStyleOverFullScreen    = 1 << 16,
    XZRouterPresentPresentStyleOverCurrentContext    = 1 << 17,
    XZRouterPresentPresentStylePopover    = 1 << 10,
    XZRouterPresentPresentStyleNone    = 1 << 18,

};

@interface XZRouter : XZRouterProtocolHandle

//被自动跳转到控制器
@property (nonatomic, strong, readonly) UIViewController *destination;

//跳转动画 default is true
@property (nonatomic, assign) BOOL animation;

/**
 *  Init XZRouter
 *
 *  @param source        如果没有设置，将自动获取一个UIViewController来执行路由器
 *  @param routerKey     通过routerKey找到需要跳转的控制器
 *
 */
- (instancetype)initWithSource:(nullable UIViewController*)source routerKey:(NSString*)routerKey;

- (instancetype)initWithSource:(nullable UIViewController*)source routerProtocolKey:(Protocol *)protocolKey;

/**
 *  Init XZRouter
 *
 *  @param source        如果没有设置，将自动获取一个UIViewController来执行路由器
 *  @param routerKey     通过routerKey找到需要跳转的控制器
 *  @param context       获取数据字典
 */
- (instancetype)initWithSource:(nullable UIViewController*)source routerKey:(NSString*)routerKey context:(nullable XZClassProtocolMediator*)context;

- (instancetype)initWithSource:(nullable UIViewController*)source routerProtocolKey:(Protocol *)protocolKey context:(nullable XZClassProtocolMediator*)context;

@end

NS_ASSUME_NONNULL_END

