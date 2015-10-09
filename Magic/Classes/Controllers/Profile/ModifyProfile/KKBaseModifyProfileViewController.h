//
//  KKBaseModifyProfileViewController.h
//  Magic
//
//  Created by lixiang on 15/5/9.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKModifyBaseViewController.h"
#import "KKPersonItem.h"
#import "KKUserUpdateBasicInfoRequestModel.h"

#import "KKModifyTextFieldCell.h"
#import "KKModifyTextFieldCellItem.h"

@interface KKBaseModifyProfileViewController : KKModifyBaseViewController

@property (nonatomic, strong) KKPersonItem *personItem;
@property (nonatomic, strong) KKPersonItem *modifyPersonItem;

@end
