//
//  KKDoubleImageCell.m
//  Magic
//
//  Created by lixiang on 15/6/3.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKDoubleImageCell.h"
#import "KKDoubleImageCellItem.h"

const static NSInteger totalCountPerLine = 2;

@implementation KKDoubleImageCell

#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.seperatorLine.left = 0;
        
        CGFloat imageWidth = 100;
        
        self.imageArray = [NSMutableArray array];
        CGRect leftImageRect = CGRectZero;
        
        for (int i = 0; i < totalCountPerLine; i ++) {
            CGFloat imageLeft = 5 + i*(imageWidth + 5);
            DDTImageView *imageView = [[DDTImageView alloc] initWithFrame:CGRectMake(imageLeft, 0, imageWidth, imageWidth)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            
            imageView.tag = i;
            
            [self.imageArray addSafeObject:imageView];
            
            [self.contentView addSubview:imageView];
            
            if (i == 0) {
                leftImageRect = imageView.frame;
            }
        }
        
        self.addPhotoButton = [[UIButton alloc] initWithFrame:leftImageRect];
        [self.addPhotoButton setBackgroundColor:[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1]];
        [self.addPhotoButton setImage:[UIImage imageNamed:@"profile_photowall_add"] forState:UIControlStateNormal];
        [self.addPhotoButton addTarget:self action:@selector(addPhotoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:self.addPhotoButton];
        self.addPhotoButton.hidden = YES;
    }
    return self;
}

- (void)setValuesWithCellItem:(KKDoubleImageCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    CGFloat imageWidth = ([UIDevice screenWidth] - (totalCountPerLine - 1)* cellItem.separeteLine_width - cellItem.margin_left - cellItem.margin_right)/ totalCountPerLine;
    
    NSArray *rawItem = cellItem.rawObject;
    CGRect leftImageRect = CGRectZero;
    
    for (int i = 0; i < totalCountPerLine; i ++) {
        KKImageItem *imageItem = [rawItem objectAtSafeIndex:i];
        DDTImageView *imageView = [self.imageArray objectAtSafeIndex:i];
        imageView.width = imageWidth;
        imageView.height = imageWidth;
        
        if (i == 0) {
            imageView.left = cellItem.margin_left;
        }
        else {
            imageView.left = cellItem.margin_left + i*(imageWidth + cellItem.separeteLine_width);
        }
        
        if (imageItem && [imageItem isKindOfClass:[KKImageItem class]]) {
            imageView.hidden = NO;
            
            [imageView loadImageWithUrl:imageItem.urlMiddle localImage:YES];
            [imageView addTarget:self tapAction:@selector(imageViewPressed:)];
        }
        else {
            imageView.hidden = YES;
        }
        
        if (i == 0) {
            leftImageRect = imageView.frame;
        }
    }
    
    self.addPhotoButton.frame = leftImageRect;
    if (cellItem.supportAdd) {
        self.addPhotoButton.hidden = NO;
    }
    else {
        self.addPhotoButton.hidden = YES;
    }
}

- (void)showImagesWithCellItem:(KKDoubleImageCellItem *)cellItem {
    [super showImagesWithCellItem:cellItem];
    
}

#pragma mark -
#pragma mark Button KKDoubleImageCellActions

- (void)addPhotoButtonClick:(id)sender {
    [self.ddTableView cellActionWithCell:self control:sender userInfo:nil selector:@selector(kkDoubleImageCellAddButtonPressed:)];
}

- (void)imageViewPressed:(UITapGestureRecognizer*)sender {
    [self.ddTableView cellActionWithCell:self control:sender.view userInfo:nil selector:@selector(kkDoubleImageCellImageViewPressed:)];
}

@end
