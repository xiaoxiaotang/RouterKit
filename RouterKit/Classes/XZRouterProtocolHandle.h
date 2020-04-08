//
//  XZRouterProtocolHandle.h
//  RouterKit
//
//  Created by 小站 on 2020/4/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN UIViewController *AutoGetRoSourceViewController(void);
FOUNDATION_EXTERN UINavigationController * _Nullable  AutoGetNavigationViewController(UIViewController *sourceVC);

typedef void(^XZRouterProtocolHandleCompletionBlock)(__nullable id data);


@class XZClassProtocolMediator;
@interface XZRouterProtocolHandle : NSObject {
    id _destination;
    XZClassProtocolMediator *_context;
}

//使用 [NYIntentContext defaultContext]  如果谁发现context拿不到上下文或者串了 微信akries
@property (nonatomic, strong, readonly) XZClassProtocolMediator *context;

//解析后的key
@property (nonatomic, copy ,nullable) NSString *key;

/**
 *  通过NYIntent传递的参数
 *  在viewController中，可以通过调用self.extraData来获得参数集合
 */
@property (nonatomic, strong,readonly,nullable) NSDictionary *extraData;

@property (nonatomic, assign) NSInteger options;

/**
 *  Init NYIntent.
 *  destinationURLString 传递url
 */
+ (nullable instancetype)intentWithURLString:(NSString *)destinationURLString
                                     context:(nullable XZClassProtocolMediator*)context;

+ (nullable instancetype)intentWithURL:(NSURL *)destinationURL
                               context:(nullable XZClassProtocolMediator*)context;

/**
 *  安全添加元素
 */
- (void)setExtraDataWithValue:(nullable id)value forKey:(NSString *)key;

/**
 *  安全添加字典
 */
- (void)setExtraDataWithDictionary:(nullable NSDictionary *)dictionary;

/**
 *  提交行动
 */
- (id)submit;

/**
 *  提交行动，完成回调
 */
- (id)submitWithCompletion:(nullable XZRouterProtocolHandleCompletionBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END
