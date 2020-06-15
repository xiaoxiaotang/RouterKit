//
//  WYWeakObjDeathNoti.m
//  RouterKit
//
//  Created by 小站 on 2020/4/8.
//

#import "WYWeakObjDeathNoti.h"
#import "NSObject+RT.h"

@interface WYWeakObjDeathNoti ()

@property (nonatomic, copy) WYWeakObjDeathNotiBlock aBlock;

@end

@implementation WYWeakObjDeathNoti

- (void)setBlock:(WYWeakObjDeathNotiBlock)block {
    self.aBlock = block;
}

- (void)setOwner:(id)owner {
    _owner = owner;
    
    [owner objc_setAssociatedObject:[NSString stringWithFormat:@"observerOwner_%p",self] value:self policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
}

- (void)dealloc {
    if (self.aBlock) {
        self.aBlock(self);
    }
    
    self.aBlock = nil;
}

@end

