//
//  KKModifyTextViewCellItem.m
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKModifyTextViewCellItem.h"

@implementation KKModifyTextViewCellItem

- (void)initSettings{
    [super initSettings];
    self.cellSelectionStyle = UITableViewCellSelectionStyleNone;
    self.cellHeight = 120;

}

- (void)setRawObject:(id)rawObject {
    [super setRawObject:rawObject];
    
    if (self.textViewHeight > 0) {
        self.cellHeight = self.textViewHeight;
    }
    
}

@end
