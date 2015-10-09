//
//  KKModifyTextViewCell.h
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseCell.h"
#import "YYPlaceHolderTextView.h"

@protocol KKModifyTextViewCellDelegate <YYBaseCellActions>

- (void)kkModifyTextViewCellBecomeFirstResponder:(NSDictionary *)userInfo;

@optional
- (void)kkModifyTextViewCellTextChanged:(NSDictionary *)userInfo;

@end

@interface KKModifyTextViewCell : YYBaseCell

@property (nonatomic,strong) YYPlaceHolderTextView *textView;

@end
