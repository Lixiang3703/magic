//
//  DDIntroItem.h
//  Wuya
//
//  Created by Tong on 25/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDBaseItem.h"

@interface DDIntroItem : DDBaseItem

// jiemo 1.0
@property (nonatomic, assign) BOOL matchShown;
@property (nonatomic, assign) BOOL matchMutualHobbyShown;

@property (nonatomic, assign) BOOL matchLikeShown;
@property (nonatomic, assign) BOOL matchunLikeShown;

@property (nonatomic, assign) BOOL welecomeShow;
@property (nonatomic, assign) BOOL chatDetailIntroShow;

@property (nonatomic, assign) BOOL followIntroFlag;
@property (nonatomic, assign) BOOL profileTakePhotoIntroFlag;
@property (nonatomic, assign) BOOL profileAuthorTipIntroFlag;
@property (nonatomic, assign) BOOL chatIntroFlag;

@property (nonatomic, assign) BOOL chatDetailKeyboardIntroFlag;
@property (nonatomic, assign) BOOL chatDetailOneItemIntroFlag;


//  TODO: Delete
@property (nonatomic, assign) BOOL myRssIntroFlag;
@property (nonatomic, assign) BOOL commentPersonIntroFlag;
@property (nonatomic, assign) BOOL postInsufficientFriendsFriend;
@property (nonatomic, assign) BOOL postSufficientFriend;
@property (nonatomic, assign) BOOL postSufficientFriendsFriend;
@property (nonatomic, assign) BOOL didShowNearbyFeed;
@property (nonatomic, assign) BOOL fullfillDetailIntroFlag;

// appScore added since v1.1
@property (nonatomic, copy) NSString *lastAppScoreReviewGuideShowDate;
@property (nonatomic, assign) NSInteger appScoreReviewGuideTotalShowCounts;
@property (nonatomic, assign) BOOL appStoreReviewGuideShown;

// friend impression added since v1.2
@property (nonatomic, assign) BOOL friendImpressionGuideShown;

// nearby intro added since v2.0
@property (nonatomic, assign) BOOL didShowNearbyIntro;

// friend impression added since v2.2
@property (nonatomic, assign) BOOL contactGuideShown;

//  group chat added since v2.2.5
@property (nonatomic, assign) BOOL groupChatGuideShown;

//  userInfoComplete added since v2.3
@property (nonatomic, assign) BOOL userInfoCompleteShown;

// match added since v2.6.2
@property (nonatomic, assign) BOOL matchIntroShown;

+ (DDIntroItem *)sharedItem;

@end
