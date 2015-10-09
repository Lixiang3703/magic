//
//  KKModifyProfileViewController.m
//  Magic
//
//  Created by lixiang on 15/4/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKModifyProfileViewController.h"

@interface KKModifyProfileViewController ()

@property (nonatomic, strong) KKModifyTextFieldCellItem *nameModifyCellItem;
@property (nonatomic, strong) UITextField *nameModifyTextField;


@end

@implementation KKModifyProfileViewController


- (KKModifyTextFieldCellItem *)nameModifyCellItem {
    if (_nameModifyCellItem == nil) {
        _nameModifyCellItem = [[KKModifyTextFieldCellItem alloc] init];
        _nameModifyCellItem.tagName = @"姓名";
        _nameModifyCellItem.titleName = @"";
    }
    return _nameModifyCellItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.personItem) {
        [self.modifyPersonItem copyFromPersonItem:self.personItem];
    }
    
    [self reloadDataSourceWithRecordFromUI:NO];
}


- (void)setupRawItemFromUI {
    KKModifyTextFieldCell *textFieldCell = nil;
    textFieldCell = (KKModifyTextFieldCell *)[self.tableView cellForCellItem:self.nameModifyCellItem];
    self.nameModifyTextField = textFieldCell.textField;
    
    self.modifyPersonItem.name = self.nameModifyTextField.text;
}

- (void)reloadDataSourceWithRecordFromUI:(BOOL)recordFromUi {
    
    if (recordFromUi) {
        [self setupRawItemFromUI];
    }
    
    [self.dataSource clear];
    
    [self.dataSource addCellItem:[self groupHeaderCellItemWithTitle:nil seperatorLeft:0]];
    
    self.nameModifyCellItem.titleName = self.modifyPersonItem.name;
    
    NSMutableArray *cellItemArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    [cellItemArray addSafeObject:self.nameModifyCellItem];
    
    [self.dataSource addCellItems:cellItemArray];
}

#pragma mark -
#pragma mark Action

- (void)rightBarButtonItemClick:(id)sender {
    NSLog(@"text:%@",self.nameModifyTextField.text);
    
    [self setupRawItemFromUI];
    
    if (![self.nameModifyTextField.text hasContent]) {
        [UIAlertView postAlertWithMessage:_(@"请输入姓名")];
        return;
    }
    
    [UIAlertView postHUDAlertWithMessage:@"正在保存..." windowInteractionEnabled:NO];
    
    __weak __typeof(self) weakSelf = self;
    KKUserUpdateBasicInfoRequestModel *updateRequestModel = [[KKUserUpdateBasicInfoRequestModel alloc] init];
    updateRequestModel.personItem = self.modifyPersonItem;
    
    updateRequestModel.successBlock = ^(id responseObject, NSDictionary *headers, KKUserUpdateBasicInfoRequestModel* requestModel) {
        [UIAlertView HUDAlertDismiss];
        [UIAlertView postAlertWithMessage:@"保存成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Profile_Update_BasicInfo_Success object:nil];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    updateRequestModel.failBlock = ^(id responseObject, NSDictionary *headers, KKUserUpdateBasicInfoRequestModel* requestModel) {
        [UIAlertView HUDAlertDismiss];
        [UIAlertView postAlertWithMessage:@"保存失败"];
    };
    
    [updateRequestModel load];
}

@end
