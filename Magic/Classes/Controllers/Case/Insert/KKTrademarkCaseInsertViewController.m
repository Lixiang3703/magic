//
//  KKBrandCaseInsertViewController.m
//  Magic
//
//  Created by lixiang on 15/4/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKTrademarkCaseInsertViewController.h"
#import "KKCaseFieldManager.h"
#import "KKCaseTypeItem.h"

#import "YYDropDownListView.h"
#import "KKClassicsManager.h"
#import "UIAlertView+Blocks.h"

@interface KKTrademarkCaseInsertViewController ()<YYDropDownChooseDelegate, YYDropDownChooseDataSource>

@property (nonatomic, strong) YYDropDownListView *dropDownListView;
@property (nonatomic, strong) NSMutableArray *caseSubTypeArray;

@end

@implementation KKTrademarkCaseInsertViewController

#pragma mark -
#pragma mark Accessor

- (YYDropDownListView *)dropDownListView {
    if (_dropDownListView == nil) {
        _dropDownListView = [[YYDropDownListView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kDropDownListHeight) dataSource:self delegate:self];
//        _dropDownListView.cannotCancel = YES;
        _dropDownListView.mSuperView = self.view;
    }
    return _dropDownListView;
}

- (NSMutableArray *)caseSubTypeArray {
    if (_caseSubTypeArray == nil) {
        _caseSubTypeArray = [NSMutableArray array];
    }
    return _caseSubTypeArray;
}


#pragma mark -
#pragma mark Init

- (void)initSettings {
    [super initSettings];
    
    self.caseType = KKCaseTypeTrademark;
    self.subType = KKCaseSubTypeAssignment;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.dropDownListView];
    
    self.classicsCellItem.rawObject = [KKClassicsManager getInstance].itemList;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self injectCaseSubType];
    [self.dropDownListView showChooseListTableViewInSection:0 choosedIndex:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Navigation Bar

- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    [self setNaviTitle:@"商标服务"];
}

#pragma mark -
#pragma mark Actions

- (void)insertButtonClick:(id)sender {
    [self setupRawItemFromUI];
    
    if (self.subType <= KKCaseSubTypeUnKnown || self.subType >= KKCaseSubTypeCount) {
        [UIAlertView postAlertWithMessage:_(@"请选择业务类型")];
        [self.dropDownListView showChooseListTableViewInSection:0 choosedIndex:0];
        return;
    }
    
    for (int tag = KKCaseFieldTypeTitle; tag < KKCaseFieldTypeCount; tag ++) {
        if (![[KKCaseFieldManager getInstance] shouldShowForCaseType:self.caseType subType:self.subType caseFieldType:tag]) {
            continue;
        }

        if (![[KKCaseFieldManager getInstance] validFieldForCaseFiedlType:tag caseItem:self.caseItem]) {
            NSString *title = [[KKCaseFieldManager getInstance] titleForCaseFieldType:tag];
            [UIAlertView postAlertWithMessage:[NSString stringWithFormat:@"请输入%@",title]];
            return;
        }
    }
    
    if (!self.hasChooseIndustry) {
        [[self.view.window findFirstResponder] resignFirstResponder];
        
        [self setupRawItemFromUI];
        [self.industryPickerView showInView:self.view completion:^(BOOL finished) {
            
        }];
        self.hasChooseIndustry = YES;
        return;
    }
    
//    if (![self.caseItem.content hasContent]) {
//        [UIAlertView postAlertWithMessage:_(@"请输入备注")];
//        [self.contentModifyTextView becomeFirstResponder];
//        return;
//    }
    self.caseItem.subType = self.subType;
    
    [self.caseItem createCustom];
    [self.caseItem createTitle];
    
    __weak __typeof(self) weakSelf = self;
    self.insertRequestModel.caseItem = self.caseItem;
    
    [UIAlertView postHUDAlertWithMessage:@"正在创建..." windowInteractionEnabled:NO];
    
    self.insertRequestModel.successBlock = ^(id responseObject, NSDictionary *headers, KKCaseInsertRequestModel* requestModel) {
        [UIAlertView HUDAlertDismiss];
//        [UIAlertView postAlertWithMessage:@"创建成功"];
        
        RIButtonItem *okBnt = [RIButtonItem itemWithLabel:_(@"好的")];
        okBnt.action = ^{
        };
        [[[UIAlertView alloc] initWithTitle:_(@"您的业务已经提交成功，客服人员会尽快与您取得联系")
                                    message:_(@"")
                           cancelButtonItem:nil
                           otherButtonItems:okBnt, nil] show];
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    self.insertRequestModel.failBlock = ^(id responseObject, NSDictionary *headers, KKCaseInsertRequestModel* requestModel) {
        [UIAlertView HUDAlertDismiss];
    };
    
    [self.insertRequestModel load];
}

#pragma mark -
#pragma mark Base

- (void)injectCaseSubType {
    for (int tag = KKCaseSubTypeAssignment; tag < KKCaseSubTypeCount; tag ++) {
        KKCaseTypeItem *caseTypeItem = [[KKCaseTypeItem alloc] init];
        caseTypeItem.subType = tag;
        caseTypeItem.name = [[KKCaseFieldManager getInstance] titleForCaseSubType:tag];
        [self.caseSubTypeArray addSafeObject:caseTypeItem];
    }
}




#pragma mark -
#pragma mark DataSrouce
- (void)generateDataSource {
    [super generateDataSource];
    
    [self reloadDataSourceWithRecordFromUI:NO];
}

#pragma mark -
#pragma mark KKBaseEntityInsertViewController template

- (void)setupRawItemFromUI {
    [super setupRawItemFromUI];
    
    self.caseItem.title = self.titleModifyTextField.text;
    self.caseItem.customItem.applyName = self.applyNameModifyTextField.text;
    self.caseItem.customItem.applyNumber = self.applyNumberModifyTextField.text;
    self.caseItem.customItem.productionName = self.productionModifyTextField.text;
    
    self.applyNumberModifyCellItem.titleName = self.caseItem.customItem.applyNumber;
    self.applyNameModifyCellItem.titleName = self.caseItem.customItem.applyName;
    self.productionModifyCellItem.titleName = self.caseItem.customItem.productionName;
}

- (void)reloadDataSourceWithRecordFromUI:(BOOL)recordFromUi {
    if (recordFromUi) {
        [self setupRawItemFromUI];
    }
    
    [self.dataSource clear];
    
    NSMutableArray *cellItemArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    [cellItemArray addSafeObject:[YYGroupHeaderCellItem cellItemWithHeight:(kDropDownListHeight + 5) title:nil]];
    
    YYGroupHeaderCellItem *groupCellItem = nil;
    
    //  Placeholder
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:5 title:nil];
    [cellItemArray addSafeObject:groupCellItem];
    
    for (int tag = KKCaseFieldTypeTitle; tag < KKCaseFieldTypeCount; tag ++) {
        if (![[KKCaseFieldManager getInstance] shouldShowForCaseType:self.caseType subType:self.subType caseFieldType:tag]) {
            continue;
        }
        [cellItemArray addSafeObject:[self cellItemForFieldType:tag]];
    }
    
//    [cellItemArray addSafeObject:self.titleModifyCellItem];
//    [cellItemArray addSafeObject:self.applyNameModifyCellItem];
//    [cellItemArray addSafeObject:self.productionModifyCellItem];
//    [cellItemArray addSafeObject:self.applyNumberModifyCellItem];
    
    //  Placeholder
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_HeightS title:nil];
    [cellItemArray addSafeObject:groupCellItem];
    [cellItemArray addSafeObject:[YYGroupHeaderCellItem groupHeaderCellItemForModifyInfoWithTitle:@"简介"]];
    [cellItemArray addSafeObject:self.contentModifyCellItem];

    //  Placeholder
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_HeightS title:nil];
    [cellItemArray addSafeObject:groupCellItem];
    [cellItemArray addSafeObject:self.industryModifyCellItem];
    
    if (self.subType == KKCaseSubTypeAssignment) {
        //  Placeholder
        groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_HeightS title:nil];
        [cellItemArray addSafeObject:groupCellItem];
        [cellItemArray addSafeObject:[YYGroupHeaderCellItem groupHeaderCellItemForModifyInfoWithTitle:@"行业案例"]];
        [cellItemArray addSafeObject:self.classicsCellItem];
    }
    
    
    // bottom place holder
    [cellItemArray addSafeObject:[YYGroupHeaderCellItem cellItemWithHeight:50 title:nil]];
    
    [self.dataSource addCellItems:cellItemArray];
    [self.tableView reloadData];
}

- (YYBaseCellItem *)cellItemForFieldType:(KKCaseFieldType)fieldType {
    switch (fieldType) {
        case KKCaseFieldTypeTitle:
            return self.titleModifyCellItem;
            break;
        case KKCaseFieldTypeApplyName:
            return self.applyNameModifyCellItem;
            break;
        case KKCaseFieldTypeProductionName:
            return self.productionModifyCellItem;
            break;
        case KKCaseFieldTypeApplyNumber:
            return self.applyNumberModifyCellItem;
            break;
        default:
            break;
    }
    
    return nil;
}


#pragma mark -
#pragma mark YYDropDownChooseDelegate

-(void)chooseAtSection:(NSInteger)section index:(NSInteger)index {
    NSLog(@"you choose section:%ld ,index:%ld",(long)section,(long)index);
    switch (section) {
        case 0:
        {
            KKCaseTypeItem *caseTypeItem = [self.caseSubTypeArray objectAtSafeIndex:index];
            if (caseTypeItem && [caseTypeItem isKindOfClass:[KKCaseTypeItem class]]) {
                self.subType = caseTypeItem.subType;
                [self reloadDataSourceWithRecordFromUI:YES];
                [self setupTextFields];
            }
        }
            break;
        default:
            break;
    }
}

- (BOOL)shouldChooseSection:(NSInteger)section {
    return YES;
}

#pragma mark -
#pragma mark YYDropDownChooseDataSource

-(NSInteger)numberOfSections {
    return 1;
}

- (CGFloat)currentDropDownTableViewControllerTop {
    return kDropDownListHeight;
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return self.caseSubTypeArray.count;
            break;
        default:
            break;
    }
    
    return 0;
}

-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index {
    switch (section) {
        case 0:
        {
            KKCaseTypeItem *caseTypeItem = [self.caseSubTypeArray objectAtSafeIndex:index];
            if (caseTypeItem && [caseTypeItem isKindOfClass:[KKCaseTypeItem class]]) {
                return caseTypeItem.name;
            }
            return @"请选择业务类型";
        }
            break;
        default:
            return @"";
            break;
    }
    
    return @"";
}

-(NSInteger)defaultShowSection:(NSInteger)section {
    return 0;
}

@end
