//
//  WSCertificationManager.m
//  Wuya
//
//  Created by Tong on 14/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "WSCertificationManager.h"

@implementation WSCertificationManager
SYNTHESIZE_SINGLETON_FOR_CLASS(WSCertificationManager);

- (instancetype)init {
    self = [super init];
    if (self) {
        if (![self loadCertification]) {
            [self importCertification];
            [self loadCertification];
        }
    }
    return self;
}


- (BOOL)importCertification
{
    NSData *certFileData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ca" ofType:@"der"]];
    SecCertificateRef cert = SecCertificateCreateWithData(NULL, (__bridge CFDataRef) certFileData);
    if (cert != NULL) {
        OSStatus err = SecItemAdd(
                                  (__bridge CFDictionaryRef) [NSDictionary dictionaryWithObjectsAndKeys:
                                                              (__bridge id) kSecClassCertificate,  kSecClass,
                                                              (__bridge id) cert,                  kSecValueRef,
                                                              nil
                                                              ],
                                  NULL
                                  );
        if ( (err == errSecSuccess) || (err == errSecDuplicateItem) ) {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)loadCertification
{
    CFArrayRef certificates = NULL;
    OSStatus err = SecItemCopyMatching(
                                       (__bridge CFDictionaryRef) [NSDictionary dictionaryWithObjectsAndKeys:
                                                                   (__bridge id) kSecClassCertificate,  kSecClass,
                                                                   kSecMatchLimitAll,          kSecMatchLimit,
                                                                   kCFBooleanTrue,             kSecReturnRef,
                                                                   nil
                                                                   ],
                                       (CFTypeRef *) &certificates
                                       );
    
    if (err == errSecItemNotFound) {
        certificates = CFArrayCreate(NULL, NULL, 0, &kCFTypeArrayCallBacks);
        //        err = noErr;
    }
    
    if (certificates != NULL) {
        self.certificates = (__bridge NSArray *)certificates;
    }
    
    if (certificates != NULL) {
        CFRelease(certificates);
    }
    
    return (self.certificates != nil && self.certificates.count != 0);
}


@end
