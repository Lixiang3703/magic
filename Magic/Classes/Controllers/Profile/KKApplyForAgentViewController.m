//
//  KKApplyForAgentViewController.m
//  Magic
//
//  Created by lixiang on 15/4/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKApplyForAgentViewController.h"

#import "KKSingleBigImageCellItem.h"
#import "KKSingleBigImageCell.h"
#import "KKTagGroupHeaderCellItem.h"
#import "KKTagGroupHeaderCell.h"

#import "KKModifyTextFieldCell.h"
#import "KKModifyTextFieldCellItem.h"
#import "YYGroupHeaderCellItem.h"
#import "YYGroupHeaderCell.h"
#import "YYTextCenterCellItem.h"
#import "YYTextCenterCell.h"

#import "KKPhotoUploadManager.h"

#import "KKLauncher.h"
#import "KKUserInfoItem.h"
#import "DDImageViewer.h"
#import "AppDelegate.h"

#define kApplyForAgent_KeyUploadPhoto               (@"UploadPhoto")

@interface KKApplyForAgentViewController ()<KKTagGroupHeaderCellDelegate>

@property (nonatomic, strong) KKModifyTextFieldCellItem *nameModifyCellItem;
@property (nonatomic, strong) UITextField *nameModifyTextField;

@property (nonatomic, strong) KKSingleBigImageCellItem *uploadImageShowCellItem;

@property (nonatomic, strong) YYTextCenterCellItem *applyForAgentCellItem;

@end

@implementation KKApplyForAgentViewController

#pragma mark -
#pragma mark Accessor

- (KKSingleBigImageCellItem *)uploadImageShowCellItem {
    if (_uploadImageShowCellItem == nil) {
        _uploadImageShowCellItem = [[KKSingleBigImageCellItem alloc] init];
        _uploadImageShowCellItem.defaultImage = [UIImage kkDefaultAvatarImage];
    }
    return _uploadImageShowCellItem;
}

- (KKModifyTextFieldCellItem *)nameModifyCellItem {
    if (_nameModifyCellItem == nil) {
        _nameModifyCellItem = [[KKModifyTextFieldCellItem alloc] init];
        _nameModifyCellItem.tagName = @"公司名称";
        _nameModifyCellItem.titleName = @"";
    }
    return _nameModifyCellItem;
}

- (YYTextCenterCellItem *)applyForAgentCellItem {
    if (_applyForAgentCellItem == nil) {
        _applyForAgentCellItem = [YYTextCenterCellItem cellItemWithTitle:@"审核中"];
        _applyForAgentCellItem.seperatorLineHidden = YES;
        _applyForAgentCellItem.cellWillDisplayBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
            cell.textLabel.textColor = [UIColor KKRedColor];
        };
        _applyForAgentCellItem.cellSelectionBlock = ^(id cellItem, id cell, NSIndexPath *indexPath, YYBaseTableViewController* viewController) {
            KKApplyForAgentViewController *vc = [[KKApplyForAgentViewController alloc] init];
            [viewController.navigationController pushViewController:vc animated:YES];
        };
        
    }
    return _applyForAgentCellItem;
}

#pragma mark -
#pragma mark life cycle

- (void)initSettings {
    [super initSettings];
    self.tableSpinnerHidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self reloadMyDataSourceWithRecordFromUI:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -
#pragma mark Notification

- (void)addGlobalNotification {
    [super addGlobalNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photoUploadSuccess:) name:kNotification_Photos_Upload_Success object:nil];
}

- (void)photoUploadSuccess:(NSNotification *)notification {
    [self checkUserInfo];
}

#pragma mark -
#pragma mark CheckInfo

- (void)checkUserInfo {
    __weak __typeof(self) weakSelf = self;
    [[KKLauncher getInstance] checkUserInfoWithSuccessBlock:^(id responseObject, NSDictionary *headers, id requestModel) {
        weakSelf.uploadImageShowCellItem.rawObject = [KKUserInfoItem sharedItem].personItem.authImageItem;
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.refreshControl endRefreshing];
        
    } failBlock:^(NSError *error, NSDictionary *headers, id requestModel) {
        [weakSelf.tableView.refreshControl endRefreshing];
    }];
}

#pragma mark -
#pragma mark Navigation Bar

- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    [self setNaviTitle:_(@"申请成为合作伙伴")];
}

- (void)setupRawItemFromUI {
    KKModifyTextFieldCell *textFieldCell = nil;
    textFieldCell = (KKModifyTextFieldCell *)[self.tableView cellForCellItem:self.nameModifyCellItem];
    self.nameModifyTextField = textFieldCell.textField;
    
}

- (void)reloadMyDataSourceWithRecordFromUI:(BOOL)recordFromUi {
    if (recordFromUi) {
        [self setupRawItemFromUI];
    }

    self.uploadImageShowCellItem.rawObject = [KKUserInfoItem sharedItem].personItem.authImageItem;
    
    NSMutableArray *cellItemArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    [cellItemArray addSafeObject:[YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_HeightS title:nil]];

    NSString *authTitle = @"";
    NSString *uploadTitle = @"";
    authTitle =  @"请上传公司营业执照";
    uploadTitle = @"上传";
    
    KKTagGroupHeaderCellItem *groupHeaderCellItem3 = [[KKTagGroupHeaderCellItem alloc] initWithTagName:authTitle buttonName:uploadTitle];
    groupHeaderCellItem3.rawObject = kApplyForAgent_KeyUploadPhoto;
    [cellItemArray addSafeObject:groupHeaderCellItem3];
    
    [cellItemArray addSafeObject:self.uploadImageShowCellItem];
    
    if ([KKUserInfoItem sharedItem].personItem.role == KKPersonRoleTypeNormal && [KKUserInfoItem sharedItem].personItem.authImageItem !=nil) {
        //  Placeholder
        [cellItemArray addSafeObject:[YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_HeightS title:nil]];
        [cellItemArray addSafeObject:self.applyForAgentCellItem];
    }
    


    
    [self.dataSource addCellItems:cellItemArray];
}

#pragma mark -
#pragma mark TableView

- (void)cellDidSelectWithTableView:(UITableView *)tableView cellItem:(DDBaseCellItem *)cellItem cell:(DDBaseCell *)cell didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super cellDidSelectWithTableView:tableView cellItem:cellItem cell:cell didSelectRowAtIndexPath:indexPath];
    
    if (cellItem == self.uploadImageShowCellItem) {
        KKSingleBigImageCell *cell = (KKSingleBigImageCell *)[self.tableView cellForCellItem:self.uploadImageShowCellItem];
        if (cell && [cell isKindOfClass:[KKSingleBigImageCell class]]) {
            CGRect startFrame = [cell.avatarImageView convertRect:cell.avatarImageView.frame toView:[AppDelegate sharedAppDelegate].window];
            startFrame.origin.x = ([UIDevice screenWidth] - startFrame.size.width)/2;
            CGRect endFrame = [AppDelegate sharedAppDelegate].window.bounds;
            
            [[DDImageViewer getInstance] viewFullScreenImageWithImageUrl:[KKUserInfoItem sharedItem].personItem.authImageItem.urlMiddle placeHolderImage:cell.avatarImageView.image startFrame:startFrame endFrame:endFrame animated:YES];
        }
    }
}


#pragma mark -
#pragma mark KKTagGroupHeaderCellDelegate

- (void)kkTagGroupHeaderRightButtonPressedWithInfo:(NSDictionary *)dict {
    KKTagGroupHeaderCellItem *cellItem = [dict objectForSafeKey:kDDTableView_Action_Key_CellItem];
    if ([cellItem isKindOfClass:[KKTagGroupHeaderCellItem class]]) {
        NSLog(@"is KKTagGroupHeaderCellItem class");
        NSString *cellTag = cellItem.rawObject;
        if (cellTag && [cellTag isKindOfClass:[NSString class]]) {
            NSLog(@"cellTag:%@",cellTag);
            if ([cellTag isEqualToString:kApplyForAgent_KeyUploadPhoto]) {
                [[KKPhotoUploadManager getInstance] uploadPhotoWithType:KKUploadPhotoType_partner entityId:[KKUserInfoItem sharedItem].personItem.kkId withMaxCount:1];
            }
        }
    }
}



@end





