//
//  DDAddressBookManager.h
//  Link
//
//  Created by Lixiang on 14/10/25.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "DDSingletonObject.h"

typedef void (^DDAddressBookManagerHandleBlock)(NSSet *diffSet);

@interface DDAddressBookManager : DDSingletonObject

@property (nonatomic, strong) NSDictionary *contactDict;

/** Singleton */
+ (DDAddressBookManager *)getInstance;

/** AddressBook Operations */
- (void)loadWholeAddressBookContactsWithSuccessBlock:(void (^)(NSSet *wholeSet))successBlock;
- (BOOL)checkAddressBookPermission;

/** Diff Operation */
- (void)checkAddressBookDiffWithSuccessBlock:(DDAddressBookManagerHandleBlock)successBlock failBlock:(DDAddressBookManagerHandleBlock)failBlock;
- (void)checkAddressBookDiffWithSuccessBlock:(DDAddressBookManagerHandleBlock)successBlock failBlock:(DDAddressBookManagerHandleBlock)failBlock register:(BOOL)isRegisterStatus;

/** Upload Contact to server, need overwrite by sub class */
- (void)uploadContactsWithWholePhoneNumbers:(NSSet *)wholeSet diffPhoneNumbers:(NSSet *)diffSet successBlock:(DDAddressBookManagerHandleBlock)successBlock failBlock:(DDAddressBookManagerHandleBlock)failBlock;

/** For Debug */
- (void)purgeLastAddressBook;

/** String */
+ (NSString *)phoneNumberFilter:(NSString *)phoneNumber;
+ (NSString *)phoneNumberFilterOnlyMobile:(NSString *)phoneNumber;

@end
