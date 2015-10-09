//
//  KKCaseInsertViewController.m
//  Magic
//
//  Created by lixiang on 15/4/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseInsertViewController.h"
#import "KKCaseFieldManager.h"
#import "UIAlertView+Blocks.h"

@interface KKCaseInsertViewController ()

@end

@implementation KKCaseInsertViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Navigation Bar

- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    [self setNaviTitle:@"业务办理"];
    
    NSString *title = [[KKCaseFieldManager getInstance] titleForCaseType:self.caseType];
    [self setNaviTitle:title];
    
}

#pragma mark -
#pragma mark Navi actions

- (void)insertButtonClick:(id)sender {
    [self setupRawItemFromUI];
    
    if (![self.caseItem.title hasContent]) {
        [UIAlertView postAlertWithMessage:_(@"请输入标题")];
        [self.titleModifyTextField becomeFirstResponder];
        return;
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
    
    self.caseItem.subType = KKCaseSubTypeUnKnown;
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
#pragma mark DataSrouce
- (void)generateDataSource {
    [super generateDataSource];
    
    [self reloadDataSourceWithRecordFromUI:NO];
}

#pragma mark -
#pragma mark KKBaseEntityInsertViewController template

- (void)setupRawItemFromUI {
    [super setupRawItemFromUI];
    
}

- (void)reloadDataSourceWithRecordFromUI:(BOOL)recordFromUi {
    if (recordFromUi) {
        [self setupRawItemFromUI];
    }
    
    [self.dataSource clear];
    
    if (self.caseType == KKCaseTypeLegal) {
        self.contentModifyCellItem.placeHolderString = @"案情简述";
    }
    else {
        self.contentModifyCellItem.placeHolderString = @"需求简介";
    }
    
    NSMutableArray *cellItemArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    YYGroupHeaderCellItem *groupCellItem = nil;
    
    //  Placeholder
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_HeightS title:nil];
    [cellItemArray addSafeObject:groupCellItem];
    
    [cellItemArray addSafeObject:self.titleModifyCellItem];
    
    //  Placeholder
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_HeightS title:nil];
    [cellItemArray addSafeObject:groupCellItem];
//    [cellItemArray addSafeObject:[YYGroupHeaderCellItem groupHeaderCellItemForModifyInfoWithTitle:@"简短的需求介绍"]];
    
    [cellItemArray addSafeObject:self.contentModifyCellItem];
    
    //  Placeholder
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_HeightS title:nil];
    [cellItemArray addSafeObject:groupCellItem];
    
    [cellItemArray addSafeObject:self.industryModifyCellItem];
    
    // bottom place holder
    [cellItemArray addSafeObject:[YYGroupHeaderCellItem cellItemWithHeight:50 title:nil]];
    
    [self.dataSource addCellItems:cellItemArray];
    
    [self.tableView reloadData];
    
}

@end
