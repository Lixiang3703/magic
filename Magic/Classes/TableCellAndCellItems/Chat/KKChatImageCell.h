//
//  KKChatImageCell.h
//  Link
//
//  Created by Lixiang on 14/12/16.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKChatCell.h"

@protocol KKChatImageCellActions <KKChatCellActions>

- (void)kkChatImageCellImagePressedWithInfo:(NSDictionary *)info;

@end

@class DDTImageView;

@interface KKChatImageCell : KKChatCell

@property (nonatomic, strong) DDTImageView *photoImageView;


@end
