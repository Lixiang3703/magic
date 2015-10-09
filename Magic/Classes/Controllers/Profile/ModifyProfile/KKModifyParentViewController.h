//
//  KKModifyParentViewController.h
//  Magic
//
//  Created by lixiang on 15/4/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKModifyBaseViewController.h"
#import "KKPersonItem.h"

@interface KKModifyParentViewController : KKModifyBaseViewController

@property (nonatomic, strong) KKPersonItem *personItem;
@property (nonatomic, strong) KKPersonItem *modifyPersonItem;

@end
