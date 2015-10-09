//
//  KKChatTextCell.m
//  Link
//
//  Created by Lixiang on 14/12/16.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKChatTextCell.h"
#import "KKChatCellItem.h"
#import "KKAccountItem.h"

@implementation KKChatTextCell

#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.pmTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(kUI_TableView_Common_Margin, kUI_TableView_Common_Margin, self.pmContentView.width - 2 * kUI_TableView_Common_Margin - kUI_PM_Arrow_Width, self.pmContentView.height - 2 * kUI_TableView_Common_Margin)];
        [self.pmTextLabel setThemeUIType:kThemePMTextLabel];
        [self.pmTextLabel fullfillPrarentView];
        
        [self.pmContentView insertSubview:self.pmTextLabel atIndex:0];
    }
    return self;
}

- (void)setValuesWithCellItem:(KKChatCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    KKChatItem *chatItem = (KKChatItem *)cellItem.rawObject;
    if (![chatItem isKindOfClass:[KKChatItem class]]) {
        return;
    }
    
    BOOL mine = (chatItem.mine == DDBaseItemBoolTrue);
    if (!mine && chatItem.userId == [KKAccountItem sharedItem].userId) {
        mine = YES;
    }
    
    self.pmContentView.backgroundColor = mine ? [UIColor KKPMMineColor] : [UIColor KKPMOtherColor];
    
    self.pmTextLabel.left = mine ? kUI_TableView_Common_Margin : kUI_TableView_Common_Margin + kUI_PM_Arrow_Width;
    self.pmTextLabel.text = chatItem.content;
    
    [self.pmTextLabel.layer removeAllAnimations];
    
}

@end
