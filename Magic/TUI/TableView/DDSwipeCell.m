//
//  DDSwipeCell.m
//  Wuya
//
//  Created by Tong on 16/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDSwipeCell.h"
#import "DDSwipeCellItem.h"

@interface DDSwipeCell ()

@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGesture;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGesture;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation DDSwipeCell

#pragma mark -
#pragma mark Accessors
- (BOOL)isCurrentOperationOpen {
    return self.contentView.left < 0;
}

#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.width = [UIDevice screenWidth];
        
        //  UI Settings
        self.operationContainerView = [[UIView alloc] initWithFrame:CGRectMake(self.contentView.width, 0, 50, self.height)];
        self.operationContainerView.backgroundColor = [UIColor clearColor];
        [self.operationContainerView fullfillPrarentView];
        self.operationContainerView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
//        self.operationContainerView.left = [UIDevice screenWidth];
        
        [self.contentView.superview insertSubview:self.operationContainerView belowSubview:self.contentView];
        
    }
    return self;
}

- (void)setValuesWithCellItem:(DDSwipeCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    self.contentView.left = 0;
    self.operationContainerView.left = self.contentView.right;
    
//    self.operationContainerView.left = [UIDevice screenWidth];
    
    [self.contentView removeGestureRecognizer:self.rightSwipeGesture];
    [self.contentView removeGestureRecognizer:self.leftSwipeGesture];
    [self.contentView removeGestureRecognizer:self.tapGestureRecognizer];
    
    
    if (cellItem.swipable) {
        [self.contentView addGestureRecognizer:self.rightSwipeGesture];
        [self.contentView addGestureRecognizer:self.leftSwipeGesture];
        
        if (self.isCurrentOperationOpen) {
            [self.contentView addGestureRecognizer:self.tapGestureRecognizer];
        }
        self.operationContainerView.hidden = NO;
    } else {
        self.operationContainerView.hidden = YES;
    }
    
}

- (void)firstAssignValuesSettingsWithCellItem:(DDSwipeCellItem *)cellItem {
    [super firstAssignValuesSettingsWithCellItem:cellItem];
    
    self.rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeGesture:)];
    self.rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    self.rightSwipeGesture.delegate = self;
    
    self.leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeGesture:)];
    self.leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    self.leftSwipeGesture.delegate = self;
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    self.tapGestureRecognizer.delegate = self;
    
    self.operationContainerView.left = self.contentView.right;
}

#pragma mark -
#pragma mark Swipe Gesture
- (void)rightSwipeGesture:(UISwipeGestureRecognizer *)swipeGesture {
	
	if (self.editing) {
		return;
	}
    
    [self swipeAnimated:YES completion:^{
        
    }];

}

- (void)leftSwipeGesture:(UISwipeGestureRecognizer *)swipeGesture {
	
	if (self.editing) {
		return;
	}
    
    [self swipeAnimated:YES completion:^{
        
    }];

}

- (void)tapGesture:(UITapGestureRecognizer *)tapGesture {
    [self swipeAnimated:YES completion:^{
        
    }];
}

- (void)swipeAnimated:(BOOL)animated completion:(void (^)())completion {
    BOOL shouldOpen = (self.contentView.left == 0);
    __weak typeof(self)weakSelf = self;

	[UIView animateWithDuration: animated ? 0.2f : 0 animations:^{
        if (shouldOpen) {
            weakSelf.contentView.left = - weakSelf.operationContainerView.width;
        } else {
            weakSelf.contentView.left = 0;
        }
        weakSelf.operationContainerView.left = weakSelf.contentView.right;
	} completion:^(BOOL finished) {
        if (!shouldOpen) {
            [weakSelf.contentView removeGestureRecognizer:weakSelf.tapGestureRecognizer];
        } else {
            [weakSelf.contentView addGestureRecognizer:weakSelf.tapGestureRecognizer];
            [weakSelf.ddTableView cellDidOpen:self];
        }
		if (completion) {
			completion();
		}
	}];
}

- (void)closeAnimated:(BOOL)animated completion:(void (^)())completion {
    if (self.contentView.left == 0) {
        return;
    }
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration: animated ? 0.2f : 0 animations:^{

        weakSelf.contentView.left = 0;
        weakSelf.operationContainerView.left = weakSelf.contentView.right;
	} completion:^(BOOL finished) {
        [weakSelf.contentView removeGestureRecognizer:weakSelf.tapGestureRecognizer];
		if (completion) {
			completion();
		}
	}];
}



@end
