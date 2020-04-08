//
//  XZProtocol.m
//  RouterKit
//
//  Created by 小站 on 2020/4/8.
//

#import "XZProtocol.h"
#import "NSObject+ExtraData.h"
#import "XZClassProtocolMediator.h"

@interface XZProtocol()
@property (nonatomic, strong, readonly) id destination;
@property (nonatomic, strong) Class destinationClass;//获取destination的Class
@property (nonatomic, strong) id destinationInstance;//获取destination的实例对象
@end


@implementation XZProtocol

+ (id)createInstanceWithProtocolKey:(Protocol *)protocolKey {
    XZProtocol *protocol = [[XZProtocol alloc] initWithProtocolKey:protocolKey];
    return [protocol submit];
}

+ (id)sharedInstanceWithProtocolKey:(Protocol *)protocolKey {
    XZProtocol *protocol = [[XZProtocol alloc] initWithProtocolInstanceKey:protocolKey];
    return [protocol submit];
}

+ (id)replaceSharedInstance:(id)instance protocolKey:(Protocol *)protocolKey {
    XZProtocol *protocol = [[XZProtocol alloc] initWithProtocolInstanceKey:protocolKey aInstance:instance];
    return [protocol submit];
}

+ (Class)classFromProtocol:(Protocol *)protocolKey {
    XZProtocol *protocol = [[XZProtocol alloc] initWithProtocolKey:protocolKey];
    return protocol.destinationClass;
}

- (instancetype)initWithProtocolKey:(Protocol *)protocolKey {
    if (self = [super init]) {
        _context = [XZClassProtocolMediator defaultContext];
        self.destinationClass = [self.context protocolClassForKey:protocolKey];
    }
    return self;
}

- (instancetype)initWithProtocolInstanceKey:(Protocol *)protocolKey {
    if (self = [super init]) {
        _context = [XZClassProtocolMediator defaultContext];
        
        id instance = [self.context protocolInstanceClassForKey:protocolKey];
        if (instance) {
            self.destinationInstance = instance;
        } else {
            self.destinationClass = [self.context protocolClassForKey:protocolKey];
            [self.context registerProtocolInstance:self.destination forKey:protocolKey];
        }
    }
    return self;
}

- (instancetype)initWithProtocolInstanceKey:(Protocol *)protocolKey aInstance:(id)instance {
    if (self = [super init]) {
        _context = [XZClassProtocolMediator defaultContext];
        [self.context registerProtocolInstance:instance forKey:protocolKey];
        self.destinationInstance = instance;
    }
    return self;
}

/**
 *  提交行动
 */
- (id)submit {
    return [self destination];
}

#pragma mark  get / set

- (id)destination {
    if (self.destinationInstance) {
        return self.destinationInstance;
    }
    if (!_destination && self.destinationClass) {
        _destination = [[self.destinationClass alloc] init];
    }
    return _destination;
}

- (void)setExtraData:(NSDictionary *)extraData {
    [super setExtraData:extraData];
    if ([self.destination isKindOfClass:[NSObject class]]) {
        ((NSObject*)self.destination).extraData = extraData;
    }
}

@end
