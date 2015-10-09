//
//  YYDropDownListView.m
//  Wuya
//
//  Created by lixiang on 15/3/24.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "YYDropDownListView.h"
#import "YYDropDownListTableViewController.h"

#import "YYDropDownListOneCellItem.h"
#import "YYDropDownListOneCell.h"

#define kDropDownListTableViewHeight  (230)

#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians)*(180.0/M_PI))

@interface YYDropDownListView()

@property (nonatomic, strong) UIView *mTableBaseView;

@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) YYDropDownListTableViewController *dropDownListTableViewController;

@property (nonatomic, strong) NSMutableDictionary *currentChoosedIndexDict;

@end

@implementation YYDropDownListView

#pragma mark -
#pragma mark Access

- (NSMutableDictionary *)currentChoosedIndexDict {
    if (_currentChoosedIndexDict == nil) {
        _currentChoosedIndexDict = [NSMutableDictionary dictionary];
    }
    return _currentChoosedIndexDict;
}

- (YYDropDownListTableViewController *)dropDownListTableViewController {
    if (_dropDownListTableViewController == nil) {
        _dropDownListTableViewController = [[YYDropDownListTableViewController alloc] init];
        __weak __typeof(self)weakSelf = self;
        _dropDownListTableViewController.tableViewSelectionBlock = ^(NSIndexPath *indexPath) {
            if ([weakSelf.dropDownDelegate respondsToSelector:@selector(chooseAtSection:index:)]) {
                NSString *chooseCellTitle = [weakSelf.dropDownDataSource titleInSection:weakSelf.currentExtendSection index:indexPath.row];
                
                [weakSelf.currentChoosedIndexDict setObject:@(indexPath.row) forKey:@(weakSelf.currentExtendSection)];                
                [weakSelf setTitle:chooseCellTitle inSection:weakSelf.currentExtendSection];
                
                [weakSelf.dropDownDelegate chooseAtSection:weakSelf.currentExtendSection index:indexPath.row];
                [weakSelf hideExtendedTableView];
            }
        };
    }
    return _dropDownListTableViewController;
}

- (UIView *)mTableBaseView {
    if (_mTableBaseView == nil) {
        _mTableBaseView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height , self.frame.size.width, self.mSuperView.frame.size.height - self.frame.origin.y - self.frame.size.height)];
        _mTableBaseView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5];
        
        UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTappedAction:)];
        [_mTableBaseView addGestureRecognizer:bgTap];        
    }
    return _mTableBaseView;
}

#pragma mark -
#pragma mark life cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = NO;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame dataSource:(id)datasource delegate:(id) delegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.currentExtendSection = -1;
        self.dropDownDataSource = datasource;
        self.dropDownDelegate = delegate;
        
        NSInteger sectionNum =0;
        if ([self.dropDownDataSource respondsToSelector:@selector(numberOfSections)] ) {
            
            sectionNum = [self.dropDownDataSource numberOfSections];
        }
        
        if (sectionNum == 0) {
            self = nil;
        }
        
        //初始化默认显示view
        CGFloat rightIconWidth = 5.5f;
        CGFloat rightIconMargin_Left = 20;
        CGFloat labelMargin_left = 5;
        CGFloat sectionWidth = (1.0*(frame.size.width)/sectionNum) ;
        
        CGFloat sectionLabelWidth = sectionWidth - rightIconWidth - rightIconMargin_Left - labelMargin_left;
        
        for (int i = 0; i <sectionNum; i++) {
            
            NSString *sectionBtnTitle = @"--";
            if ([self.dropDownDataSource respondsToSelector:@selector(titleInSection:index:)]) {
                sectionBtnTitle = [self.dropDownDataSource titleInSection:i index:[self.dropDownDataSource defaultShowSection:i]];
            }
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelMargin_left + sectionWidth*i, 1, sectionLabelWidth, frame.size.height-2)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor YYBlackColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.numberOfLines = 2;
            label.font = [UIFont systemFontOfSize:16.f];
            label.tag = SECTION_Label_TAG_BEGIN + i;
            label.text = sectionBtnTitle;
            [self addSubview:label];
            
            UIButton *sectionBtn = [[UIButton alloc] initWithFrame:CGRectMake(sectionWidth*i, 1, sectionWidth, frame.size.height-2)];
            sectionBtn.tag = SECTION_BTN_TAG_BEGIN + i;
            [sectionBtn addTarget:self action:@selector(sectionBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
            
            [sectionBtn  setTitle:@"" forState:UIControlStateNormal];
            [sectionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            sectionBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
            sectionBtn.backgroundColor = [UIColor clearColor];
            [self addSubview:sectionBtn];
            
            UIImageView *sectionBtnIv = [[UIImageView alloc] initWithFrame:CGRectMake(sectionWidth*i +(sectionWidth - rightIconWidth - rightIconMargin_Left), (self.frame.size.height - rightIconWidth)/2, rightIconWidth, 4)];
            sectionBtnIv.left = label.right;
            [sectionBtnIv setImage:[UIImage imageNamed:@"down_light.png"]];
            [sectionBtnIv setContentMode:UIViewContentModeScaleToFill];
            sectionBtnIv.tag = SECTION_IV_TAG_BEGIN + i;
            
            [self addSubview: sectionBtnIv];
            
            if (i<sectionNum && i != 0) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(sectionWidth*i, frame.size.height/4, 1, frame.size.height/2)];
                lineView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
                [self addSubview:lineView];
            }
            
        }
        self.bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
        self.bottomLineView.backgroundColor = [UIColor YYLineColor];
        [self addSubview:self.bottomLineView];
        
    }
    return self;
}

- (BOOL)isShow {
    if (self.currentExtendSection == -1) {
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark Actions

- (void)showChooseListTableViewInSection:(NSInteger)section choosedIndex:(NSInteger)index {
    
    self.currentExtendSection = section;
    [self reloadDropDownDataForSection:section];
    [self.dropDownListTableViewController.tableView reloadData];
    
    CGFloat top = 64;
    if ([self.dropDownDataSource respondsToSelector:@selector(currentDropDownTableViewControllerTop)]) {
        top = [self.dropDownDataSource currentDropDownTableViewControllerTop];
    }
    
    self.mTableBaseView.top = top;
    
    CGRect rect = CGRectMake(0, top, self.frame.size.width, 0);
    
    self.dropDownListTableViewController.view.frame = rect;
    
    [self.mSuperView addSubview:self.mTableBaseView];
    [self.mSuperView addSubview:self.dropDownListTableViewController.view];
    
    //动画设置位置
    rect.size.height = kDropDownListTableViewHeight;
    [UIView animateWithDuration:0.3 animations:^{
        self.mTableBaseView.alpha = 0.2;

        self.mTableBaseView.alpha = 1.0;
        self.dropDownListTableViewController.view.alpha = 1.0;
        self.dropDownListTableViewController.view.frame =  rect;
    
        NSInteger currentIndex = [[self.currentChoosedIndexDict objectForSafeKey:@(self.currentExtendSection)] integerValue];
        
        [self.dropDownListTableViewController.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }];
    
}

- (void)hideExtendedTableView {
    if (self.currentExtendSection != -1) {
        self.currentExtendSection = -1;
        CGRect rect = self.dropDownListTableViewController.view.frame;
        rect.size.height = 0;
        [UIView animateWithDuration:0.3 animations:^{
            self.mTableBaseView.alpha = 1.0f;
            self.dropDownListTableViewController.view.alpha = 1.0f;
            
            self.mTableBaseView.alpha = 0.0f;
            self.dropDownListTableViewController.view.alpha = 0.0;
            
        }completion:^(BOOL finished) {
            [self.dropDownListTableViewController.view removeFromSuperview];
            [self.mTableBaseView removeFromSuperview];
        }];
    }
}

- (void)reloadDropDownDataForSection:(NSInteger)section {
    if (self.dropDownDataSource && [self.dropDownDataSource respondsToSelector:@selector(numberOfRowsInSection:)]) {
        NSMutableArray *cellItemsArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        NSInteger currentChoosedIndex = [[self.currentChoosedIndexDict objectForSafeKey:@(self.currentExtendSection)] integerValue];
        
        NSInteger count = [self.dropDownDataSource numberOfRowsInSection:section];
        for (int i = 0; i < count; i ++) {
            NSString *titleStr = @"";
            if (self.dropDownDataSource && [self.dropDownDataSource respondsToSelector:@selector(titleInSection:index:)]) {
                titleStr = [self.dropDownDataSource titleInSection:section index:i];
            }
            
            YYDropDownListOneCellItem *cellItem = [[YYDropDownListOneCellItem alloc] init];
            cellItem.titleStr = titleStr;
            
            if (i == currentChoosedIndex) {
                cellItem.isSelected = YES;
            }
            
            [cellItemsArray addSafeObject:cellItem];
            
        }
        [self.dropDownListTableViewController reloadMyDataWidthCellItemsArray:cellItemsArray];
    }
}

#pragma mark -
#pragma mark Button Action

- (void)sectionBtnTouch:(UIButton *)btn {
    NSInteger section = btn.tag - SECTION_BTN_TAG_BEGIN;
    
    if (self.dropDownDelegate && [self.dropDownDelegate respondsToSelector:@selector(shouldChooseSection:)]) {
        BOOL shouldChoose = [self.dropDownDelegate shouldChooseSection:section];
        if (!shouldChoose) {
            return;
        }
    }
    
    if (self.currentExtendSection == section) {
        [self hideExtendedTableView];
    }else{
        self.currentExtendSection = section;
        [self showChooseListTableViewInSection:self.currentExtendSection choosedIndex:[self.dropDownDataSource defaultShowSection:self.currentExtendSection]];
    }
    
}

- (void)setTitle:(NSString *)title inSection:(NSInteger)section {
    title = [NSString stringWithFormat:@"%@  ",title];
    UILabel *label = (id)[self viewWithTag:SECTION_Label_TAG_BEGIN +section];
    label.text = title;
}

- (void)chooseIndex:(NSInteger)index inSection:(NSInteger)section {
    [self.currentChoosedIndexDict setObject:@(index) forKey:@(section)];
    if ([self.dropDownDelegate respondsToSelector:@selector(chooseAtSection:index:)]) {
        NSString* sectionBtnTitle = [self.dropDownDataSource titleInSection:section index:[self.dropDownDataSource defaultShowSection:index]];
        [self setTitle:sectionBtnTitle inSection:section];
    }
}

-(void)bgTappedAction:(UITapGestureRecognizer *)tap {
    if (self.cannotCancel) {
        return;
    }
    [self hideExtendedTableView];
}



@end
