//
//  DDAddressBookManager.m
//  Link
//
//  Created by Lixiang on 14/10/25.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "DDAddressBookManager.h"
#import "APAddressBook.h"
#import "APContact.h"

#import "UIAlertView+Blocks.h"

@interface DDAddressBookManager ()

@property (nonatomic, readonly) NSString *lastAddressBookPath;

@property (nonatomic, strong) APAddressBook *addressBook;

@end

@implementation DDAddressBookManager
SYNTHESIZE_SINGLETON_FOR_CLASS(DDAddressBookManager);

#pragma mark -
#pragma mark Accessors
- (NSString *)lastAddressBookPath {
    NSString *mobile = @"13800001111";
    return nil == mobile ? nil : [NSString filePathOfDocumentFolderWithName:[NSString stringWithFormat:@"iBristol%@", mobile]];
}

- (NSDictionary *)contactDict {
    if (_contactDict == nil) {
//        [self loadWholeAddressBookContactsWithSuccessBlock:nil];
    }
    return _contactDict;
}

#pragma mark -
#pragma mark Initialization
- (instancetype)init {
    self = [super init];
    if (self) {
        self.addressBook = [[APAddressBook alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidReceiveMemoryWarningNotification:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

#pragma mark -
#pragma mark Notification
- (void)applicationDidReceiveMemoryWarningNotification:(NSNotification *)notification {
    self.contactDict = nil;
}

#pragma mark -
#pragma mark AddressBook Operations

- (void)loadWholeAddressBookContactsWithSuccessBlock:(void (^)(NSSet *wholeSet))successBlock {
    if (![self checkAddressBookPermission]) {
        return;
    }
    
    __weak __typeof(self)weakSelf = self;
    
    [self.addressBook loadContactsOnQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) completion:^(NSArray *contacts, NSError *error) {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:1];
        NSMutableSet *phoneNumbers = [NSMutableSet set];
        [contacts enumerateObjectsUsingBlock:^(APContact *contact, NSUInteger idx, BOOL *stop) {
            [contact.phones enumerateObjectsUsingBlock:^(NSString *phoneNumber, NSUInteger idx, BOOL *stop) {
                [phoneNumbers addSafeObject:[DDAddressBookManager phoneNumberFilter:phoneNumber]];
                NSMutableString *name = [NSMutableString string];
                if (contact.lastName) {
                    [name appendString:contact.lastName];
                }
                if (contact.firstName) {
                    [name appendString:[NSString stringWithFormat:@" %@", contact.firstName]];
                }
                NSString *nameStr = name;
                NSString *number = [DDAddressBookManager phoneNumberFilterOnlyMobile:phoneNumber];
                if (number) {
                    [dict setObject:[nameStr trim] forKey:number];
                }
            }];
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.contactDict = [NSDictionary dictionaryWithDictionary:dict];
            if (nil != successBlock) {
                successBlock(phoneNumbers);
            }
        });
        
    }];
}

- (BOOL)checkAddressBookPermission {
    BOOL permit = NO;
    switch ([APAddressBook access]) {
        case APAddressBookAccessUnknown:
            permit = YES;
            break;
        case APAddressBookAccessGranted:
            permit = YES;
            break;
        case APAddressBookAccessDenied:
            
            break;
        default:
            break;
    }
    return permit;
}


#pragma mark -
#pragma mark Diff Opration
- (void)checkAddressBookDiffWithSuccessBlock:(DDAddressBookManagerHandleBlock)successBlock failBlock:(DDAddressBookManagerHandleBlock)failBlock {
    [self checkAddressBookDiffWithSuccessBlock:successBlock failBlock:failBlock register:NO];
}

- (void)checkAddressBookDiffWithSuccessBlock:(DDAddressBookManagerHandleBlock)successBlock failBlock:(DDAddressBookManagerHandleBlock)failBlock register:(BOOL)isRegisterStatus {
    NSSet *lastAddressBookSet = [NSSet setWithArray:[NSArray arrayWithContentsOfFile:self.lastAddressBookPath]];
    
    __weak typeof(self)weakSelf = self;
    [self loadWholeAddressBookContactsWithSuccessBlock:^(NSSet *wholeSet) {
        NSMutableSet *diffSet = [NSMutableSet setWithSet:wholeSet];
        if (!isRegisterStatus) {
            [diffSet minusSet:lastAddressBookSet];
        }
        
        if (isRegisterStatus || [diffSet count] > 0) {
            
            if ([lastAddressBookSet count] != 0 && !isRegisterStatus && ([diffSet count] >  kWS_AddressBook_Upload_MaxCount)) {
                RIButtonItem *cancelBnt = [RIButtonItem itemWithLabel:_(@"取消")];
                RIButtonItem *okBnt = [RIButtonItem itemWithLabel:_(@"立即更新")];
                okBnt.action = ^{
                    [weakSelf uploadContactsWithWholePhoneNumbers:wholeSet diffPhoneNumbers:diffSet successBlock:successBlock failBlock:failBlock];
                };
                [[[UIAlertView alloc] initWithTitle:_(@"发现通讯录好友")
                                            message:_(@"发现新的通讯录好友，是否更新你的朋友圈列表？\n如果不是你的通讯录，建议不要更新，否则会影响你朋友圈的内容。")
                                   cancelButtonItem:cancelBnt
                                   otherButtonItems:okBnt, nil] show];
            } else {
                [weakSelf uploadContactsWithWholePhoneNumbers:wholeSet diffPhoneNumbers:diffSet successBlock:successBlock failBlock:failBlock];
            }
            
        } else {
            DDLog(@"Address Book is the same");
        }
        
    }];
}

#pragma mark -
#pragma mark uploadContacts
- (void)uploadContactsWithWholePhoneNumbers:(NSSet *)wholeSet diffPhoneNumbers:(NSSet *)diffSet successBlock:(DDAddressBookManagerHandleBlock)successBlock failBlock:(DDAddressBookManagerHandleBlock)failBlock {

}

- (void)purgeLastAddressBook {
    [[NSFileManager defaultManager] removeItemAtPath:self.lastAddressBookPath error:nil];
}

#pragma mark -
#pragma mark Upload diff phones


#pragma mark -
#pragma mark Phone number filter method
+ (NSString *)phoneNumberFilter:(NSString *)phoneNumber {
    
    NSString *numberOnly = [[phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    
    if (numberOnly.length >= 11) {
        numberOnly =[numberOnly substringFromIndex:numberOnly.length - 11];
    } else if (0 == numberOnly.length) {
        numberOnly = nil;
    }
    return numberOnly;
}

+ (NSString *)phoneNumberFilterOnlyMobile:(NSString *)phoneNumber {
    
    NSString *numberOnly = [[phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    
    if (numberOnly.length != 11) {
        if ([numberOnly rangeOfString:@"86"].location == 0) {
            numberOnly = [numberOnly substringFromIndex:2];
            return numberOnly;
        }
        return nil;
    }
    else
        if (![[numberOnly substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]) {
            return nil;
        };
    
    return numberOnly;
}
@end
