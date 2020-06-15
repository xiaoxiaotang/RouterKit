//
//  WYHandle.h
//  RouterKit
//
//  Created by 小站 on 2020/4/8.
//

#import "WYRouterProtocolHandle.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString const *WYHandlerCallBackKey;

@class WYClassProtocolMediator;
@interface WYHandle : WYRouterProtocolHandle

@property (nonatomic, copy, readonly) WYRouterProtocolHandleCompletionBlock destination;//回调

/**
 *   NYHandler 对应的对象实例
 *
 *  @param handlerInstanceKey     HandlerInstanceKey
 *  @return 返回NYHandler 对应的对象实例
 */
+ (id)realizeWithHandlerInstanceKey:(NSString *)handlerInstanceKey;

/**
 *  Init NYHandler.
 *
 *  @param handlerKey     用于创建全局方法key
 *
 */
- (instancetype)initWithHandlerKey:(NSString *)handlerKey;

/**
 *  Init NYHandler.
 *
 *  @param handlerKey     用于创建全局方法
 *  @param context        if not nil,将成为context的方法
 *
 */
- (instancetype)initWithHandlerKey:(NSString *)handlerKey
                           context:(nullable WYClassProtocolMediator *)context;

/**
 *  批量执行handler
 *
 *  @param handlerKeys     用于创建全局方法key数组
 *  @param isReleaseHandler  是否自动释放key对象 默认NO
 */
+ (void)realizeWithHandlerArray:(NSArray *)handlerKeys releaseHandler:(BOOL)isReleaseHandler;

@end

NS_ASSUME_NONNULL_END
