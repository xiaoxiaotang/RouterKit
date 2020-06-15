//
//  WYHandle.m
//  RouterKit
//
//  Created by 小站 on 2020/4/8.
//

#import "WYHandle.h"
#import "WYClassProtocolMediator.h"

NSString const *WYHandlerCallBackKey = @"handlerCallBackKey";

@interface WYHandle ()

@property (nonatomic, strong) NSString *handlerKey;

@end

@implementation WYHandle

+ (id)realizeWithHandlerInstanceKey:(NSString *)handlerInstanceKey {
    id instance = [[WYClassProtocolMediator defaultContext] handlerInstanceForKey:handlerInstanceKey];
    if (!instance) {
        Class aClass = NSClassFromString(handlerInstanceKey);
        instance = [[aClass alloc] init];
        [[WYClassProtocolMediator defaultContext] registerHandlerInstance:instance forKey:handlerInstanceKey];
    }
    return instance;
}

- (instancetype)initWithHandlerKey:(NSString*)handlerKey {
    return [self initWithHandlerKey:handlerKey context:nil];
}

- (instancetype)initWithHandlerKey:(NSString*)handlerKey
                           context:(nullable WYClassProtocolMediator*)context {
    if (self = [super init]) {
        _context = context ?: [WYClassProtocolMediator defaultContext];
        self.handlerKey = handlerKey;
    }
    return self;
}

+ (void)realizeWithHandlerArray:(NSArray *)handlerKeys releaseHandler:(BOOL)isReleaseHandler  {
    
    for (id param in handlerKeys) {
        
        NSString *key;
        NSDictionary *dict;
        WYRouterProtocolHandleCompletionBlock block;
        
        if ([param isKindOfClass:[NSString class]]) {
            key = param;
        }
        
        if ([param isKindOfClass:[NSArray class]]) {
            NSArray *arys = param;
            
            for (id ary in arys) {
                if ([ary isKindOfClass:[NSString class]]) {
                    key = ary;
                } else if ([ary isKindOfClass:[NSDictionary class]]) {
                    dict = ary;
                }  else {
                    block = ary;
                }
            }
        }
        
        WYHandle *handler = [[WYHandle alloc] initWithHandlerKey:key];
        [handler setExtraDataWithDictionary:dict];
        [handler submitWithCompletion:^(id  _Nullable data) {
            if (isReleaseHandler) {
                [[WYClassProtocolMediator defaultContext] unRegisterHandlerForKey:key];
            }
            if (block) {
                block(data);
            }
        }];
    }
}


- (id)submitWithCompletion:(WYRouterProtocolHandleCompletionBlock)completionBlock {
    
    WYClassProtocolMediatorBlock block = (WYClassProtocolMediatorBlock)self.destination;
    if (block) {
        block(self.extraData, completionBlock);
    }
    return nil;
}


#pragma mark - get / set
- (WYRouterProtocolHandleCompletionBlock)destination {
    if (!_destination) {
        _destination = [self.context handlerForKey:self.handlerKey];
    }
    return _destination;
}

@end



