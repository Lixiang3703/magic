//
//  DDSectionDataSource.m
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDSectionDataSource.h"
#import "DDBaseCellItem.h"

@interface DDSectionDataSource ()

@property (nonatomic, strong) NSMutableArray *sectionDataSource;

@end

@implementation DDSectionDataSource

#pragma mark -
#pragma mark Accessors
- (NSInteger)count {
    return [self.sectionDataSource count];
}

- (NSArray *)dataSource {
    return self.sectionDataSource;
}

- (CGFloat)headerHeight {
    return self.isPortrait ? self.headerHeightPortrait : self.headerHeightLandscape;
}

- (CGFloat)footerHeight {
    return self.isPortrait ? self.footerHeightPortrait : self.footerHeightLandscape;
}

#pragma mark -
#pragma mark Life cycle
- (id)initWithHeader:(NSString *)header {
    self = [super init];
    if (self) {
        self.header = header;
        self.headerHeightPortrait = 40;
        self.headerHeightLandscape = 40;
        self.footer = nil;
        self.footerHeightPortrait = 0;
        self.footerHeightLandscape = 0;
        self.sectionDataSource = [NSMutableArray array];
        self.portrait = YES;
    }
    return self;
}

-(id)init {
    return [self initWithHeader:nil];
}

+ (DDSectionDataSource *)sectionDataSourceWithoutHeader {
    DDSectionDataSource *sectionDataSource = [[DDSectionDataSource alloc] init];
    sectionDataSource.headerHeightPortrait = 0;
    sectionDataSource.headerHeightLandscape = 0;
    sectionDataSource.footerHeightPortrait = 0;
    sectionDataSource.footerHeightLandscape = 0;
    return sectionDataSource;
}

#pragma mark -
#pragma mark Operations

- (void)addCellItem:(DDBaseCellItem *)cellItem {
    if ([cellItem isKindOfClass:[DDBaseCellItem class]]) {
        [self.sectionDataSource addObject:cellItem];
    }
}

- (void)addCellItems:(NSArray *)cellItems {
    if ([cellItems isKindOfClass:[NSArray class]]) {
        [self.sectionDataSource addObjectsFromArray:cellItems];
    }
}


@end
