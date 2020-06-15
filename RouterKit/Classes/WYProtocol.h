//
//  WYProtocol.h
//  RouterKit
//
//  Created by 小站 on 2020/4/8.
//

#import "WYRouterProtocolHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface WYProtocol : WYRouterProtocolHandle

/**
 *   实现NYProtocol对象
 *
 *  @param protocolKey     通过protocolKey找到接口的实例
 *
 */
+ (id)createInstanceWithProtocolKey:(Protocol *)protocolKey;

/**
 *   实现NYProtocol对象单例 (内部初始化)
 *
 *  @param protocolKey     通过protocolKey找到接口的实例
 *
 */
+ (id)sharedInstanceWithProtocolKey:(Protocol *)protocolKey;

/**
 *   替换NYProtocol单例
 *
 *  @param protocolKey     protocolKey
 *  @param instance        实例对象
 *
 */
+ (id)replaceSharedInstance:(id)instance protocolKey:(Protocol *)protocolKey;


/**
 *   实现NYProtocol Class
 *
 *  @param protocolKey     通过protocolKey找到接口的Class
 *
 */
+ (Class)classFromProtocol:(Protocol *)protocolKey;

@end

NS_ASSUME_NONNULL_END
