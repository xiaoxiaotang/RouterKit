//
//  WYRouter.h
//  RouterKit
//
//  Created by 小站 on 2020/4/8.
//

#import "WYRouterProtocolHandle.h"

NS_ASSUME_NONNULL_BEGIN

//WYRouterOptions 枚举 来决定用什么方式来打开控制器
typedef NS_OPTIONS(NSUInteger, WYRouterOptions) {
    WYRouterActionPresent          = 1 << 0,   //调用 presentViewController:animated:completion:
    WYRouterActionPush             = 1 << 1,   //调用 pushViewController:animated:

    WYRouterPresentPresentStyleAutomatic    = 1 << 10, // iOS 13.0+
    WYRouterPresentPresentStyleFullScreen    = 1 << 11,
    WYRouterPresentPresentStylePageSheet   = 1 << 12,
    WYRouterPresentPresentStyleFormSheet    = 1 << 13,
    WYRouterPresentPresentStyleCurrentContext    = 1 << 14,
    WYRouterPresentPresentStyleCustom    = 1 << 15,
    WYRouterPresentPresentStyleOverFullScreen    = 1 << 16,
    WYRouterPresentPresentStyleOverCurrentContext    = 1 << 17,
    WYRouterPresentPresentStylePopover    = 1 << 10,
    WYRouterPresentPresentStyleNone    = 1 << 18,

};

@interface WYRouter : WYRouterProtocolHandle

//被自动跳转到控制器
@property (nonatomic, strong, readonly) UIViewController *destination;

//跳转动画 default is true
@property (nonatomic, assign) BOOL animation;

/**
 *  Init WYRouter
 *
 *  @param source        如果没有设置，将自动获取一个UIViewController来执行路由器
 *  @param routerKey     通过routerKey找到需要跳转的控制器
 *
 */
- (instancetype)initWithSource:(nullable UIViewController*)source routerKey:(NSString*)routerKey;

- (instancetype)initWithSource:(nullable UIViewController*)source routerProtocolKey:(Protocol *)protocolKey;

/**
 *  Init WYRouter
 *
 *  @param source        如果没有设置，将自动获取一个UIViewController来执行路由器
 *  @param routerKey     通过routerKey找到需要跳转的控制器
 *  @param context       获取数据字典
 */
- (instancetype)initWithSource:(nullable UIViewController*)source routerKey:(NSString*)routerKey context:(nullable WYClassProtocolMediator*)context;

- (instancetype)initWithSource:(nullable UIViewController*)source routerProtocolKey:(Protocol *)protocolKey context:(nullable WYClassProtocolMediator*)context;

@end

NS_ASSUME_NONNULL_END

