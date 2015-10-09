//
//  KKCaseIndexCell.m
//  Magic
//
//  Created by lixiang on 15/5/17.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseIndexCell.h"
#import "KKCaseIndexCellItem.h"
#import "KKCaseIndexButton.h"

static const CGFloat margin = kCaseIndexOneButton_margin;
static const CGFloat marginLeft = kCaseIndexOneButton_marginLeft;
static const CGFloat marginTop = kCaseIndexOneButton_marginTop;

@interface KKCaseIndexCell()

@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation KKCaseIndexCell

#pragma mark -
#pragma mark Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.seperatorLine.left = 0;
        self.seperatorLine.width = [UIDevice screenWidth];
        
        CGFloat buttonWidth = ([UIDevice screenWidth] - margin - 2*marginLeft)/2;
        CGFloat buttonHeight = buttonWidth * 0.618;
        
        KKCaseIndexButton *buttonView = nil;
        for (int tag = KKCaseIndexTagTypeTrademarkSearch; tag < KKCaseIndexTagTypeCount; tag ++) {
            CGRect frame = CGRectMake(marginLeft, marginTop, buttonWidth, buttonHeight);
            NSString *title = @"";
            UIColor *bgColor = [UIColor KKButtonColor];
            
            switch (tag) {
                case KKCaseIndexTagTypeTrademarkSearch:
                {
                    title = @"商标查询";
                    bgColor = [UIColor colorWithRed:0.55 green:0.77 blue:0.22 alpha:1];
                }
                    break;
                case KKCaseIndexTagTypeInsert:
                {
                    frame.origin.x = marginLeft + margin + buttonWidth;
                    title = @"业务办理";
                    bgColor = [UIColor colorWithRed:0.91 green:0.59 blue:0.25 alpha:1];
                }
                    break;
                case KKCaseIndexTagTypeCompanySearch:
                {
                    title = @"企业查询";
                    frame.origin.y = marginTop + margin + buttonHeight;
                    bgColor = [UIColor colorWithRed:0.42 green:0.48 blue:0.65 alpha:1];
                }
                    break;
                case KKCaseIndexTagTypeInfo:
                {
                    frame.origin.y = marginTop + margin + buttonHeight;
                    frame.origin.x = marginLeft + margin + buttonWidth;
                    title = @"中理通简介";
                    bgColor = [UIColor colorWithRed:0.57 green:0.57 blue:0.57 alpha:1];
                }
                    break;
                case KKCaseIndexTagTypeNews:
                {
                    frame.origin.y = marginTop + buttonHeight +margin+ buttonHeight +margin;
                    title = @"新闻动态";
                    bgColor = [UIColor colorWithRed:0.95 green:0.45 blue:0.42 alpha:1];
                }
                    break;
                case KKCaseIndexTagTypeLaw:
                {
                    frame.origin.x = marginLeft + margin + buttonWidth;
                    frame.origin.y = marginTop + buttonHeight +margin+ buttonHeight +margin;
                    title = @"法律法规";
                    bgColor = [UIColor colorWithRed:0.17 green:0.58 blue:0.69 alpha:1];
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
        
        
        
    }
    return self;
}

- (void)setValuesWithCellItem:(DDBaseCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
}

- (void)showImagesWithCellItem:(id)cellItem {
    [super showImagesWithCellItem:cellItem];
    
}

#pragma mark -
#pragma mark Actions

- (void)buttonPressed:(id)sender {
    [self.ddTableView cellActionWithCell:self control:sender userInfo:nil selector:@selector(kkCaseIndexButtonPressed:)];
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
