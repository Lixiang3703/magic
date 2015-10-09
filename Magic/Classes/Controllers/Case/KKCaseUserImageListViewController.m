//
//  KKCaseUserImageListViewController.m
//  Magic
//
//  Created by lixiang on 15/6/4.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseUserImageListViewController.h"
#import "KKDoubleImageCellItem.h"
#import "KKDoubleImageCell.h"
#import "YYGroupHeaderCellItem.h"
#import "YYGroupHeaderCell.h"

#import "KKImageItem.h"
#import "KKPhotoUploadManager.h"
#import "KKPhotoBigShowManager.h"
#import "KKCaseUserImageListRequestModel.h"
#import "KKPhotoDeleteRequestModel.h"
#import "PhotoScrollingViewController.h"

@interface KKCaseUserImageListViewController ()
@property (nonatomic, strong) KKCaseUserImageListRequestModel *listRequestModel;

@end

@implementation KKCaseUserImageListViewController

#pragma mark -
#pragma mark accessor

- (KKCaseUserImageListRequestModel *)listRequestModel {
    if (_listRequestModel == nil) {
        _listRequestModel = [[KKCaseUserImageListRequestModel alloc] init];
    }
    return _listRequestModel;
}

#pragma mark -
#pragma mark life cycle

- (void)initSettings {
    [super initSettings];
    
    self.tableSpinnerHidden = YES;
    self.requestModel = self.listRequestModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (instancetype)initWithCaseId:(NSInteger)caseId {
    self = [self init];
    if (self) {
        self.caseId = caseId;
        self.listRequestModel.caseId = self.caseId;
    }
    return self;
}

#pragma mark -
#pragma mark Navigation Bar

- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    [self setNaviTitle:_(@"申请文件列表")];
    [self setRightBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:_(@"上传") target:self action:@selector(rightBarButtonItemClick:)] animated:animated];
}

#pragma mark -
#pragma mark Navi actions

- (void)rightBarButtonItemClick:(id)sender {
    [[KKPhotoUploadManager getInstance] uploadPhotoWithType:KKUploadPhotoType_caseUserImage entityId:self.caseId withMaxCount:5];
}

@end



