//
//  XZWeakObjDeathNoti.h
//  RouterKit
//
//  Created by 小站 on 2020/4/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//当owner释放的时候通知block
@class XZWeakObjDeathNoti;

typedef void(^XZWeakObjDeathNotiBlock)(XZWeakObjDeathNoti *sender);

@interface XZWeakObjDeathNoti : NSObject

@property (nonatomic, weak) id owner;//持有对象

//回调
- (void)setBlock:(XZWeakObjDeathNotiBlock)block;

@end

NS_ASSUME_NONNULL_END
