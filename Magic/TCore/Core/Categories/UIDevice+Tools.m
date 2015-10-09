//
//  UIDevice+Tools.m
//  PMP
//
//  Created by Tong on 12/03/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "UIDevice+Tools.h"
#include <sys/sysctl.h>
//#import <AdSupport/AdSupport.h>


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface UIDevice ()

@end

@implementation UIDevice (Tools)

+ (CGFloat)screenScale
{
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
        return [[UIScreen mainScreen] scale];
    }
    return 1.0f;
}

+ (BOOL)is4InchesScreen {
    static int is4Inch = 0;
    if (is4Inch == 0)
        is4Inch = ([[UIScreen mainScreen] bounds].size.height >= 568) ? 1 : -1;
    return is4Inch > 0;
}

+ (BOOL)isRetina {
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
        CGFloat scale = [[UIScreen mainScreen] scale];
        if (scale > 1.0) {
            return YES;
        }
    }
    return NO;
}


+ (CGFloat)screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (BOOL)isInCallStatusBar {
    return [[UIApplication sharedApplication] statusBarFrame].size.height == 40;
}

/*
 *  判断方法根据 apt和Cydia.app的path来判断
 */
+ (BOOL)isJailBreak {
    BOOL jailbroken = NO;
    
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        jailbroken = YES;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        jailbroken = YES;
    }
    
    return jailbroken;
}


+ (BOOL)below5 {
    return SYSTEM_VERSION_LESS_THAN(@"5.0");
}

+ (BOOL)below6 {
    return SYSTEM_VERSION_LESS_THAN(@"6.0");
}

+ (BOOL)below7 {
    return SYSTEM_VERSION_LESS_THAN(@"7.0");
}

+ (BOOL)below8 {
    return SYSTEM_VERSION_LESS_THAN(@"8.0");
}

+ (NSString *)platform {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

+ (NSDictionary*)deviceModelDataForMachineIDs
{
    return @{
             
         //iPad.
         @"iPad1,1" : @[ @"iPad 1G", @"Wi-Fi / GSM", @"A1219 / A1337" ],
         @"iPad2,1" : @[ @"iPad 2", @"Wi-Fi", @"A1395" ],
         @"iPad2,2" : @[ @"iPad 2", @"GSM", @"A1396" ],
         @"iPad2,3" : @[ @"iPad 2", @"CDMA", @"A1397" ],
         @"iPad2,4" : @[ @"iPad 2", @"Wi-Fi Rev A", @"A1395" ],
         @"iPad2,5" : @[ @"iPad mini 1G", @"Wi-Fi", @"A1432" ],
         @"iPad2,6" : @[ @"iPad mini 1G", @"GSM", @"A1454" ],
         @"iPad2,7" : @[ @"iPad mini 1G", @"GSM+CDMA", @"A1455" ],
         @"iPad3,1" : @[ @"iPad 3", @"Wi-Fi", @"A1416" ],
         @"iPad3,2" : @[ @"iPad 3", @"GSM+CDMA", @"A1403" ],
         @"iPad3,3" : @[ @"iPad 3", @"GSM", @"A1430" ],
         @"iPad3,4" : @[ @"iPad 4", @"Wi-Fi", @"A1458" ],
         @"iPad3,5" : @[ @"iPad 4", @"GSM", @"A1459" ],
         @"iPad3,6" : @[ @"iPad 4", @"GSM+CDMA", @"A1460" ],
         @"iPad4,1" : @[ @"iPad Air", @"Wi‑Fi", @"A1474" ],
         @"iPad4,2" : @[ @"iPad Air", @"Cellular", @"A1475" ],
         @"iPad4,4" : @[ @"iPad mini 2G", @"Wi‑Fi", @"A1489" ],
         @"iPad4,5" : @[ @"iPad mini 2G", @"Cellular", @"A1517" ],
         
         //iPhone.
         @"iPhone1,1" : @[ @"iPhone 2G", @"GSM", @"A1203" ],
         @"iPhone1,2" : @[ @"iPhone 3G", @"GSM", @"A1241 / A13241" ],
         @"iPhone2,1" : @[ @"iPhone 3GS", @"GSM", @"A1303 / A13251" ],
         @"iPhone3,1" : @[ @"iPhone 4", @"GSM", @"A1332" ],
         @"iPhone3,2" : @[ @"iPhone 4", @"GSM Rev A", @"-" ],
         @"iPhone3,3" : @[ @"iPhone 4", @"CDMA", @"A1349" ],
         @"iPhone4,1" : @[ @"iPhone 4S", @"GSM+CDMA", @"A1387 / A14311" ],
         @"iPhone5,1" : @[ @"iPhone 5", @"GSM", @"A1428" ],
         @"iPhone5,2" : @[ @"iPhone 5", @"GSM+CDMA", @"A1429 / A14421" ],
         @"iPhone5,3" : @[ @"iPhone 5C", @"GSM", @"A1456 / A1532" ],
         @"iPhone5,4" : @[ @"iPhone 5C", @"Global", @"A1507 / A1516 / A1526 / A1529" ],
         @"iPhone6,1" : @[ @"iPhone 5S", @"GSM", @"A1433 / A1533" ],
         @"iPhone6,2" : @[ @"iPhone 5S", @"Global", @"A1457 / A1518 / A1528 / A1530" ],
         
         //iPod.
         @"iPod1,1" : @[ @"iPod touch 1G", @"-", @"A1213" ],
         @"iPod2,1" : @[ @"iPod touch 2G", @"-", @"A1288" ],
         @"iPod3,1" : @[ @"iPod touch 3G", @"-", @"A1318" ],
         @"iPod4,1" : @[ @"iPod touch 4G", @"-", @"A1367" ],
         @"iPod5,1" : @[ @"iPod touch 5G", @"-", @"A1421 / A1509" ],
         
         //Similuator
         @"x86_64" : @[ @"模拟器", @"x64" ]
             
     };
}

+ (NSString *)stringForPlatform {
    NSDictionary *models = [[self class]deviceModelDataForMachineIDs];
    NSString *rawModel = [[self class]platform];
    NSArray *thisModelArray = [models objectForKey:rawModel];
    if (thisModelArray != nil) {
        return [thisModelArray componentsJoinedByString:@" "];
    }
    return [NSString stringWithFormat:@"Unknown Model:%@", rawModel];
}

//+ (NSString *)deviceIdentifier {
//    NSUUID *idfa  = [ASIdentifierManager sharedManager].advertisingIdentifier;
//    return idfa.UUIDString;
//}

#pragma mark -
#pragma mark Push
+ (BOOL)pushEnabled {
    BOOL pushEnabled=NO;
    if ([UIDevice below8]) {
        UIRemoteNotificationType types = [[UIApplication sharedApplication]        enabledRemoteNotificationTypes];
        
        pushEnabled = (types & UIRemoteNotificationTypeAlert);
        
    } else {
        pushEnabled = [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
    }
    
    return pushEnabled;
}

@end
