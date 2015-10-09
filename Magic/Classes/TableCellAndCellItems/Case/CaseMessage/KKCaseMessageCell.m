//
//  KKCaseMessageCell.m
//  Magic
//
//  Created by lixiang on 15/4/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseMessageCell.h"
#import "KKCaseMessageCellItem.h"
#import "KKCaseMessageItem.h"

@interface KKCaseMessageCell()

@property (nonatomic, strong) UIView *topContentView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *imageButton;

@end

@implementation KKCaseMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.seperatorLine.left = 0;
        self.seperatorLine.width = [UIDevice screenWidth];
        
        CGFloat myImageView_width = kCaseMessageCell_ImageView_height;
        
        CGFloat topContentView_width = [UIDevice screenWidth] - myImageView_width - 30;
        
        self.topContentView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, topContentView_width, kCaseMessageCell_ContentView_height)];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, topContentView_width, 20)];
        [self.dateLabel setThemeUIType:kThemeBasicLabel_MiddleGray14];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, topContentView_width, 20)];
        [self.contentLabel setThemeUIType:kThemeBasicLabel_Black16];
        
        [self.topContentView addSubview:self.dateLabel];
        [self.topContentView addSubview:self.contentLabel];
        
        CGFloat myImageView_Left = [UIDevice screenWidth] - myImageView_width - 10;
        
        self.photoImageView = [[DDTImageView alloc] initWithFrame:CGRectMake(myImageView_Left, kCaseMessageCell_ImageView_marginTop, myImageView_width, myImageView_width)];
        self.imageButton = [[UIButton alloc] initWithFrame:self.photoImageView.frame];
        self.imageButton.backgroundColor = [UIColor clearColor];
        [self.imageButton addTarget:self action:@selector(imageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:self.topContentView];
        [self.contentView addSubview:self.photoImageView];
        [self.contentView addSubview:self.imageButton];
        
    }
    return self;
}

- (void)setValuesWithCellItem:(KKCaseMessageCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    self.dateLabel.text = @"刚刚";
    self.contentLabel.text = @"客服人员给你发了一张图片";
    
    [self.photoImageView loadImageWithUrl:@"http://e.hiphotos.baidu.com/image/w%3D2048/sign=ef84a046c88065387beaa313a3e5a044/77c6a7efce1b9d16816dbf69f1deb48f8c54640b.jpg" localImage:YES];
    
    KKCaseMessageItem *messageItem = cellItem.rawObject;
    if (![messageItem isKindOfClass:[KKCaseMessageItem class]]) {
        return;
    }
    
    self.contentLabel.text = messageItem.content;
    self.dateLabel.text = [[NSDate dateWithTimeStamp:messageItem.insertTimestamp] stringForPMSessionDate];
    
    if (messageItem.imageItemArray && messageItem.imageItemArray.count > 0) {
        self.photoImageView.hidden = NO;
        KKImageItem *imageItem = [messageItem.imageItemArray objectAtSafeIndex:0];
        if (imageItem && [imageItem isKindOfClass:[KKImageItem class]]) {
            [self.photoImageView loadImageWithUrl:imageItem.urlSmall localImage:YES];
        }
    }
    else {
        self.photoImageView.hidden = YES;
    }
}

- (void)showImagesWithCellItem:(KKCaseMessageCellItem *)cellItem {
    [super showImagesWithCellItem:cellItem];
    
    KKCaseMessageItem *messageItem = cellItem.rawObject;
    if (![messageItem isKindOfClass:[KKCaseMessageItem class]]) {
        return;
    }
    
    if (messageItem.imageItemArray && messageItem.imageItemArray.count > 0) {
        self.photoImageView.hidden = NO;
        KKImageItem *imageItem = [messageItem.imageItemArray objectAtSafeIndex:0];
        if (imageItem && [imageItem isKindOfClass:[KKImageItem class]]) {
            [self.photoImageView loadImageWithUrl:imageItem.urlSmall localImage:NO];
        }
    }
    else {
        self.photoImageView.hidden = YES;
    }
}

#pragma mark -
#pragma mark Actions

- (void)imageButtonClicked:(id)sender {
    [self.ddTableView cellActionWithCell:self control:sender userInfo:nil selector:@selector(kkCaseMessageImageButtonPressed:)];
}

@end



