//
//  KKShareManager.m
//  Link
//
//  Created by Lixiang on 14/10/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKShareManager.h"
#import "DDShareCenter.h"


@implementation KKShareManager
SYNTHESIZE_SINGLETON_FOR_CLASS(KKShareManager);

+ (YYShareActivityView *)defaultInviteWithStatPrefix:(NSString *)statPrefix {
    YYActivityViewItem *item1 = [YYActivityViewItem activityViewItemWithTheme:kLinkThemeShareActivityWeChatFreindButton
                                                                    titleName:_(@"微信好友")];
    item1.actionBlock = ^{
        [[KKShareManager getInstance] inviteViaWechatSessionWithStatPrefix:statPrefix];
    };
    
    YYActivityViewItem *item2 = [YYActivityViewItem activityViewItemWithTheme:kLinkThemeShareActivityWeChatFriendCircleButton
                                                                    titleName:_(@"朋友圈")];
    item2.actionBlock = ^{
        [[KKShareManager getInstance] inviteViaWechatTimelineWithStatPrefix:statPrefix];
    };
    
    YYActivityViewItem *item3 = [YYActivityViewItem activityViewItemWithTheme:kLinkThemeShareActivityQQButton
                                                                    titleName:_(@"QQ好友")];
    item3.actionBlock = ^{
        [[KKShareManager getInstance] inviteViaQQWithStatPrefix:statPrefix];
    };
    
    YYActivityViewItem *item4 = [YYActivityViewItem activityViewItemWithTheme:kLinkThemeShareActivityQzoneButton
                                                                    titleName:_(@"QQ空间")];
    item4.actionBlock = ^{
        [[KKShareManager getInstance] inviteViaQZoneWithStatPrefix:statPrefix];
    };
    
    YYActivityViewItem *item5 = [YYActivityViewItem activityViewItemWithTheme:kLinkThemeShareActivitySinaButton
                                                                    titleName:_(@"新浪微博")];
    item5.actionBlock = ^{
        [[KKShareManager getInstance] inviteViaWeiboWithStatPrefix:statPrefix];
    };
    
    [[DDShareCenter getInstance] pass];
    
    item1.enable = [DDShareCenter checkInstalledWechat];
    item2.enable = [DDShareCenter checkInstalledWechat];
    item3.enable = [DDShareCenter checkInstalledQQ];
    item4.enable = [DDShareCenter checkInstalledQQ];
    item5.enable = [DDShareCenter checkInstalledWeibo];
    
    return [[YYShareActivityView alloc] initWithShareItems:[NSArray arrayWithObjects:item1,item2, nil]
                                                 titleName:_(@"邀请好友:")
                                          horizontalMargin:35
                                         horizontalSpacing:50
                                            verticalMargin:0
                                           verticalSpacing:15
                                                itemHeight:68
                                               countPerRow:2
                                                rowPerPage:2
                                                statPrefix:statPrefix];
}


#pragma mark -
#pragma mark 

- (void)inviteViaWechatSessionWithStatPrefix:(NSString *)statPrefix {
    [[DDShareCenter getInstance] shareWechatWithTitle:kShare_Title desc:kShare_Slogan link:kShare_Url thumbImage:nil scene:0];
}

- (void)inviteViaWechatTimelineWithStatPrefix:(NSString *)statPrefix {
    [[DDShareCenter getInstance] shareWechatWithTitle:kShare_Slogan desc:kShare_Title link:kShare_Url thumbImage:nil scene:1];
}

- (void)inviteViaWeiboWithStatPrefix:(NSString *)statPrefix {
    NSString *share = [NSString stringWithFormat:@"%@ >> %@（来自知产通）", kShare_Slogan, kShare_Url];
    [[DDShareCenter getInstance] shareWeiboWithTitle:share image:[UIImage imageNamed:@"invite_weibo"]];
}

- (void)inviteViaQQWithStatPrefix:(NSString *)statPrefix {
    [[DDShareCenter getInstance] inviteViaQQssoWithScene:0];
    
}

- (void)inviteViaQZoneWithStatPrefix:(NSString *)statPrefix {
    [[DDShareCenter getInstance] inviteViaQQssoWithScene:1];
    
}

@end




