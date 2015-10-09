//
//  KKModifyTextFieldCell.m
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKModifyTextFieldCell.h"
#import "KKModifyTextFieldCellItem.h"

@interface KKModifyTextFieldCell()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *tagNameLabel;

@end

@implementation KKModifyTextFieldCell

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.seperatorLine.left = 0;
        self.seperatorLine.width = [UIDevice screenWidth];
        
        // tagName
        self.tagNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kUI_Login_Common_MarginW, 12, kUI_PMSession_Date_Width, kUI_Login_Common_Margin)];
        self.tagNameLabel.textAlignment = NSTextAlignmentLeft;
        self.tagNameLabel.textColor = [UIColor lightGrayColor];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(kUI_Login_Common_MarginW, 0, [UIDevice screenWidth] - 2*kUI_Login_Common_MarginW, self.height)];
        self.textField.delegate = self;
        self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        [self.contentView addSubview:self.tagNameLabel];
        [self.contentView addSubview:self.textField];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)setValuesWithCellItem:(KKModifyTextFieldCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    self.textField.placeholder = cellItem.placeHolderString;
    self.textField.text = cellItem.titleName;
    
    self.textField.left = kUI_Login_Common_MarginW;
    self.textField.width = [UIDevice screenWidth] - 2*kUI_Login_Common_MarginW;
    
    if ([[cellItem.tagName trim] length]) {
        self.tagNameLabel.text = cellItem.tagName;
        self.textField.left = self.tagNameLabel.right + kUI_Login_Common_MarginS;
        self.textField.width = [UIDevice screenWidth] - self.textField.left - kUI_Login_Common_MarginW;
    }
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self.ddTableView cellActionWithCell:self control:textField userInfo:nil selector:@selector(kkModifyTextFieldCellBecomeFirstResponder:)];
    return YES;
}

- (void)textFieldTextDidChangeNotification:(NSNotification *)notification {
    UITextField *textField = notification.object;
    [self.ddTableView cellActionWithCell:self control:textField userInfo:nil selector:@selector(kkModifyTextFieldCellTextChanged:)];
}
@end
