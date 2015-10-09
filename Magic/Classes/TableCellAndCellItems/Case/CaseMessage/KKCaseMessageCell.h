//
//  KKCaseMessageCell.h
//  Magic
//
//  Created by lixiang on 15/4/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseCell.h"
#import "DDTImageView.h"

@protocol KKCaseMessageCellActions <DDBaseCellActions>

@required
- (void)kkCaseMessageImageButtonPressed:(NSDictionary *)info;

@end

@interface KKCaseMessageCell : YYBaseCell

@property (nonatomic, strong) DDTImageView *photoImageView;

@end
