//
//  XZHandle.m
//  RouterKit
//
//  Created by 小站 on 2020/4/8.
//

#import "XZHandle.h"
#import "XZClassProtocolMediator.h"

NSString const *XZHandlerCallBackKey = @"handlerCallBackKey";

@interface XZHandle ()

@property (nonatomic, strong) NSString *handlerKey;

@end

@implementation XZHandle

+ (id)realizeWithHandlerInstanceKey:(NSString *)handlerInstanceKey {
    id instance = [[XZClassProtocolMediator defaultContext] handlerInstanceForKey:handlerInstanceKey];
    if (!instance) {
        Class aClass = NSClassFromString(handlerInstanceKey);
        instance = [[aClass alloc] init];
        [[XZClassProtocolMediator defaultContext] registerHandlerInstance:instance forKey:handlerInstanceKey];
    }
    return instance;
}

- (instancetype)initWithHandlerKey:(NSString*)handlerKey {
    return [self initWithHandlerKey:handlerKey context:nil];
}

- (instancetype)initWithHandlerKey:(NSString*)handlerKey
                           context:(nullable XZClassProtocolMediator*)context {
    if (self = [super init]) {
        _context = context ?: [XZClassProtocolMediator defaultContext];
        self.handlerKey = handlerKey;
    }
    return self;
}

+ (void)realizeWithHandlerArray:(NSArray *)handlerKeys releaseHandler:(BOOL)isReleaseHandler  {
    
    for (id param in handlerKeys) {
        
        NSString *key;
        NSDictionary *dict;
        XZRouterProtocolHandleCompletionBlock block;
        
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
        
        XZHandle *handler = [[XZHandle alloc] initWithHandlerKey:key];
        [handler setExtraDataWithDictionary:dict];
        [handler submitWithCompletion:^(id  _Nullable data) {
            if (isReleaseHandler) {
                [[XZClassProtocolMediator defaultContext] unRegisterHandlerForKey:key];
            }
            if (block) {
                block(data);
            }
        }];
    }
}


- (id)submitWithCompletion:(XZRouterProtocolHandleCompletionBlock)completionBlock {
    
    XZClassProtocolMediatorBlock block = (XZClassProtocolMediatorBlock)self.destination;
    if (block) {
        block(self.extraData, completionBlock);
    }
    return nil;
}


#pragma mark - get / set
- (XZRouterProtocolHandleCompletionBlock)destination {
    if (!_destination) {
        _destination = [self.context handlerForKey:self.handlerKey];
    }
    return _destination;
}

@end



