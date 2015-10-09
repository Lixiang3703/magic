//
//  KKBaseCaseInsertViewController.m
//  Magic
//
//  Created by lixiang on 15/4/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKBaseCaseInsertViewController.h"
#import "KKOptionItem.h"
#import "KKCaseClassicsCellItem.h"
#import "KKIndustryItem.h"
#import "KKIndustryManager.h"
#import "KKClassicsManager.h"
#import "KKBasePhoneManager.h"

@interface KKBaseCaseInsertViewController ()<KKModifyTextFieldCellDelegate,KKModifyTextViewCellDelegate>

@end

@implementation KKBaseCaseInsertViewController

#pragma mark -
#pragma mark Accessor

- (KKCaseItem *)caseItem {
    if (_caseItem == nil) {
        _caseItem = [[KKCaseItem alloc] init];
    }
    return _caseItem;
}

- (KKCaseInsertRequestModel *)insertRequestModel {
    if (_insertRequestModel == nil) {
        _insertRequestModel = [[KKCaseInsertRequestModel alloc] init];
        
    }
    return _insertRequestModel;
}

- (KKCaseOperationView *)operationView {
    if (_operationView == nil) {
        _operationView = [[KKCaseOperationView alloc] initWithFrame:CGRectMake(0, 0, [UIDevice screenWidth], kEntityInsert_OperationView_Height)];
    }
    return _operationView;
}

- (KKModifyTextFieldCellItem *)titleModifyCellItem {
    if (_titleModifyCellItem == nil) {
        _titleModifyCellItem = [[KKModifyTextFieldCellItem alloc] init];
        _titleModifyCellItem.cellIdentifier = @"modifyTextFieldCellItem_Name";
        _titleModifyCellItem.tagName = @"标题";
        _titleModifyCellItem.placeHolderString = @"请输入标题";
        _titleModifyCellItem.titleName = @"";
        _titleModifyCellItem.rawObject = @(KKCaseFieldTypeTitle);
    }
    return _titleModifyCellItem;
}

- (KKModifyTextFieldCellItem *)applyNameModifyCellItem {
    if (_applyNameModifyCellItem == nil) {
        _applyNameModifyCellItem = [[KKModifyTextFieldCellItem alloc] init];
        _applyNameModifyCellItem.cellIdentifier = @"modifyTextFieldCellItem_Name";
        _applyNameModifyCellItem.tagName = @"注册名称";
        _applyNameModifyCellItem.titleName = @"";
        _applyNameModifyCellItem.rawObject = @(KKCaseFieldTypeApplyName);
    }
    return _applyNameModifyCellItem;
}

- (KKModifyTextFieldCellItem *)productionModifyCellItem {
    if (_productionModifyCellItem == nil) {
        _productionModifyCellItem = [[KKModifyTextFieldCellItem alloc] init];
        _productionModifyCellItem.cellIdentifier = @"modifyTextFieldCellItem_Name";
        _productionModifyCellItem.tagName = @"产品名称";
        _productionModifyCellItem.titleName = @"";
        _productionModifyCellItem.rawObject = @(KKCaseFieldTypeProductionName);
    }
    return _productionModifyCellItem;
}

- (KKModifyTextFieldCellItem *)applyNumberModifyCellItem {
    if (_applyNumberModifyCellItem == nil) {
        _applyNumberModifyCellItem = [[KKModifyTextFieldCellItem alloc] init];
        _applyNumberModifyCellItem.cellIdentifier = @"modifyTextFieldCellItem_Name";
        _applyNumberModifyCellItem.tagName = @"商标注册号";
        _applyNumberModifyCellItem.titleName = @"";
        _applyNameModifyCellItem.rawObject = @(KKCaseFieldTypeApplyNumber);
    }
    return _applyNumberModifyCellItem;
}

- (KKModifyTextViewCellItem *)contentModifyCellItem {
    if (_contentModifyCellItem == nil) {
        _contentModifyCellItem = [[KKModifyTextViewCellItem alloc] init];
        _contentModifyCellItem.cellHeight = 130;
        _contentModifyCellItem.titleName = @"";
        _contentModifyCellItem.placeHolderString = @"备注";
    }
    return _contentModifyCellItem;
}

- (KKModifyPickerTagCellItem *)categoryModifyCellItem {
    if (_categoryModifyCellItem == nil) {
        _categoryModifyCellItem = [[KKModifyPickerTagCellItem alloc] init];
        _categoryModifyCellItem.tagName = @"分类";
        _categoryModifyCellItem.titleName = @"";
        _categoryModifyCellItem.rawObject = kEntityInsertCellItemTag_Category;
    }
    return _categoryModifyCellItem;
}

- (KKModifyPickerTagCellItem *)industryModifyCellItem {
    if (_industryModifyCellItem == nil) {
        _industryModifyCellItem = [[KKModifyPickerTagCellItem alloc] init];
        _industryModifyCellItem.tagName = @"行业";
        _industryModifyCellItem.placeHolderString = @"请选择行业";
        _industryModifyCellItem.titleName = @"";
        _industryModifyCellItem.rawObject = kEntityInsertCellItemTag_Industry;
    }
    return _industryModifyCellItem;
}

- (KKCaseClassicsCellItem *)classicsCellItem {
    if (_classicsCellItem == nil) {
        _classicsCellItem = [[KKCaseClassicsCellItem alloc] init];
        
        
        
    }
    return _classicsCellItem;
}

- (KKPickerView *)categoryPickerView {
    if (_categoryPickerView == nil) {
        __weak __typeof(self) weakSelf = self;
        
        _categoryPickerView = [[KKPickerView alloc] init];
        _categoryPickerView.top = self.view.height;
        _categoryPickerView.titleLabel.text = @"选择分类";
        _categoryPickerView.pickerSelectedBlock = ^(KKPickerItem *pickerItem, NSNumber *info){
            KKOptionItem *optionItem = pickerItem.rawObject;
            if (![optionItem isKindOfClass:[KKOptionItem class]]) {
                return;
            }
            
            weakSelf.categoryModifyCellItem.titleName = optionItem.name;
            
            [weakSelf setupRawItemFromUI];
            [weakSelf.tableView reloadData];
        };
        
        _categoryPickerView.pickerDismissBlock = ^(KKPickerItem *pickerItem, NSNumber *info){
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                weakSelf.tableView.contentOffset = CGPointMake(0, 0);
            }];
        };
        _categoryPickerView.pickerShowBlock = ^(KKPickerItem *pickerItem, NSNumber *info) {
            weakSelf.tableView.contentInset = UIEdgeInsetsMake(0, 0, 230, 0);
            weakSelf.tableView.contentOffset = CGPointMake(0, 160);
        };
    }
    
    return _categoryPickerView;
}

- (KKPickerView *)industryPickerView {
    if (_industryPickerView == nil) {
        __weak __typeof(self) weakSelf = self;
        
        _industryPickerView = [[KKPickerView alloc] init];
        _industryPickerView.top = self.view.height;
        _industryPickerView.titleLabel.text = @"选择行业";
        _industryPickerView.pickerSelectedBlock = ^(KKPickerItem *pickerItem, NSNumber *info){
            KKIndustryItem *industryItem = pickerItem.rawObject;
            if (!industryItem || ![industryItem isKindOfClass:[KKIndustryItem class]]) {
                return;
            }
            
            weakSelf.industryModifyCellItem.titleName = industryItem.name;
            
            weakSelf.caseItem.industryId = industryItem.industryId;
            [weakSelf reloadClassicsItem];
            [weakSelf setupRawItemFromUI];
            [weakSelf.tableView reloadData];
        };
        
        _industryPickerView.pickerDismissBlock = ^(KKPickerItem *pickerItem, NSNumber *info){
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                weakSelf.tableView.contentOffset = CGPointMake(0, 0);
            }];
        };
        _industryPickerView.pickerShowBlock = ^(KKPickerItem *pickerItem, NSNumber *info) {
            [weakSelf setupRawItemFromUI];
            weakSelf.tableView.contentInset = UIEdgeInsetsMake(0, 0, 230, 0);
            weakSelf.tableView.contentOffset = CGPointMake(0, 160);
        };
    }
    
    return _industryPickerView;
}

#pragma mark -
#pragma mark life cycle

- (void)initSettings {
    [super initSettings];
    self.tableSpinnerHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.hasRefreshControl = NO;
    
    [self.view addSubview:self.categoryPickerView];
    [self setupCategoryPickerView];
    
    [self.view addSubview:self.industryPickerView];
    [self setupIndustryPickerView];
    
    self.operationView.top = [UIDevice screenHeight] - [DDRuler viewTopZeroWithNavigationBar] - kEntityInsert_OperationView_Height;
    [self.operationView.callButton addTarget:self action:@selector(callButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.operationView.insertButton addTarget:self action:@selector(insertButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.operationView];
    
    self.subType = KKCaseSubTypeUnKnown;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self setupTextFields];
    
}

- (void)setupTextFields {
    KKModifyTextViewCell *infoModifyCell  = (KKModifyTextViewCell*)[self.tableView cellForCellItem:self.contentModifyCellItem];
    self.contentModifyTextView = infoModifyCell.textView;
    
    KKModifyTextFieldCell *textFieldCell = nil;
    
    textFieldCell = (KKModifyTextFieldCell *)[self.tableView cellForCellItem:self.titleModifyCellItem];
    self.titleModifyTextField = textFieldCell.textField;
    
    textFieldCell = (KKModifyTextFieldCell *)[self.tableView cellForCellItem:self.applyNameModifyCellItem];
    self.applyNameModifyTextField = textFieldCell.textField;
    
    textFieldCell = (KKModifyTextFieldCell *)[self.tableView cellForCellItem:self.productionModifyCellItem];
    self.productionModifyTextField = textFieldCell.textField;
    
    textFieldCell = (KKModifyTextFieldCell *)[self.tableView cellForCellItem:self.applyNumberModifyCellItem];
    self.applyNumberModifyTextField = textFieldCell.textField;
}

#pragma mark -
#pragma mark Logic

- (void)reloadClassicsItem {
    self.classicsCellItem.rawObject = [[KKClassicsManager getInstance].itemDict objectForSafeKey:@(self.caseItem.industryId)];
}

#pragma mark -
#pragma mark Navigation Bar

- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    [self setNaviTitle:@"业务办理"];
    
    [self setRightBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:_(@"提交") target:self action:@selector(insertButtonClick:)] animated:animated];
}

- (void)setupIndustryPickerView {
    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    
    [[KKIndustryManager getInstance].industryItemList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        KKPickerItem *item = nil;
        KKIndustryItem *industryItem = (KKIndustryItem *)obj;
        if ([industryItem isKindOfClass:[KKIndustryItem class]]) {
            item = [[KKPickerItem alloc] init];
            item.rawObject = industryItem;
            item.displayId = [NSString stringWithFormat:@"%ld",(long)industryItem.industryId];
            item.displayString = industryItem.name;
            [dataSource addSafeObject:item];
            
            if (self.caseItem && self.caseItem.industryId <= 0) {
                self.caseItem.industryId = industryItem.industryId;
                self.industryModifyCellItem.titleName = industryItem.name;
                [self reloadClassicsItem];
//                [self.tableView reloadData];
            }
        };
    }];
    
//    for (int i = 0; i < 10; i ++) {
//        KKPickerItem *pickerItem = nil;
//        pickerItem = [[KKPickerItem alloc] init];
//        KKIndustryItem *industryItem = [[KKIndustryItem alloc] init];
//        industryItem.industryId = i;
//        industryItem.name = [NSString stringWithFormat:@"互联网%d",i];
//        
//        pickerItem.rawObject = industryItem;
//        
//        pickerItem.displayId = @"23";
//        pickerItem.displayString = industryItem.name;
//        
//        [dataSource addSafeObject:pickerItem];
//    }
    
    [self.industryPickerView reloadDataWithDataSoure:dataSource];
}

- (void)setupCategoryPickerView {
    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i ++) {
        KKPickerItem *pickerItem = nil;
        pickerItem = [[KKPickerItem alloc] init];
        KKOptionItem *optionItem = [[KKOptionItem alloc] init];
        optionItem.name = @"金融choose";
        pickerItem.rawObject = optionItem;
        pickerItem.displayId = @"11";
        pickerItem.displayString = @"金融";
        [dataSource addSafeObject:pickerItem];
    }
    
    [self.categoryPickerView reloadDataWithDataSoure:dataSource];
}

#pragma mark -
#pragma mark Cell Selection Actions

- (void)cellDidSelectWithTableView:(UITableView *)tableView cellItem:(DDBaseCellItem *)cellItem cell:(DDBaseCell *)cell didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super cellDidSelectWithTableView:tableView cellItem:cellItem cell:cell didSelectRowAtIndexPath:indexPath];
    if ([cellItem isKindOfClass:[KKModifyPickerTagCellItem class]]) {
        if ([(NSString *)cellItem.rawObject isEqualToString:kEntityInsertCellItemTag_Category]) {
            [self setupRawItemFromUI];
            
            [self.categoryPickerView showInView:self.view completion:^(BOOL finished) {
                
            }];
        }
        else if ([(NSString *)cellItem.rawObject isEqualToString:kEntityInsertCellItemTag_Industry]) {
            [self setupRawItemFromUI];
            
            [self.industryPickerView showInView:self.view completion:^(BOOL finished) {
                
            }];
        }
    }
    else
        if ([cellItem isKindOfClass:[KKModifyTextFieldCellItem class]]) {
            KKModifyTextFieldCell *fieldCell = (KKModifyTextFieldCell *)cell;
            [fieldCell.textField becomeFirstResponder];
        }
}

#pragma mark -
#pragma mark KKModifyTextViewCellDelegate

- (void)kkModifyTextViewCellBecomeFirstResponder:(NSDictionary *)userInfo {
    UITextView *textView = userInfo[kDDTableView_Action_Key_Control];
    if (textView && [textView isKindOfClass:[UITextView class]]) {
        if (textView == self.contentModifyTextView) {
            [UIView animateWithDuration:0.25 animations:^{
                self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 200, 0);
                self.tableView.contentOffset = CGPointMake(0, 20);
            } completion:nil];
        }
    }
}

- (void)kkModifyTextViewCellTextChanged:(NSDictionary *)userInfo {
    
}

#pragma mark -
#pragma mark KKModifyTextFieldCellDelegate

- (void)kkModifyTextFieldCellBecomeFirstResponder:(NSDictionary *)userInfo {
    
}

- (void)kkModifyTextFieldCellTextChanged:(NSDictionary *)userInfo {
    
}



#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [super scrollViewWillBeginDragging:scrollView];
    self.startPoint = scrollView.contentOffset;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    if (self.startPoint.y - scrollView.contentOffset.y > 70 || scrollView.contentOffset.y < -10 || self.startPoint.y - scrollView.contentOffset.y < 70) {
        [[self.view.window findFirstResponder] resignFirstResponder];
        self.tableView.top = 0;
    }
    [self setupRawItemFromUI];
}

#pragma mark -
#pragma mark Sub Class template method

- (void)setupRawItemFromUI {
    self.caseItem.type = self.caseType;
    self.caseItem.content = self.contentModifyTextView.text;
    self.caseItem.title = self.titleModifyTextField.text;
    
    self.titleModifyCellItem.titleName = self.caseItem.title;
    self.contentModifyCellItem.titleName = self.caseItem.content;
}

- (void)reloadDataSourceWithRecordFromUI:(BOOL)recordFromUi {
    
}

#pragma mark -
#pragma mark OperationView Action

- (void)callButtonClick:(id)sender {
    [[KKBasePhoneManager getInstance] makePhoneForService];
}

- (void)insertButtonClick:(id)sender {
    
}


@end


