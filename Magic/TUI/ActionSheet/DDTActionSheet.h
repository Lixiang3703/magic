//
//  DDTActionSheet.h
//  iPhone
//
//  Created by Cui Tong on 15/03/2012.
//  Copyright (c) 2012 diandian.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDTActionSheetItem.h"

@class DDTActionSheet;

@protocol DDTActionSheetDelegate <NSObject>

- (void)actionSheet:(DDTActionSheet *)caller willPerformSelector:(SEL)selector withUserInfo:(id)userInfo;

@end

@interface DDTActionSheet : UIActionSheet {
    __weak id <DDTActionSheetDelegate> _lbDelegate;
    NSArray *_actionSheetItems;
}

@property (nonatomic, weak) id lbDelegate;
@property (nonatomic, strong) NSArray *actionSheetItems;

- (id)initWithTitle:(NSString *)title ActionSheetItems:(NSArray *)actionSheetItems;

@end
