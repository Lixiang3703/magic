//
//  DDCollectionView.m
//  TongTest
//
//  Created by Tong on 29/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDCollectionView.h"

#import "DDBaseCollectionViewController.h"
#import "DDBaseCollectionCellItem.h"
#import "DDBaseCollectionCell.h"

@interface DDCollectionView ()

@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property (nonatomic, strong) NSMutableSet *cellIdentifiers;

@end

@implementation DDCollectionView

#pragma mark -
#pragma mark Accessors
- (NSMutableSet *)cellIdentifiers {
    if (nil == _cellIdentifiers) {
        _cellIdentifiers = [NSMutableSet set];
    }
    return _cellIdentifiers;
}

#pragma mark -
#pragma mark Initialzation

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame collectionViewLayout:nil];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self initSettings];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSettings];
    }
    return self;
}

- (void)initSettings {
    
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    
    self.backgroundColor = [UIColor clearColor];
    [self fullfillPrarentView];
    

//    //  TestOnly:
//    self.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.layer.borderWidth = 2;
}


#pragma mark -
#pragma mark Initial Loading Spinner
- (void)addInitialLoadingSpinner {
    if (nil == self.spinner) {
        self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.spinner.frame = self.frame;
        self.spinner.autoresizingMask = self.autoresizingMask;
        self.spinner.userInteractionEnabled = NO;
    }
    
    if (nil == self.spinner.superview) {
        [self.superview addSubview:self.spinner];
    }
    
    [self.spinner startAnimating];
}

- (void)dismissLoadingSpinner {
    //  Dismiss Loading spinner
    [self.spinner stopAnimating];
    [self.spinner removeFromSuperview];
    self.spinner = nil;
}

#pragma mark -
#pragma mark Register
- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
    if (nil != identifier && ![self.cellIdentifiers containsObject:identifier]) {
        [self.cellIdentifiers addObject:identifier];
        
        [super registerClass:cellClass forCellWithReuseIdentifier:identifier];
    }
}

#pragma mark -
#pragma mark Reload
- (void)reloadData {
    [super reloadData];
}

- (void)reloadDataWithWillHandler:(void (^)(void))willHanlder didHandler:(void (^)(void))didHanlder {
    if (willHanlder) {
        willHanlder();
    }
    [self reloadData];
    if (didHanlder) {
        didHanlder();
    }
}


#pragma mark -
#pragma mark Scroll
- (void)scrollToFirstCellAnimated:(BOOL)animated {
    if ([self numberOfSections] != 0 && [self numberOfItemsInSection:0] != 0) {
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:animated];
    }
}

- (void)scrollToLastCellAnimated:(BOOL)animated {
    if ([self numberOfSections] != 0 && [self numberOfItemsInSection:[self numberOfSections] - 1] != 0) {
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:[self numberOfSections] - 1 inSection:[self numberOfItemsInSection:[self numberOfSections] - 1] - 1] atScrollPosition:UICollectionViewScrollPositionLeft animated:animated];
        
    }
}



#pragma mark -
#pragma mark Hit Touch



#pragma mark -
#pragma mark CellItem
- (DDBaseCollectionCellItem *)cellItemForIndexPath:(NSIndexPath *)indexPath {
    DDBaseCollectionViewController *collectionViewController = (DDBaseCollectionViewController *)self.dataSource;
    DDBaseCollectionCellItem *cellItem = [collectionViewController cellItemWithIndexPath:indexPath collectionView:collectionViewController.collectionView];
    return cellItem;
}

- (DDBaseCollectionCellItem *)cellItemWithCell:(DDBaseCollectionCell *)cell {
    return [self cellItemForIndexPath:[self indexPathForCell:cell]];
}


#pragma mark -
#pragma mark Actions
- (void)cellActionWithCell:(id)cell control:(id)sender userInfo:(id)userInfo selector:(SEL)selector {
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    DDBaseCollectionCellItem *cellItem = [self cellItemForIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:selector]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setSafeObject:cell forKey:kDDTableView_Action_Key_Cell];
        [dict setSafeObject:cellItem forKey:kDDTableView_Action_Key_CellItem];
        [dict setSafeObject:sender forKey:kDDTableView_Action_Key_Control];
        [dict setSafeObject:indexPath forKey:kDDTableView_Action_Key_IndexPath];
        [dict setSafeObject:userInfo forKey:kDDTableView_Action_Key_UserInfo];
        
        SuppressPerformSelectorLeakWarning([self.delegate performSelector:selector withObject:dict]);
    }
}


@end
