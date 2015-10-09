//
//  KKTagGroupHeaderCellItem.h
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseCellItem.h"

@interface KKTagGroupHeaderCellItem : YYBaseCellItem

@property (nonatomic, strong) NSString *tagName;
@property (nonatomic, strong) NSString *buttonName;

- (instancetype)initWithTagName:(NSString *)tagName buttonName:(NSString *)buttonName;

@end
