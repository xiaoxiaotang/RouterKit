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

#import "NSObject+RT.h"
#import "XZClassProtocolMediator.h"
#import "XZWeakObjDeathNoti.h"

FOUNDATION_EXPORT double RouterKitVersionNumber;
FOUNDATION_EXPORT const unsigned char RouterKitVersionString[];

