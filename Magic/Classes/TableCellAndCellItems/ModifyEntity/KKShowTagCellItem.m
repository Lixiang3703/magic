//
//  KKShowTagCellItem.m
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKShowTagCellItem.h"

@interface KKShowTagCellItem()

@property (nonatomic, assign) CGFloat titleLabel_shortWidth;
@property (nonatomic, assign) CGFloat titleLabel_longWidth;

@end

@implementation KKShowTagCellItem

- (void)initSettings {
    [super initSettings];
    
    self.titleLabel_shortWidth = [UIDevice screenWidth] - 2*kUI_Login_Common_MarginW - 2 * kUI_Login_Common_MarginW - kUI_Profile_Tag_TagLabel_Width;
    self.titleLabel_longWidth = [UIDevice screenWidth] - 2*kUI_Login_Common_MarginW;
}

- (void)setRawObject:(id)rawObject {
    [super setRawObject:rawObject];
    
    KKShowTagItem *showTagItem = (KKShowTagItem *)rawObject;
    if (![showTagItem isKindOfClass:[KKShowTagItem class]]) {
        return;
    }
//    [self updateCellItemWithPersonItem:showTagItem];
}

- (void)updateCellItemWithTagItem:(KKShowTagItem *)showTagItem {
    
    self.rawObject = showTagItem;
    
    if (showTagItem.cellLayoutType == KKShowTagCellLayoutTypeFloatTop) {
        self.titleLabelHeight = [showTagItem.titleName heightWithFont:[UIFont systemFontOfSize:16] constrainedWidth:self.titleLabel_longWidth];
        
        self.titleLabelHeight *= 1.52;
        
        self.cellHeight = kUI_Profile_Tag_TagLabel_Height + kUI_Profile_Tag_TagLabel_MarginTop + self.titleLabelHeight + kUI_Profile_Tag_TitleLabel_MarginTop  + kUI_Profile_Tag_TitleLabel_MarginBottom;
        
        if (!showTagItem.tagName || showTagItem.tagName.length == 0) {
            
        }
        else {
            self.cellHeight = self.titleLabelHeight + kUI_TableView_Common_Margin * 2;
        }
    }
    else if (showTagItem.cellLayoutType == KKShowTagCellLayoutTypeFloatLeft) {
        self.titleLabelHeight = [showTagItem.titleName heightWithFont:[UIFont systemFontOfSize:16] constrainedWidth:self.titleLabel_shortWidth];
        self.cellHeight = kUI_Profile_Tag_TagLabel_MarginTop + self.titleLabelHeight + kUI_Profile_Tag_TitleLabel_MarginBottom;
        if (self.titleLabelHeight < kUI_Profile_Tag_TagLabel_Height) {
            self.cellHeight = kUI_Profile_Tag_TagLabel_MarginTop + kUI_Profile_Tag_TagLabel_Height + kUI_Profile_Tag_TitleLabel_MarginBottom;
        }
    }
    
}

@end
