//
//  KKPrePayRequestModel.h
//  Magic
//
//  Created by lixiang on 15/6/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKBasePrePayRequestModel.h"

@interface KKPrePayRequestModel : KKBasePrePayRequestModel

@property (nonatomic, assign) NSInteger caseId;
@property (nonatomic, assign) KKPayType type;

@end
