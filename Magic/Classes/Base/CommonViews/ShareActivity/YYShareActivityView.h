//
//  YYShareActivityView.h
//  YYActionView
//
//  Created by lilingang on 14-7-15.
//  Copyright (c) 2014年 lilingang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYActivityViewItem.h"

@interface YYShareActivityView : UIView
+ (YYShareActivityView *)baseShareWithTitle:(NSString *)title desc:(NSString *)desc url:(NSString *)url thumbImage:(UIImage *)thumbImage image:(UIImage *)image;

+ (YYShareActivityView *)defaultShareWithLink:(NSString *)link
                                  contactName:(NSString *)contactName
                                   statPrefix:(NSString *)statPrefix
                                        image:(UIImage *)image;

+ (YYShareActivityView *)defaultInviteWithStatPrefix:(NSString *)statPrefix ;

//use default value
- (instancetype)initWithShareItems:(NSArray *)shareItems
                         titleName:(NSString *)titlName
                        statPrefix:(NSString *)statPrefix;

- (instancetype)initWithShareItems:(NSArray *)shareItems
                         titleName:(NSString *)titlName
                  horizontalMargin:(NSInteger)horizontalMargin
                    verticalMargin:(NSInteger)verticalMargin
                        itemHeight:(NSInteger)itemHeight
                       countPerRow:(NSInteger)countPerRow
                        rowPerPage:(NSInteger)rowPerPage
                        statPrefix:(NSString *)statPrefix;

- (instancetype)initWithShareItems:(NSArray *)shareItems
                         titleName:(NSString *)titlName
                  horizontalMargin:(NSInteger)horizontalMargin
                 horizontalSpacing:(NSInteger)horizontalSpacing
                    verticalMargin:(NSInteger)verticalMargin
                   verticalSpacing:(NSInteger)verticalSpacing
                        itemHeight:(NSInteger)itemHeight
                       countPerRow:(NSInteger)countPerRow
                        rowPerPage:(NSInteger)rowPerPage
                        statPrefix:(NSString *)statPrefix;


//should use navagationController·s view
- (void)showInView:(UIView *)view;

@end
