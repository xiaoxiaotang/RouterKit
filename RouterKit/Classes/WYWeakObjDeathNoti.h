//
//  WYWeakObjDeathNoti.h
//  RouterKit
//
//  Created by 小站 on 2020/4/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//当owner释放的时候通知block
@class WYWeakObjDeathNoti;

typedef void(^WYWeakObjDeathNotiBlock)(WYWeakObjDeathNoti *sender);

@interface WYWeakObjDeathNoti : NSObject

@property (nonatomic, weak) id owner;//持有对象

//回调
- (void)setBlock:(WYWeakObjDeathNotiBlock)block;

@end

NS_ASSUME_NONNULL_END
