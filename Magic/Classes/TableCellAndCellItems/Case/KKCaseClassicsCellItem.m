//
//  KKCaseClassicsCellItem.m
//  Magic
//
//  Created by lixiang on 15/4/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseClassicsCellItem.h"

@implementation KKCaseClassicsCellItem

- (void)initSettings {
    [super initSettings];
    self.cellHeight = kCaseClassicsCell_ImageView_marginTop + kCaseClassicsCell_ImageView_height + kCaseClassicsCell_ImageView_marginTop + kCaseClassicsCell_Label_height + kCaseClassicsCell_ImageView_marginTop;
    
    self.cellAccessoryType = UITableViewCellAccessoryNone;
}

@end
