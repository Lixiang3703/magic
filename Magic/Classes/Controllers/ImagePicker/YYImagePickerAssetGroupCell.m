//
//  YYImagePickerAssetGroupCell.m
//  Wuya
//
//  Created by lixiang on 15/2/13.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "YYImagePickerAssetGroupCell.h"
#import "YYImagePickerAssetGroupCellItem.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface YYImagePickerAssetGroupCell()

@property (nonatomic, strong) ALAssetsGroup *assetsGroup;

@end

@implementation YYImagePickerAssetGroupCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Cell settings
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        // Create thumbnail view
        YYImagePickerThumbnailView *thumbnailView = [[YYImagePickerThumbnailView alloc] initWithFrame:CGRectMake(8, 4, 70, 74)];
        thumbnailView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        [self.contentView addSubview:thumbnailView];
        self.thumbnailView = thumbnailView;
        
        // Create name label
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8 + 70 + 18, 22, 180, 21)];
        nameLabel.font = [UIFont systemFontOfSize:17];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // Create count label
        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(8 + 70 + 18, 46, 180, 15)];
        countLabel.font = [UIFont systemFontOfSize:12];
        countLabel.textColor = [UIColor blackColor];
        countLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        
        [self.contentView addSubview:countLabel];
        self.countLabel = countLabel;
    }
    return self;
}

- (void)setValuesWithCellItem:(YYImagePickerAssetGroupCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    self.assetsGroup = cellItem.assetsGroup;
    
    // Update thumbnail view
    self.thumbnailView.assetsGroup = self.assetsGroup;
    
    // Update label
    self.nameLabel.text = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    self.countLabel.text = [NSString stringWithFormat:@"%ld", (long)self.assetsGroup.numberOfAssets];
}

@end
