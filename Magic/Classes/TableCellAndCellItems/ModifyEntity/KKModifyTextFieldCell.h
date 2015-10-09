//
//  KKModifyTextFieldCell.h
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseCell.h"

@protocol KKModifyTextFieldCellDelegate <YYBaseCellActions>

- (void)kkModifyTextFieldCellBecomeFirstResponder:(NSDictionary *)userInfo;
- (void)kkModifyTextFieldCellTextChanged:(NSDictionary *)userInfo;

@end

@interface KKModifyTextFieldCell : YYBaseCell

@property (nonatomic, strong) UITextField *textField;

@end
