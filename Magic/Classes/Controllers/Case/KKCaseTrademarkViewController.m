//
//  KKCaseTrademarkViewController.m
//  Magic
//
//  Created by lixiang on 15/6/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseTrademarkViewController.h"
#import "KKCaseTrademarkListRequestModel.h"

@interface KKCaseTrademarkViewController ()

@property (nonatomic, strong) KKCaseTrademarkListRequestModel *listRequestModel;

@end

@implementation KKCaseTrademarkViewController

#pragma mark -
#pragma mark accessor

- (KKCaseTrademarkListRequestModel *)listRequestModel {
    if (_listRequestModel == nil) {
        _listRequestModel = [[KKCaseTrademarkListRequestModel alloc] init];
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
    [self setNaviTitle:_(@"商标列表")];
    [self setRightBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:_(@"上传") target:self action:@selector(rightBarButtonItemClick:)] animated:animated];
}

#pragma mark -
#pragma mark Navi actions

- (void)rightBarButtonItemClick:(id)sender {
    [[KKPhotoUploadManager getInstance] uploadPhotoWithType:KKUploadPhotoType_trademark entityId:self.caseId withMaxCount:5];
}
@end
