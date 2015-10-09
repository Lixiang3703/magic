//
//  KKBaseCaseInsertViewController.h
//  Magic
//
//  Created by lixiang on 15/4/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseTableViewController.h"

#import "YYGroupHeaderCellItem.h"
#import "YYGroupHeaderCell.h"

#import "KKModifyTextFieldCell.h"
#import "KKModifyTextFieldCellItem.h"

#import "KKModifyTextViewCell.h"
#import "KKModifyTextViewCellItem.h"

#import "KKModifyPickerTagCell.h"
#import "KKModifyPickerTagCellItem.h"

#import "KKCaseClassicsCell.h"
#import "KKCaseClassicsCellItem.h"

#import "KKPickerView.h"
#import "KKCaseOperationView.h"

#import "KKCaseItem.h"
#import "KKCaseInsertRequestModel.h"

#define kEntityInsert_OperationView_Height           (60)

#define kEntityInsertCellItemTag_Industry            (@"cellItemTagIndustry")
#define kEntityInsertCellItemTag_Category            (@"cellItemTagCategory")

@interface KKBaseCaseInsertViewController : YYBaseTableViewController

@property (nonatomic, assign) CGPoint startPoint;

@property (nonatomic, strong) KKModifyTextFieldCellItem *titleModifyCellItem;
@property (nonatomic, strong) UITextField *titleModifyTextField;

@property (nonatomic, strong) KKModifyTextFieldCellItem *applyNameModifyCellItem;
@property (nonatomic, strong) UITextField *applyNameModifyTextField;

@property (nonatomic, strong) KKModifyTextFieldCellItem *productionModifyCellItem;
@property (nonatomic, strong) UITextField *productionModifyTextField;

@property (nonatomic, strong) KKModifyTextFieldCellItem *applyNumberModifyCellItem;
@property (nonatomic, strong) UITextField *applyNumberModifyTextField;

@property (nonatomic, strong) KKModifyTextViewCellItem *contentModifyCellItem;
@property (nonatomic,strong) YYPlaceHolderTextView *contentModifyTextView;

@property (nonatomic, strong) KKModifyPickerTagCellItem *categoryModifyCellItem;
@property (nonatomic, strong) KKModifyPickerTagCellItem *industryModifyCellItem;

@property (nonatomic, strong) KKCaseClassicsCellItem *classicsCellItem;

@property (nonatomic, strong) KKPickerView *categoryPickerView;
@property (nonatomic, strong) KKPickerView *industryPickerView;

@property (nonatomic, strong) KKCaseOperationView *operationView;

@property (nonatomic, assign) KKCaseType caseType;
@property (nonatomic, assign) KKCaseSubType subType;

@property (nonatomic, strong) KKCaseItem *caseItem;
@property (nonatomic, strong) KKCaseInsertRequestModel *insertRequestModel;

@property (nonatomic, assign) BOOL hasChooseIndustry;

- (void)setupCategoryPickerView;
- (void)setupIndustryPickerView;

- (void)setupTextFields;
- (void)setupRawItemFromUI;
- (void)reloadDataSourceWithRecordFromUI:(BOOL)recordFromUi;

- (void)insertButtonClick:(id)sender;
@end
