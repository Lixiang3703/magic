//
//  KKDynamicViewController.m
//  Magic
//
//  Created by lixiang on 15/5/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKDynamicDetailViewController.h"
#import "KKDynamicCellItem.h"
#import "KKShowTagCellItem.h"
#import "YYGroupHeaderCellItem.h"
#import "KKDynamicItem.h"

#import "KKNewsItem.h"
#import "KKLawItem.h"

@interface KKDynamicDetailViewController ()

@property (nonatomic, strong) KKDynamicCellItem *titleCellItem;
@property (nonatomic, strong) KKShowTagCellItem *contentCellItem;

@property (nonatomic, strong) KKDynamicItem *dynamicItem;

@end

@implementation KKDynamicDetailViewController

#pragma mark -
#pragma mark Accessor

- (KKDynamicCellItem *)titleCellItem {
    if (_titleCellItem == nil) {
        _titleCellItem = [[KKDynamicCellItem alloc] init];
        _titleCellItem.selectable = NO;
    }
    return _titleCellItem;
}

- (KKShowTagCellItem *)contentCellItem {
    if (_contentCellItem == nil) {
        _contentCellItem = [[KKShowTagCellItem alloc] init];
        _contentCellItem.cellLayoutType = KKShowTagCellLayoutTypeFloatTop;
        _contentCellItem.selectable = NO;
    }
    return _contentCellItem;
}


#pragma mark -
#pragma mark Life cycle

- (void)initSettings {
    [super initSettings];
    
    self.tableSpinnerHidden = YES;
}

- (instancetype)initWithDynamicItem:(KKDynamicItem *)item {
    self = [self init];
    if (self) {
        self.dynamicItem = item;
        if ([item isKindOfClass:[KKLawItem class]]) {
            self.titleCellItem.singleLine = YES;
        }
        else{
            self.titleCellItem.singleLine = NO;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.hasRefreshControl = NO;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}


#pragma mark -
#pragma mark Navigation Bar
- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    [self setNaviTitle:_(@"新闻")];
    
    if ([self.dynamicItem isKindOfClass:[KKLawItem class]]) {
        [self setNaviTitle:@"法律法规"];
    }
}

#pragma mark -
#pragma mark DataSrouce
- (void)generateDataSource {
    [super generateDataSource];
    
    [self reloadHeaderDataSource];
}

- (void)reloadHeaderDataSource {
    [self.dataSource clear];
    
    self.titleCellItem.rawObject = self.dynamicItem;
    
    KKShowTagItem *showTagItem = [[KKShowTagItem alloc] init];
    showTagItem.tagName = @"";
    showTagItem.titleName = self.dynamicItem.content;
    
    showTagItem.cellLayoutType = KKShowTagCellLayoutTypeFloatTop;
    
    [self.contentCellItem updateCellItemWithTagItem:showTagItem];
    
    
    NSMutableArray *defaultCellItems = [NSMutableArray array];
    
    [defaultCellItems addSafeObject:self.titleCellItem];
    
    [defaultCellItems addSafeObject:[YYGroupHeaderCellItem cellItemWithHeight:5 title:nil]];
    
    [defaultCellItems addSafeObject:self.contentCellItem];
    
    [self.dataSource addCellItems:defaultCellItems];
}

@end






