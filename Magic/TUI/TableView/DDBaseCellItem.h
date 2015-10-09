//
//  DDBaseCellItem.h
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDBaseItem.h"

@class DDBaseCellItem;
@class DDBaseCell;
@class DDBaseItem;

typedef void (^DDCellActionBlock)(id cellItem, id cell, NSIndexPath *indexPath, id viewController);
typedef void (^DDCellLayoutBlock)(id cell);


@interface DDBaseCellItem : DDBaseItem

/** Raw Data */
@property (nonatomic, strong) id rawObject;

/** UserInfo */
@property (nonatomic, strong) id userInfo;

/** EmptyCellItem */
@property (nonatomic, assign, getter=isOptional) BOOL optional;    //  Optional for datasource, for trim purpose

/** BgColor */
@property (nonatomic, assign) BOOL defaultWhiteBgColor; //  iOS6 issue

/** Cell UIControl */
@property (nonatomic, assign) Class cellClass;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, assign) CGFloat cellHeight;

/** TableView Cell Style */
@property (nonatomic, assign) UITableViewCellStyle cellStyle;
@property (nonatomic, assign) UITableViewCellAccessoryType cellAccessoryType;
@property (nonatomic, assign) UITableViewCellSelectionStyle cellSelectionStyle;

/**  Cell StoryBoard Supporting */
@property (nonatomic, assign, getter = isStoryBoadCell) BOOL storyBoadCell;
@property (nonatomic, assign, getter = isStaticContentCell) BOOL staticContentCell;
@property (nonatomic, assign, getter = isStaticHeightCell) BOOL staticHeightCell;

/**  Cell Rendering */
@property (nonatomic, copy) NSString *textLabelText;
@property (nonatomic, copy) NSString *detailLabelText;
@property (nonatomic, copy) NSString *imageName;

/**  Cell Action Blocks */
@property (nonatomic, assign) BOOL selectable;
@property (nonatomic, copy) DDCellActionBlock cellSelectionBlock;
@property (nonatomic, copy) DDCellActionBlock cellValuesWillSetBlock;
@property (nonatomic, copy) DDCellActionBlock cellValuesDidSetBlock;
@property (nonatomic, copy) DDCellActionBlock cellWillDisplayBlock;
@property (nonatomic, copy) DDCellLayoutBlock cellLayoutBlock;

/** Cache */
@property (nonatomic, assign) BOOL useCachedRawItem;

/** UnserInterActive */
@property (nonatomic, assign) BOOL userInteractionEnabled;


/** Methods */
- (id)initWithRawItem:(DDBaseItem *)item;
- (void)initSettings;

/** CellItem Class Methods */
+ (instancetype)cellItemWithTitle:(NSString *)title;
+ (instancetype)cellItemWithTitle:(NSString *)title detail:(NSString *)detail imageName:(NSString *)imageName;
+ (instancetype)cellItemWithRawItem:(DDBaseItem *)item;
+ (instancetype)fakeCellItem;
+ (instancetype)cellItem;
+ (instancetype)cellItemWithHeight:(CGFloat)cellHeight;
+ (instancetype)cellItemWithHeight:(CGFloat)cellHeight title:(NSString *)title;


@end
