//
//  KKCaseNewIndexCell.m
//  Magic
//
//  Created by lixiang on 15/7/4.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseNewIndexCell.h"
#import "KKCaseNewIndexCellItem.h"
#import "KKCaseIndexButton.h"

static const CGFloat margin = 0;
static const CGFloat marginLeft = kCaseNewIndexOneButton_marginLeft;
static const CGFloat marginTop = kCaseNewIndexOneButton_marginTop;

@implementation KKCaseNewIndexCell

#pragma mark -
#pragma mark Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.seperatorLine.left = 0;
        self.seperatorLine.width = [UIDevice screenWidth];
        
        CGFloat buttonWidth = ([UIDevice screenWidth] - 2*kCaseNewIndexOneButton_marginLeft)/3;
        CGFloat buttonHeight = buttonWidth * kCaseNewIndexOneButton_heightRatio;
        
        KKCaseIndexButton *buttonView = nil;
        for (int tag = KKCaseIndexTagTypeTrademarkSearch; tag < KKCaseIndexTagTypeCount; tag ++) {
            CGRect frame = CGRectMake(marginLeft, marginTop, buttonWidth, buttonHeight);
            NSString *title = @"";
            UIColor *bgColor = [UIColor clearColor];
            
            switch (tag) {
                case KKCaseIndexTagTypeTrademarkSearch:
                {
                    title = @"商标查询";
                }
                    break;
                case KKCaseIndexTagTypeInsert:
                {
                    frame.origin.x = marginLeft + margin + buttonWidth;
                    title = @"业务办理";
                }
                    break;
                case KKCaseIndexTagTypeCompanySearch:
                {
                    title = @"企业查询";
                    frame.origin.x = marginLeft + 2*(margin + buttonWidth);
                }
                    break;
                case KKCaseIndexTagTypeInfo:
                {
                    frame.origin.y = marginTop + margin + buttonHeight;
                    title = @"中理通简介";
                }
                    break;
                case KKCaseIndexTagTypeNews:
                {
                    frame.origin.x = marginLeft + (margin + buttonWidth);
                    frame.origin.y = marginTop + margin + buttonHeight;
                    title = @"新闻动态";
                }
                    break;
                case KKCaseIndexTagTypeLaw:
                {
                    frame.origin.x = marginLeft + 2*(margin + buttonWidth);
                    frame.origin.y = marginTop + margin + buttonHeight;
                    title = @"法律法规";
                }
                    break;
                default:
                    break;
            }
            
            buttonView = [[KKCaseIndexButton alloc] initWithFrame:frame];
            buttonView.backgroundColor = bgColor;
            
            buttonView.iconImageView.image = [self iconImageForTag:tag];
            buttonView.button.tag = tag;
            buttonView.titleLabel.text = title;
            
            if (tag == KKCaseIndexTagTypeTrademarkSearch) {
                CGFloat imageView_width = frame.size.height * 6.5/11;
                CGFloat imageView_marginTop = frame.size.height * 1/7;
                
                buttonView.iconImageView.frame = CGRectMake((frame.size.width - imageView_width)/2, imageView_marginTop, imageView_width, imageView_width);
            }
            
            [buttonView.button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.contentView addSubview:buttonView];
        }
        
        CGFloat buttonPaddingLeft = 20;
        
        UIView *middleLineView = [[UIView alloc] initWithFrame:CGRectMake(marginLeft + buttonPaddingLeft, marginTop + buttonHeight, [UIDevice screenWidth] - 2*marginLeft - 2*buttonPaddingLeft, 1)];
        middleLineView.backgroundColor = [UIColor YYLineColor];
        
        UIView *leftLineView = [[UIView alloc] initWithFrame:CGRectMake(marginLeft + margin + buttonWidth, marginTop, 1, 2*buttonHeight)];
        UIView *rightLineView = [[UIView alloc] initWithFrame:CGRectMake(marginLeft + 2*(margin + buttonWidth), marginTop, 1, 2*buttonHeight)];
        
        leftLineView.backgroundColor = [UIColor YYLineColor];
        rightLineView.backgroundColor = [UIColor YYLineColor];
        
        [self.contentView addSubview:middleLineView];
        [self.contentView addSubview:leftLineView];
        [self.contentView addSubview:rightLineView];
        
    }
    return self;
}

#pragma mark -
#pragma mark Actions

- (void)buttonPressed:(id)sender {
    [self.ddTableView cellActionWithCell:self control:sender userInfo:nil selector:@selector(kkCaseNewIndexButtonPressed:)];
}

- (UIImage *)iconImageForTag:(KKCaseIndexTagType)tag {
    switch (tag) {
        case KKCaseIndexTagTypeInsert:
            return [UIImage imageNamed:@"icon_white_big_case"];
            break;
        case KKCaseIndexTagTypeNews:
            return [UIImage imageNamed:@"icon_white_big_news"];
            break;
        case KKCaseIndexTagTypeLaw:
            return [UIImage imageNamed:@"icon_white_big_law"];
            break;
        case KKCaseIndexTagTypeInfo:
            return [UIImage imageNamed:@"icon_white_big_book"];
            break;
        case KKCaseIndexTagTypeCompanySearch:
            return [UIImage imageNamed:@"icon_white_big_search"];
            break;
        case KKCaseIndexTagTypeTrademarkSearch:
            return [UIImage imageNamed:@"icon_white_big_logo"];
            break;
        default:
            break;
    }
    return [UIImage imageNamed:@"icon_white_more"];
}
@end
