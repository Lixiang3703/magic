//
//  KKChatSessionCellItem.m
//  Link
//
//  Created by Lixiang on 14/12/15.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKChatSessionCellItem.h"

@implementation KKChatSessionCellItem

- (void)initSettings {
    [super initSettings];
    
    self.swipable = NO;
    self.cellHeight = kUI_ImageSize_ChatSession_Avatar + 2 * kUI_TableView_Common_Margin;
}


@end
