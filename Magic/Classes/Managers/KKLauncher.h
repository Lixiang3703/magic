//
//  KKLauncher.h
//  Link
//
//  Created by Lixiang on 14/10/25.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "DDLauncher.h"

@interface KKLauncher : DDLauncher


/** Singleton */
+ (KKLauncher *)getInstance;



- (void)checkUserInfoWithSuccessBlock:(WSSuccessBlock)successBlock failBlock:(WSFailBlock)failBlock;

@end
