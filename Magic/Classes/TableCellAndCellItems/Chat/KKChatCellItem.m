//
//  KKChatCellItem.m
//  Link
//
//  Created by Lixiang on 14/12/16.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKChatCellItem.h"

#import "KKChatTextCell.h"
#import "KKChatImageCell.h"
#import "KKChatAudioCell.h"

@implementation KKChatCellItem

- (void)initSettings {
    [super initSettings];
    
    self.seperatorLineHidden = YES;
    self.defaultWhiteBgColor = NO;
    self.selectable = NO;
    self.cellSelectionStyle = UITableViewCellSelectionStyleNone;
    self.cellAccessoryType = UITableViewCellAccessoryNone;
}

- (void)setRawObject:(KKChatItem *)rawObject {
    [super setRawObject:rawObject];
    
    if ([rawObject isKindOfClass:[KKChatItem class]]) {
        
        
        switch (rawObject.type) {
            case KKChatTypeText:
                self.contentSize = [rawObject.content sizeConfinedToNumberOfLinesWithThemeUIType:kLinkThemePMTextLabel constrainedWidth:kUI_PM_Text_Width_MAX];
                self.contentSize = CGSizeMake(ceilf(self.contentSize.width + 2 * kUI_TableView_Common_Margin + kUI_PM_Arrow_Width), ceilf(self.contentSize.height + 2 * kUI_TableView_Common_Margin));
                self.cellClass = [KKChatTextCell class];
                break;
            case KKChatTypeImage:
                self.contentSize = CGSizeMake(100, 100);
                self.cellClass = [KKChatImageCell class];
                break;
            case KKChatTypeAudio:
                self.contentSize = CGSizeMake(200, 20);
                self.cellClass = [KKChatAudioCell class];
                break;
            default:
                break;
        }
        
        self.cellIdentifier = [self.cellClass description];
        
        BOOL showDate = rawObject.insertTimestamp - self.lastCreateTime > 60 * 2 * 1000;
        if (rawObject.fake) {
            showDate = NO;
        }
        
        self.shouldShowDate = showDate;
        
//        NSLog(@"date:%f, showDate:%d",self.lastCreateTime, self.shouldShowDate);
        
        self.cellHeight = (showDate ? 3 : 2) * kUI_TableView_Common_Margin + self.contentSize.height;
    }
}

- (void)updateItemForLastCreateTime {
    KKChatItem *chatItem = self.rawObject;
    
    if (chatItem == nil || ![chatItem isKindOfClass:[KKChatItem class]]) {
        return;
    }
    BOOL showDate = chatItem.insertTimestamp - self.lastCreateTime > 60 * 2 * 1000;
    if (chatItem.fake) {
        showDate = NO;
    }
    
    self.shouldShowDate = showDate;
    
//    NSLog(@"date:%f, showDate:%d",self.lastCreateTime, self.shouldShowDate);
    
    self.cellHeight = (showDate ? 3 : 2) * kUI_TableView_Common_Margin + self.contentSize.height;
}

@end
