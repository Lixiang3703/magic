//
//  KKMultiImageCell.m
//  Magic
//
//  Created by lixiang on 15/4/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKMultiImageCell.h"
#import "DDPageControl.h"
#import "DDTImageView.h"
#import "KKMultiImageCellItem.h"
#import "KKImageItem.h"

@interface KKMultiImageCell()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DDPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *imageViewArray;

@end

@implementation KKMultiImageCell

#pragma mark -
#pragma mark Accessor

- (NSMutableArray *)imageViewArray {
    if (_imageViewArray == nil) {
        _imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIDevice screenWidth], kMultiImageCell_Relative_Height * [UIDevice screenWidth] / 320)];
        self.scrollView.backgroundColor = [UIColor clearColor];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.autoresizesSubviews = YES;
        self.scrollView.scrollsToTop = NO;
        self.scrollView.delegate = self;
        
        CGFloat imageView_width = [UIDevice screenWidth];
        
        DDTImageView *oneImageView = nil;
        for (int i = 0; i < 4; i ++) {
            oneImageView = [[DDTImageView alloc] initWithFrame:CGRectMake(i*imageView_width, 0, imageView_width, self.scrollView.height)];
            oneImageView.contentMode = UIViewContentModeScaleAspectFill;
            oneImageView.tag = i;
            [oneImageView addTarget:self tapAction:@selector(imagePressed:)];
            [self.scrollView addSubview:oneImageView];
            [self.imageViewArray addSafeObject:oneImageView];
        }
        
        self.scrollView.contentSize = CGSizeMake(self.scrollView.width * 4, self.scrollView.height);
        
        //  PageControl
        self.pageControl = [[DDPageControl alloc] initWithFrame:CGRectMake(0, self.scrollView.height - 20, self.scrollView.width, 10) type:DDPageControlTypeBlack];
        self.pageControl.pageIndicatorImage = [UIImage imageNamed:@"kb_control_pot_light"];
        self.pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"kb_control_pot_dark"];
        self.pageControl.numberOfPages = 4;
//        self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        [self.contentView addSubview:self.scrollView];
        [self.contentView addSubview:self.pageControl];
    }
    return self;
}

- (void)setValuesWithCellItem:(KKMultiImageCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
//    for (DDTImageView *oneImageView in self.imageViewArray) {
//        oneImageView.hidden = YES;
//        [oneImageView loadImageWithUrl:@"http://b.hiphotos.baidu.com/image/pic/item/3bf33a87e950352aaf91e4815143fbf2b3118b43.jpg" localImage:YES];
//    }
    
    if (cellItem.imageItemArray.count > 0) {
        int i = 0;
        for (KKImageItem *imageItem in cellItem.imageItemArray) {
            if ([imageItem isKindOfClass:[KKImageItem class]]) {
                DDTImageView *oneImageView = [self.imageViewArray objectAtSafeIndex:i];
                if (oneImageView) {
                    [oneImageView loadImageWithUrl:imageItem.urlOrigin localImage:YES];
                    oneImageView.hidden = NO;
                }
            }
            i ++;
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * cellItem.imageItemArray.count, self.scrollView.height);
    self.pageControl.numberOfPages = cellItem.imageItemArray.count;
    
}

- (void)showImagesWithCellItem:(KKMultiImageCellItem *)cellItem {
    [super showImagesWithCellItem:cellItem];
    
//    for (DDTImageView *oneImageView in self.imageViewArray) {
//        oneImageView.hidden = YES;
//        [oneImageView loadImageWithUrl:@"http://b.hiphotos.baidu.com/image/pic/item/3bf33a87e950352aaf91e4815143fbf2b3118b43.jpg" localImage:NO];
//    }
    
    if (cellItem.imageItemArray.count > 0) {
        int i = 0;
        for (KKImageItem *imageItem in cellItem.imageItemArray) {
            if ([imageItem isKindOfClass:[KKImageItem class]]) {
                DDTImageView *oneImageView = [self.imageViewArray objectAtSafeIndex:i];
                if (oneImageView) {
                    [oneImageView loadImageWithUrl:imageItem.urlOrigin localImage:NO];
                    oneImageView.hidden = NO;
                }
            }
            i ++;
        }
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = (scrollView.contentOffset.x + [UIDevice screenWidth]/2) / [UIDevice screenWidth];
    self.pageControl.currentPage = currentPage;
}

#pragma mark -
#pragma mark Actions

- (void)imagePressed:(UITapGestureRecognizer *)gesture {
    DDTImageView *imageView = (DDTImageView *)gesture.view;
    if (![imageView isKindOfClass:[DDTImageView class]]) {
        return;
    }
    
    [self.ddTableView cellActionWithCell:self control:imageView userInfo:nil selector:@selector(kkMultiImagePressed:)];
}

@end




