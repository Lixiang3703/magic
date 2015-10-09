//
//  PMBaseItem.m
//  PMP
//
//  Created by Tong on 06/03/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import <objc/runtime.h>
#import "DDBaseItem.h"
#import "NSObject+Tools.h"
#import "NSArray+Tools.h"
#import "NSDictionary+Tools.h"


@implementation DDBaseItem

#pragma mark -
#pragma mark Life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        [self customSettingsBeforeAutoParse];
    }
    return self;
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [self init];
    if (self) {
        [self keyValuesAssignmentWithDict:dict];
    }
    return self;
}

- (void)keyValuesAssignmentWithDict:(NSDictionary *)dict {
    NSArray *keys = [dict allKeys];
    
    for (NSString *key in keys) {
        id value = dict[key];
        
        if (nil != value && [self shouldReadProperty:key fromInfoDict:dict] && [self respondsToSelector:NSSelectorFromString(key)]) {
            
            if (![value isKindOfClass:[NSNull class]]) {
                [self setValue:value forKey:key];
            }
            
        }
    }
}

- (void)customSettingsBeforeAutoParse {
    //  Assignment -1 for all int values
    NSArray *allPrimitiveShotTypes = [[self class] allPrimitiveShotTypes];
    
    unsigned int count;
    objc_property_t* props = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = props[i];
        const char * name = property_getName(property);
        NSString *propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        const char * type = property_getAttributes(property);
        
        NSString * typeString = [NSString stringWithUTF8String:type];
        NSArray * attributes = [typeString componentsSeparatedByString:@","];
        NSString * typeAttribute = [attributes objectAtIndex:0];
        NSString * propertyType = [typeAttribute substringFromIndex:1];
        
        //  对于只读的属性，就忽略
        if ([allPrimitiveShotTypes containsObject:propertyType] && ![attributes containsObject:@"R"]) {
            [self setValue:@(-1) forKey:propertyName];
        }
    }
    free(props);
}

#pragma mark -
#pragma mark Primitives type

+ (NSArray *)allPrimitiveShotTypes {
    static NSArray *res = nil;
    
    if (nil == res) {
        res = @[
                [NSString stringWithUTF8String:@encode(short)],
                //                [NSString stringWithUTF8String:@encode(char)],
                [NSString stringWithUTF8String:@encode(int)],
                //                [NSString stringWithUTF8String:@encode(unsigned int)],
                [NSString stringWithUTF8String:@encode(long)],
                //                [NSString stringWithUTF8String:@encode(unsigned long)],
                [NSString stringWithUTF8String:@encode(float)],
                [NSString stringWithUTF8String:@encode(double)],
                [NSString stringWithUTF8String:@encode(size_t)]];
    }
    return res;
}


#pragma mark -
#pragma mark Dict methods

- (NSMutableDictionary *)infoDict {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //  Add Class
    NSArray *allProperties = [[self class] allProperties];
    for (NSString *property in allProperties) {
        id object = [self valueForKey:property];

        if (nil != object && [self shouldAddProperty:property intoInfoDict:dict]) {
            
            if ([object isKindOfClass:[DDBaseItem class]]) {
                if (object != nil) {
                    [dict setSafeObject:[object infoDict] forKey:[property substringToIndex:property.length - 4]];
                }
            } else {
                [dict setSafeObject:object forKey:property];
            }
        }

    }
    return dict;
}

- (BOOL)shouldAddProperty:(NSString *)property intoInfoDict:(NSMutableDictionary *)infoDict {
    return YES;
}

- (void)propertyDidAddWithProperty:(NSString *)property dict:(NSMutableDictionary *)infoDict {

}

- (BOOL)shouldReadProperty:(NSString *)property fromInfoDict:(NSDictionary *)infoDict {
    return YES;
}

- (void)propertyDidReadWithProperty:(NSString *)property dict:(NSDictionary *)infoDict {

}

+ (id)itemWithDict:(NSDictionary *)dict {
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    DDBaseItem *item = [[[self class] alloc] initWithDict:dict];
    return item;
}

#pragma mark -
#pragma mark Sub Items
+ (NSArray *)itemsFromInfo:(NSDictionary *)dict keyword:(NSString *)keyword withClass:(Class)itemClass {
    NSArray *array = [dict objectForSafeKey:keyword];
    if (![array isKindOfClass:[NSArray class]]) {
        return nil;
    }
    __block NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:[array count]];
    [array enumerateObjectsUsingBlock:^(NSDictionary *itemInfo, NSUInteger idx, BOOL *stop) {
        DDBaseItem *baseItem = [[itemClass alloc] initWithDict:itemInfo];
        [tempArray addSafeObject:baseItem];
    }];
    if ([tempArray count] > 0) {
        return tempArray;
    }
    return nil;
}

#pragma mark -
#pragma mark Copy
- (void)copyValuesFromDict:(NSDictionary *)dict {
    NSArray *keys = [dict allKeys];
    
    for (NSString *key in keys) {
        id value = dict[key];
        
        if (nil != value && [self shouldReadProperty:key fromInfoDict:dict] && [self respondsToSelector:NSSelectorFromString(key)]) {
            [self setValue:value forKey:key];
        }
    }
}

#pragma mark -
#pragma mark Save and Load

+ (NSString *)savePath {
    return [NSString filePathOfDocumentFolderWithName:[NSString stringWithFormat:@"MyHouse%@", [[self class] description]]];
}

- (void)clear {
    
}

- (void)clearAndSave {
    [self customSettingsBeforeAutoParse];
    [self clear];
    [self save];
}

- (void)save {
    
    NSDictionary *info = [self infoDict];
    
    if (nil != info) {
        [info writeToFile:[[self class] savePath] atomically:YES];
    }
}

+ (id)loadSavedItem {
    NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:[[self class] savePath]];
    DDBaseItem *baseItem = [[self class] itemWithDict:info];
    
    if (nil == baseItem) {
        baseItem = [[[self class] alloc] init];
    }
    return baseItem;
}

+ (DDBaseItemBool)reversValueFor:(DDBaseItemBool)baseItemBool {
    DDBaseItemBool res = baseItemBool;
    switch (baseItemBool) {
        case DDBaseItemBoolUnknown:
        case DDBaseItemBoolFalse:
            res = DDBaseItemBoolTrue;
            break;
        case DDBaseItemBoolTrue:
            res = DDBaseItemBoolFalse;
            break;
        default:
            break;
    }
    return res;
}

@end
