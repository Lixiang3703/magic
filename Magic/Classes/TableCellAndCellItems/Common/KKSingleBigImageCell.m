//
//  KKSingleBigImageCell.m
//  Link
//
//  Created by Lixiang on 14/11/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKSingleBigImageCell.h"
#import "KKSingleBigImageCellItem.h"

@interface KKSingleBigImageCell()



@end

@implementation KKSingleBigImageCell

#pragma mark -
#pragma mark life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.avatarImageView =[[DDTImageView alloc] initWithFrame:CGRectMake(([UIDevice screenWidth] - kUI_ImageSize_Avatar_Big)/2, kUI_TableView_Common_Margin, kUI_ImageSize_Avatar_Big, kUI_ImageSize_Avatar_Big)];
        self.avatarImageView.alwaysClearBgColor = NO;
        
        self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.avatarImageView.clipsToBounds = YES;
        
        [self.contentView addSubview:self.avatarImageView];
    }
    return self;
}

- (void)setValuesWithCellItem:(KKSingleBigImageCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];

    UIImage *image = (UIImage *)cellItem.rawObject;
    if ([image isKindOfClass:[UIImage class]]) {
        self.avatarImageView.image = image;
    }
    
    KKImageItem *imageItem = (KKImageItem *)cellItem.rawObject;
    if (imageItem!= nil && [imageItem isKindOfClass:[KKImageItem class]] && imageItem.urlMiddle) {
        [self.avatarImageView loadImageWithUrl:imageItem.urlMiddle localImage:YES];
    }
    else if (cellItem.defaultImage) {
        self.avatarImageView.image = cellItem.defaultImage;
    }
}

@end
