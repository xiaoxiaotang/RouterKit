#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSObject+ExtraData.h"
#import "NSObject+RT.h"
#import "WYClassProtocolMediator.h"
#import "WYHandle.h"
#import "WYProtocol.h"
#import "WYRouter.h"
#import "WYRouterKit.h"
#import "WYRouterProtocolHandle.h"
#import "WYWeakObjDeathNoti.h"

FOUNDATION_EXPORT double RouterKitVersionNumber;
FOUNDATION_EXPORT const unsigned char RouterKitVersionString[];

