//
//  KKProfileIntroCell.h
//  Link
//
//  Created by Lixiang on 14/10/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseCell.h"
#import "DDTImageView.h"

@protocol KKProfileIntroCellActions <DDBaseCellActions>

@required
- (void)kkProfileAvaterButtonPressed:(NSDictionary *)info;
- (void)kkProfileBgImagePressed:(NSDictionary *)info;
@end

@interface KKProfileIntroCell : YYBaseCell

@property (nonatomic, strong) DDTImageView *avatarImageView;

@end
