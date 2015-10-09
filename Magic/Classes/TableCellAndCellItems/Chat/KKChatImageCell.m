//
//  KKChatImageCell.m
//  Link
//
//  Created by Lixiang on 14/12/16.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKChatImageCell.h"
#import "KKChatCellItem.h"
#import "DDTImageView.h"

@implementation KKChatImageCell

#pragma mark -
#pragma mark Life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.photoImageView = [[DDTImageView alloc] initWithFrame:self.pmContentView.bounds];
        [self.photoImageView fullfillPrarentView];
        [self.photoImageView addTarget:self tapAction:@selector(photoImageViewPressed:)];
        self.photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.pmContentView insertSubview:self.photoImageView atIndex:0];
    }
    return self;
}

- (void)setValuesWithCellItem:(KKChatCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    self.pmContentView.backgroundColor = [UIColor clearColor];
    
    KKChatItem *rawItem = cellItem.rawObject;
    if (![rawItem isKindOfClass:[KKChatItem class]]) {
        return;
    }
    
    if (rawItem.fake) {
        self.photoImageView.image = rawItem.fakeImage;
    } else {
        [self.photoImageView loadImageWithUrl:rawItem.imageItem.urlSmall localImage:YES];
    }
    
}

#pragma mark -
#pragma mark Images

- (void)showImagesWithCellItem:(KKChatCellItem *)cellItem {
    [super showImagesWithCellItem:cellItem];
    
    KKChatItem *rawItem = cellItem.rawObject;
    if (![rawItem isKindOfClass:[KKChatItem class]]) {
        return;
    }
    
    if (rawItem.fake) {
        self.photoImageView.image = rawItem.fakeImage;
    } else {
        [self.photoImageView loadImageWithUrl:rawItem.imageItem.urlSmall localImage:NO];
    }
    
}

#pragma mark -
#pragma mark Buttons
- (void)photoImageViewPressed:(id)sender {
    [self.ddTableView cellActionWithCell:self control:self.photoImageView userInfo:nil selector:@selector(kkChatImageCellImagePressedWithInfo:)];
}

@end
