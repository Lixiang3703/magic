//
//  KKShareManager.h
//  Link
//
//  Created by Lixiang on 14/10/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "DDSingletonObject.h"

#import "YYShareActivityView.h"

#define kShare_Url                  _(@"http://203.195.135.158:8081/magic.web/app.html")

#define kShare_Title                _(@"知产通App")
#define kShare_Slogan               _(@"贴心的知识产权综合服务专家")


@interface KKShareManager : DDSingletonObject

/** Singleton */
+ (KKShareManager *)getInstance;

/**  */
+ (YYShareActivityView *)defaultInviteWithStatPrefix:(NSString *)statPrefix;

/**  */
- (void)inviteViaWechatSessionWithStatPrefix:(NSString *)statPrefix;
- (void)inviteViaWechatTimelineWithStatPrefix:(NSString *)statPrefix;
- (void)inviteViaWeiboWithStatPrefix:(NSString *)statPrefix;

- (void)inviteViaQQWithStatPrefix:(NSString *)statPrefix;
- (void)inviteViaQZoneWithStatPrefix:(NSString *)statPrefix;
@end
