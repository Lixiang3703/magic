//
//  KKCaseClassicsCell.m
//  Magic
//
//  Created by lixiang on 15/4/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseClassicsCell.h"
#import "KKOneClassicsView.h"
#import "KKCaseClassicsCellItem.h"
#import "KKClassicsItem.h"

static const int maxItemCount = 8;

@interface KKCaseClassicsCell()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *itemViewArray;

@end

@implementation KKCaseClassicsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.seperatorLine.left = 0;
        self.seperatorLine.width = [UIDevice screenWidth];
        
        self.itemViewArray = [NSMutableArray array];
        
        CGFloat scrollView_height = kCaseClassicsCell_ImageView_marginTop + kCaseClassicsCell_ImageView_height + kCaseClassicsCell_ImageView_marginTop + kCaseClassicsCell_Label_height + kCaseClassicsCell_ImageView_marginTop;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIDevice screenWidth] - 30, scrollView_height)];
        
        [self preLoadItemViews:maxItemCount];
        
        [self.contentView addSubview:self.scrollView];
    }
    return self;
}

- (void)preLoadItemViews:(NSInteger)count {
    CGFloat itemView_width = 2*kCaseClassicsCell_ImageView_marginLeft + kCaseClassicsCell_ImageView_height;
    CGFloat itemView_height = self.scrollView.height;
    
    for (int i =0; i < count; i ++) {
        KKOneClassicsView *oneClassicsView = [[KKOneClassicsView alloc] initWithFrame:CGRectMake(i*itemView_width, 0, itemView_width, itemView_height)];
        [self.scrollView addSubview:oneClassicsView];
        [self.itemViewArray addSafeObject:oneClassicsView];
    }
    self.scrollView.contentSize = CGSizeMake(count * itemView_width, self.scrollView.height);
    
}


- (void)setValuesWithCellItem:(KKCaseClassicsCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    CGFloat itemView_width = 2*kCaseClassicsCell_ImageView_marginLeft + kCaseClassicsCell_ImageView_height;
    
    for (KKOneClassicsView *oneView in self.itemViewArray) {
        oneView.hidden = YES;
    }
    
//    for (int i = 0; i < maxItemCount; i ++) {
//        KKOneClassicsView *oneView = [self.itemViewArray objectAtSafeIndex:i];
//        if (oneView) {
//            oneView.hidden = NO;
//            [oneView injectDataWithImageUrl:@"http://d.hiphotos.baidu.com/baike/w%3D268/sign=59af280fca95d143da76e3254bf08296/f9198618367adab451e5df4f89d4b31c8701e481.jpg" local:YES title:@"王老吉"];
//        }
//        
//    }
//    self.scrollView.contentSize = CGSizeMake(maxItemCount * itemView_width, self.scrollView.height);
    
    NSArray *classicsItemArray = cellItem.rawObject;
    if ( classicsItemArray== nil || ![classicsItemArray isKindOfClass:[NSArray class]]) {
        return;
    }
    for (int i = 0; i < classicsItemArray.count; i ++) {
        if (i >= maxItemCount) {
            break;
        }
        KKClassicsItem *classicsItem = [classicsItemArray objectAtSafeIndex:i];
        KKOneClassicsView *oneView = [self.itemViewArray objectAtSafeIndex:i];
        if (!oneView) {
            continue;
        }
        oneView.hidden = NO;
        if (classicsItem && [classicsItem isKindOfClass:[KKClassicsItem class]]) {
            [oneView injectDataWithImageUrl:classicsItem.imageItem.urlSmall local:YES title:classicsItem.name];
        }
    }
    self.scrollView.contentSize = CGSizeMake(classicsItemArray.count * itemView_width, self.scrollView.height);
}

- (void)showImagesWithCellItem:(KKCaseClassicsCellItem *)cellItem {
    [super showImagesWithCellItem:cellItem];
    
    for (KKOneClassicsView *oneView in self.itemViewArray) {
        oneView.hidden = YES;
    }
    
    NSArray *classicsItemArray = cellItem.rawObject;
    if ( classicsItemArray== nil || ![classicsItemArray isKindOfClass:[NSArray class]]) {
        return;
    }
    for (int i = 0; i < classicsItemArray.count; i ++) {
        if (i >= maxItemCount) {
            break;
        }
        KKClassicsItem *classicsItem = [classicsItemArray objectAtSafeIndex:i];
        KKOneClassicsView *oneView = [self.itemViewArray objectAtSafeIndex:i];
        if (!oneView) {
            continue;
        }
        oneView.hidden = NO;
        if (classicsItem && [classicsItem isKindOfClass:[KKClassicsItem class]]) {
            [oneView injectDataWithImageUrl:classicsItem.imageItem.urlSmall local:NO title:classicsItem.name];
        }
    }
}

@end
