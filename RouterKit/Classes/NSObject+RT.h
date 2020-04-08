//
//  NSObject+RT.h
//  RouterKit
//
//  Created by 小站 on 2020/4/8.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString *const objectTypeNotHandled;
FOUNDATION_EXTERN NSString *const objectTypeClass;

FOUNDATION_EXTERN NSString *const objectTypeRawInt;
FOUNDATION_EXTERN NSString *const objectTypeRawFloat;
FOUNDATION_EXTERN NSString *const objectTypeRawPointer;

@interface NSObject (RT)
@property (nonatomic, strong, readonly) NSMutableArray *associatedObjectNames;
@property (nonatomic, strong, readonly) NSArray<NSString*> *properties;
@property (nonatomic, strong, readonly) NSArray<NSDictionary<NSString*, NSString*>*> *propertyInfos;//KEY:propertyName, Value:propertyType

/**
 *  为当前object动态增加分类
 *
 *  @param propertyName   分类名称
 *  @param value  分类值
 *  @param policy 分类内存管理类型
 */
- (void)objc_setAssociatedObject:(NSString *)propertyName value:(id)value policy:(objc_AssociationPolicy)policy;

/**
 *  获取当前object某个动态增加的分类
 *
 *  @param propertyName 分类名称
 *
 *  @return 值
 */
- (id)objc_getAssociatedObject:(NSString *)propertyName;

- (void)objc_removeAssociatedObjectForPropertyName: (NSString*)propertyName;

/**
 *  删除动态增加的所有分类
 */
- (void)objc_removeAssociatedObjects;

+ (BOOL)overrideMethod:(SEL)origSel withMethod:(SEL)altSel;

+ (BOOL)overrideClassMethod:(SEL)origSel withClassMethod:(SEL)altSel;

+ (BOOL)exchangeMethod:(SEL)origSel withMethod:(SEL)altSel;

+ (BOOL)exchangeClassMethod:(SEL)origSel withClassMethod:(SEL)altSel;

@end

NS_ASSUME_NONNULL_END
