//
//  KKModifyTextViewCell.m
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKModifyTextViewCell.h"
#import "KKModifyTextViewCellItem.h"

@interface KKModifyTextViewCell()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *worldCountLabel;

@property (nonatomic, strong) UILabel *topTagLabel;

@end


@implementation KKModifyTextViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.seperatorLine.left = 0;
        self.seperatorLine.width = [UIDevice screenWidth];
        
//        self.topTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(kUI_Login_Common_MarginW, 0, self.width, kUI_Login_Common_Margin)];
//        self.topTagLabel.textAlignment = NSTextAlignmentLeft;
//        [self.contentView addSubview:self.topTagLabel];
        
        self.textView = [[YYPlaceHolderTextView alloc] initWithFrame:CGRectMake(kUI_TableView_Common_MarginLevel2, 0, [UIDevice screenWidth] - 2*kUI_TableView_Common_MarginLevel2, self.height)];
//        [self.textView setBackgroundColor:[UIColor redColor]];
        self.textView.font = [UIFont systemFontOfSize:16];
        self.textView.delegate = self;
        [self.contentView addSubview:self.textView];
        
//        self.worldCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.textView.width, self.textView.height - 20, 20, 12)];
//        [self.worldCountLabel setThemeUIType:kThemePersonSmallGrayLabel];
//        self.worldCountLabel.text = @"0";
//        [self.contentView addSubview:self.worldCountLabel];
    }
    return self;
}

- (void)setValuesWithCellItem:(KKModifyTextViewCellItem *)cellItem{
    [super setValuesWithCellItem:cellItem];
    
    self.textView.height = cellItem.cellHeight - 2*kUI_TableView_Common_Margin;
    
    self.topTagLabel.text = cellItem.tagName;
    self.textView.placeholder = cellItem.placeHolderString;
    self.textView.text = cellItem.titleName;
    
    NSInteger remainCount = kProfile_Max_Signature_Count - [[self.textView.text trim] length];
    self.worldCountLabel.text = [NSString stringWithFormat:@"%ld",(long)remainCount];
}

#pragma mark -
#pragma mark UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self.ddTableView cellActionWithCell:self control:textView userInfo:nil selector:@selector(kkModifyTextViewCellBecomeFirstResponder:)];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    [self.ddTableView cellActionWithCell:self control:textView userInfo:nil selector:@selector(kkModifyTextViewCellTextChanged:)];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if ([text isEqualToString:@"\n"]) {
//        return NO;
//    }
    return YES;
}

- (void)calculateWordCountLabel:(UITextView *)textView {
    NSInteger remainCount = 0;
    if ([[textView.text trim] length] > kProfile_Max_Signature_Count) {
        remainCount = - ([[textView.text trim] length] - kProfile_Max_Signature_Count);
        self.worldCountLabel.textColor = [UIColor redColor];
    } else {
        remainCount = kProfile_Max_Signature_Count - [[textView.text trim] length];
        self.worldCountLabel.textColor = [UIColor lightGrayColor];
    }
    self.worldCountLabel.text = [NSString stringWithFormat:@"%ld",(long)remainCount];
}

@end
