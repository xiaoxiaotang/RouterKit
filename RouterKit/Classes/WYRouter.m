//
//  WYRouter.m
//  RouterKit
//
//  Created by 小站 on 2020/4/8.
//

#import "WYRouter.h"
#import "WYClassProtocolMediator.h"
#import "NSObject+ExtraData.h"

@interface WYRouter()
@property (nonatomic, strong) UIViewController *routerSource;//当前的控制器 ps：视图层级最高的控制器
@property (nonatomic, strong) Class destinationClass;//获取destination的Class
@property (nonatomic, copy) NSString *routerKey;
@end

@implementation WYRouter

- (instancetype)initWithSource:(UIViewController*)source
                     routerKey:(NSString*)routerKey {
    return [self initWithSource:source routerKey:routerKey context:nil];
}

- (instancetype)initWithSource:(nullable UIViewController*)source routerProtocolKey:(Protocol *)protocolKey {
    NSString *key = NSStringFromProtocol(protocolKey);
    return [self initWithSource:source routerKey:key];
}

- (instancetype)initWithSource:(UIViewController *)source
                     routerKey:(NSString *)routerKey
                       context:(WYClassProtocolMediator *)context {
    if (self = [super init]) {
        _context = context ?: [WYClassProtocolMediator defaultContext];
        self.routerKey = routerKey;
        self.routerSource = source;
        self.animation = true;
        self.destinationClass = [self.context routerClassForKey:routerKey];
        NSAssert([self.destinationClass isSubclassOfClass:[UIViewController class]], @"%@ is not kind of UIViewController.class for key %@", self.destinationClass, routerKey);
    }
    return self;
    
}

- (instancetype)initWithSource:(nullable UIViewController*)source routerProtocolKey:(Protocol *)protocolKey context:(nullable WYClassProtocolMediator*)context {
    NSString *key = NSStringFromProtocol(protocolKey);
    return [self initWithSource:source routerKey:key context:context];
}


- (id)submitWithCompletion:(WYRouterProtocolHandleCompletionBlock)completionBlock {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].keyWindow endEditing:true];
        [super submitWithCompletion:completionBlock];
        
        if (!self.routerSource) {
            self.routerSource = AutoGetRoSourceViewController();
        }
        [self _submitRouterWithCompletion:completionBlock];
    });
    return nil;
}

#pragma mark - Private

//自动判断打开方式
- (WYRouterOptions)_autoGetActionOptions {
    return WYRouterActionPush;
}
//跳转
- (void)_submitRouterWithCompletion:(WYRouterProtocolHandleCompletionBlock)completionBlock {
    //当前控制器
    UIViewController *sourceViewController = self.routerSource;
    //需要跳转的控制器
    UIViewController *destinationViewController = self.destination;
    
    
    if (self.options & WYRouterActionPresent) {
        
        UIViewController *destinationVC = destinationViewController;
        
        if (self.options) {
            if (@available(iOS 13.0, *)) {
                destinationVC.modalPresentationStyle = UIModalPresentationAutomatic;
            } else {
                destinationVC.modalPresentationStyle = UIModalPresentationFullScreen;
            }
            if (self.options & WYRouterPresentPresentStyleFullScreen) {
                destinationVC.modalPresentationStyle = UIModalPresentationFullScreen;
            } else if (self.options & WYRouterPresentPresentStylePageSheet) {
                destinationVC.modalPresentationStyle = UIModalPresentationPageSheet;
            }else if (self.options & WYRouterPresentPresentStyleFormSheet) {
                destinationVC.modalPresentationStyle = UIModalPresentationFormSheet;
            } else if (self.options & WYRouterPresentPresentStyleCurrentContext) {
                destinationVC.modalPresentationStyle = UIModalPresentationCurrentContext;
            }else if (self.options & WYRouterPresentPresentStyleCustom) {
                destinationVC.modalPresentationStyle = UIModalPresentationCustom;
            } else if (self.options & WYRouterPresentPresentStyleOverFullScreen) {
                destinationVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
            }else if (self.options & WYRouterPresentPresentStyleOverCurrentContext) {
                destinationVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            } else if (self.options & WYRouterPresentPresentStylePopover) {
                destinationVC.modalPresentationStyle = UIModalPresentationPopover;
            } else if (self.options & WYRouterPresentPresentStyleNone) {
                destinationVC.modalPresentationStyle = UIModalPresentationNone;
            }
        }
        
        [sourceViewController presentViewController:destinationVC
                                           animated:self.animation
                                         completion:^{
                                             if (completionBlock) {
                                                 completionBlock(nil);
                                             }
                                         }];
        
    } else if (self.options & WYRouterActionPush) {
        
        //导航头
        UINavigationController *navigationController = AutoGetNavigationViewController(sourceViewController);
        NSAssert(navigationController, @"导航控制器不存在");
        
        BOOL shouldResetHideBottomBarWhenPushed = !sourceViewController.hidesBottomBarWhenPushed;
        sourceViewController.hidesBottomBarWhenPushed = true;
        [navigationController pushViewController:destinationViewController animated:self.animation];
        
        if (shouldResetHideBottomBarWhenPushed) {
            self.routerSource.hidesBottomBarWhenPushed = false;
        }
        
        if (completionBlock) {
            completionBlock(nil);
        }
        
    } else {
        self.options = self.options | [self _autoGetActionOptions];
        [self _submitRouterWithCompletion:completionBlock];
    }
}

#pragma mark  get / set

- (UIViewController*)destination {
    if (!_destination && self.destinationClass) {
        NSBundle *bundle = [NSBundle bundleForClass:self.destinationClass];
        
        NSString *className = NSStringFromClass(self.destinationClass);
        BOOL isNibExist = [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@.nib",[bundle resourcePath],className]];
        
        if (isNibExist) {
            _destination = [[self.destinationClass alloc] initWithNibName:NSStringFromClass(self.destinationClass) bundle:bundle];
        } else {
            _destination = [[self.destinationClass alloc] init];
        }
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
