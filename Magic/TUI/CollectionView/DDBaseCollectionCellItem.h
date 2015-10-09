//
//  DDBaseCollectionCellItem.h
//  TongTest
//
//  Created by Tong on 29/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDBaseItem.h"

@class DDBaseCollectionCellItem;
@class DDBaseCollectionCell;
@class DDBaseItem;

typedef void (^DDCellActionBlock)(id cellItem, id cell, NSIndexPath *indexPath, id viewController);
typedef void (^DDCellLayoutBlock)(id cell);

@interface DDBaseCollectionCellItem : DDBaseItem

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
@property (nonatomic, assign) CGFloat cellWidth;


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
+ (instancetype)cellItem;



@end
