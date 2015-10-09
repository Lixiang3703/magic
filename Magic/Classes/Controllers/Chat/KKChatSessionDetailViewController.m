//
//  KKChatSessionDetailViewController.m
//  Magic
//
//  Created by lixiang on 15/4/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKChatSessionDetailViewController.h"

#import "KKChatCellItem.h"
#import "KKChatImageCell.h"
#import "KKUserInfoItem.h"
#import "KKLocalUserStuffItem.h"

#import "AFNetworkReachabilityManager.h"
#import "WSManager.h"
#import "KKAccountItem.h"

#import "KKChatSessionCheckRequestModel.h"

#import "KKChatTextToolBar.h"
#import "KKChatTextRequestModel.h"
#import "KKChatImageRequestModel.h"

#import "DDTActionSheet.h"
#import "UIAlertView+Blocks.h"
#import "DDImageViewer.h"
#import "AppDelegate.h"


#define kNeedPlaceHolderChatItemCounts              (7)

#define kChatLatestRequestModelInterval                    (7)

@interface KKChatSessionDetailViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,KKChatImageCellActions>

@property (nonatomic, assign) CGPoint startPoint;

@property (nonatomic, strong) KKPersonItem *personItem;
@property (nonatomic, strong) KKChatSessionCheckRequestModel *sessionCheckRequestModel;

@property (nonatomic, strong) KKChatTextToolBar *toolbar;

@end

@implementation KKChatSessionDetailViewController


#pragma mark -
#pragma mark Accessor

- (KKChatSessionCheckRequestModel *)sessionCheckRequestModel {
    if (_sessionCheckRequestModel == nil) {
        _sessionCheckRequestModel = [[KKChatSessionCheckRequestModel alloc] init];
    }
    return _sessionCheckRequestModel;
}

- (KKChatListRequestModel *)chatListRequestModel {
    if (_chatListRequestModel == nil) {
        _chatListRequestModel = [[KKChatListRequestModel alloc] init];
    }
    return _chatListRequestModel;
}

- (KKChatSessionLatestDetailsRequestModel *)latestMsgRequestModel {
    if (_latestMsgRequestModel == nil) {
        _latestMsgRequestModel = [[KKChatSessionLatestDetailsRequestModel alloc] init];
    }
    return _latestMsgRequestModel;
}

- (NSString *)sessionId {
    if (_chatSessionItem) {
        return _chatSessionItem.sessionId;
    }
    return @"";
}

#pragma mark -
#pragma mark Initialization

- (instancetype)initWithChatSessionItem:(KKChatSessionItem *)chatSessionItem {
    self = [super init];
    if (self) {
        self.chatSessionItem = chatSessionItem;
        self.personItem = self.chatSessionItem.toUserItem;
    }
    return self;
}

- (instancetype)initWithPersonItem:(KKPersonItem *)personItem {
    self = [super init];
    if (self) {
        self.personItem = personItem;
    }
    return self;
}

- (void)initSettings {
    [super initSettings];
    
    self.loadingMoreUp = YES;
    self.chatItemIds = [NSMutableSet set];
    
    self.tableSpinnerHidden = NO;
    
}
#pragma mark -
#pragma mark Notifications

- (void)addGlobalNotification {
    [super addGlobalNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chatPushReceived:) name:kLinkNotification_Chat_Push_Recieved object:nil];
}

- (void)addViewAppearNotification {
    [super addViewAppearNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleWillEnterForegroundNotification:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDidEnterBackgroundNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)removeViewAppearNotification {
    [super removeViewAppearNotification];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLinkNotification_ChatItem_Push_Recieved object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
}

#pragma mark -
#pragma mark Handle Notification

- (void)chatPushReceived:(NSNotification *)notification {
    [self reloadLatestMessages];
}

- (void)handleWillEnterForegroundNotification:(NSNotification *)notification {
    [self reloadLatestMessages];
}

- (void)handleDidEnterBackgroundNotification:(NSNotification *)notification {
    [self.latestMsgRequestModel cancel];
}

#pragma mark -
#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    
    self.requestModel = self.chatListRequestModel;

    // TODO: XXX
    if (self.chatSessionItem && self.chatSessionItem.sessionId) {
        self.chatListRequestModel.sessionId = self.chatSessionItem.sessionId;
        [self.chatListRequestModel load];
    }
    else {
        [self checkSesstionStatus];
    }
    
    
    [self setupToolBar];
    self.toolbar.bottom = self.view.bottom - ([UIDevice below7] ? kUI_TableView_Group_Header_Height : 0);
    self.tableView.height -= kUI_Compose_Toolbar_Height_Default;
    [self.view addSubview:self.toolbar];
    
    [self setupLatestRequestModel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.viewDidAppear && [UIDevice below7]) {
        self.toolbar.bottom = self.view.bottom;
    }
    
    if ([UIDevice isInCallStatusBar]) {
        self.toolbar.bottom -= 20;
    }
    
    if (!self.viewDidAppear) {
        [self.requestModel load];
        [self setupLatestRequestModel];
        [self reloadLatestMessages];
    }
    
    
    //    if (self.viewDidAppear) {
    //        [self reloadLatestMessages];
    //    }
    
    
    [[WSManager getInstance] networkIndicatorEnabled:NO];
}


- (void)viewWillDisappear:(BOOL)animated {
    [UIAlertView HUDAlertDismiss];
    
    [super viewWillDisappear:animated];
    
    [[WSManager getInstance] networkIndicatorDecrementActivityCount];
    [[WSManager getInstance] networkIndicatorEnabled:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupLatestRequestModel {
    
    __weak __typeof(self) weakSelf = self;
    
    //    self.latestMsgRequestModel.timeoutInterval = 5;
    self.latestMsgRequestModel.sessionId = self.sessionId;
    self.latestMsgRequestModel.successBlock = ^(id responseObject, NSDictionary *headers, KKChatSessionLatestDetailsRequestModel *requestModel) {
        
        NSLog(@"latestMsgRequestModel. success");
        
        [weakSelf insertLatestPMsWithRequestModel:requestModel];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kChatLatestRequestModelInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf reloadLatestMessages];
        });
    };
    self.latestMsgRequestModel.failBlock = ^(NSError *error, NSDictionary *headers, KKChatSessionLatestDetailsRequestModel *requestModel) {
        
        NSLog(@"latestMsgRequestModel. failure");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kChatLatestRequestModelInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf reloadLatestMessages];
        });
        
        //        if ([AFNetworkReachabilityManager sharedManager].isReachable && (error.code == kWS_ErrorCode_RequestTimeoutError || requestModel.metaItem.code == 40034)) {
        //            [weakSelf reloadLatestMessages];
        //        } else {
        //
        //        }
    };
}

- (void)setupToolBar {
    __weak typeof(self)weakSelf = self;
    
    self.toolbar = [[KKChatTextToolBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kUI_Compose_Toolbar_Height_Default)];
    [self.toolbar.imageButton addTarget:self action:@selector(toolbarImageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    self.toolbar.textView.placeholder = @"say...";
    
    self.toolbar.growingTextViewShouldReturnOperation = ^{
        [weakSelf sendPMButtonPressed:weakSelf.toolbar];
    };
    
    self.toolbar.keyboardWillShowOperation = ^{
        if ([weakSelf.dataSource cellItemsCount] < kNeedPlaceHolderChatItemCounts) {
            weakSelf.toolbar.adjustTableViewHeightForKeyboard = YES;
        }
        else {
            weakSelf.toolbar.adjustTableViewHeightForKeyboard = NO;
        }
    };
    
    self.toolbar.keyboardWillShowAnimationOperation = ^ {
        [weakSelf.tableView scrollToLastCellAnimated:NO];
    };
    
    self.toolbar.keyboardWillShowCompletionOperation = ^ {
        
    };
    self.toolbar.keyboardWillHideCompletionOperation = ^ {
        
    };
}


#pragma mark -
#pragma mark RequestModel Handler Templates

- (Class)cellItemClass {
    return [KKChatCellItem class];
}

- (BOOL)tableViewShouldLoadRequestWhenWillAppearRequestModel:(YYBaseRequestModel *)requestModel {
    return NO;
}

- (void)updateSuccessTableViewWithReqeustModel:(YYBaseRequestModel *)requestModel {
    [super updateSuccessTableViewWithReqeustModel:requestModel];
    
    if (!requestModel.didUseLocalData && !requestModel.isLoadingMore) {
        //        [self reloadLatestMessages];
    }
}

- (BOOL)cellItemShouldAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItem:(DDBaseCellItem *)cellItem {
    if (!requestModel.didUseLocalData) {
        KKChatItem *rawItem = cellItem.rawObject;
        if ([self.chatItemIds containsObject:@(rawItem.kkId)]) {
            return NO;
        }
    }
    return [super cellItemShouldAddWithRequestModel:requestModel cellItem:cellItem];
}

- (void)cellItemDidAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItem:(KKChatCellItem *)cellItem cellItems:(NSMutableArray *)cellItems {
    [super cellItemDidAddWithRequestModel:requestModel cellItem:cellItem cellItems:cellItems];
    
    KKChatItem *rawItem = cellItem.rawObject;
    
    if (!requestModel.didUseLocalData) {
        [self.chatItemIds addSafeObject:rawItem.ddId];
    }
    
    if (!requestModel.didUseLocalData && !requestModel.isLoadingMore && [cellItems count] == 1) {
        self.chatSessionItem.latestChatMsgItem = rawItem;
        [self updateChatSessionItemWithChatItem:rawItem];
    }
    
}

- (void)cellItemsWillAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItems:(NSMutableArray *)cellItems {
    [super cellItemsWillAddWithRequestModel:requestModel cellItems:cellItems];
    
    //  Set latest Cursor
    if (!requestModel.isLoadingMore && !requestModel.didUseLocalData) {
        KKChatCellItem *firstCellItem = [cellItems firstObject];
        KKChatItem *firstPMItem = firstCellItem.rawObject;
        
        self.latestMsgRequestModel.latestMsgId = firstPMItem.kkId;
        [self reloadLatestMessages];
    }
    
    [cellItems reverse];
    
    if (!requestModel.isLoadingMore) {
        //  如果是加载更多的时候，首先更新上一个Cellitems中的最后一个元素
        KKChatCellItem *lastPMCellItem = [self.dataSource firstCellItemForClass:[KKChatCellItem class]];
        lastPMCellItem.lastCreateTime = [(KKChatItem *)[[cellItems lastObject] rawObject] insertTimestamp];
    }
    
    //  比较新的一条私信持有少久一点的私信的createTime， 此次遍历 为由旧到新的遍历
    __block NSTimeInterval lastCreateTime = 0;
    
    [cellItems enumerateObjectsUsingBlock:^(KKChatCellItem *obj, NSUInteger idx, BOOL *stop) {
        obj.lastCreateTime = lastCreateTime;
        [obj updateItemForLastCreateTime];
        KKChatItem *rawItem = obj.rawObject;
        lastCreateTime = rawItem.insertTimestamp;
    }];
}

- (void)cellItemsDidAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItems:(NSMutableArray *)cellItems {
    [super cellItemsDidAddWithRequestModel:requestModel cellItems:cellItems];
    
    //  Insert failed CellItems
    if (!requestModel.isLoadingMore) {
        NSArray *failedChatItems = [[KKLocalUserStuffItem sharedItem] failChatItemsWithSessionId:self.sessionId];
        KKChatCellItem *cellItem = nil;
        for (KKChatItem *chatItem in failedChatItems) {
            cellItem = [[KKChatCellItem alloc] initWithRawItem:chatItem];
            cellItem.loading = NO;
            [self.dataSource addCellItem:cellItem];
        }
    }
}


#pragma mark -
#pragma mark Buttons

- (void)toolbarImageButtonPressed:(UIButton *)button {
    //    [self.toolbar resignFirstResponder];
    
    [self.toolbar.textView resignFirstResponder];
    
    [self selectPhotoByActionsheet];
}


- (void)sendPMButtonPressed:(id)sender {
    
    NSString *content = [self.toolbar.textView.text trim];
    
    if (![content hasContent]) {
        [UIAlertView postAlertWithMessage:@"请输入聊天内容"];
        return;
    }
    
    [self postPMWithText:content];
    
}

#pragma mark -
#pragma mark PM
- (void)postPMWithText:(NSString *)text {
    self.toolbar.textView.text = nil;
    
    [self postPMWithChatItem:[self fakeChatItemWithText:text image:nil] cellItem:nil resendWhenFailed:NO];
}

- (void)postPMWithImage:(UIImage *)image {
    [self postPMWithChatItem:[self fakeChatItemWithText:nil image:image] cellItem:nil resendWhenFailed:NO];
}

- (KKChatItem *)fakeChatItemWithText:(NSString *)text image:(UIImage *)image{
    if (text == nil && image == nil) {
        return nil;
    }
    
    KKChatItem *chatItem = [[KKChatItem alloc] init];
    chatItem.fake = YES;
    chatItem.mine = DDBaseItemBoolTrue;
    chatItem.insertTimestamp = [[NSDate date] timeStamp];
    chatItem.userItem = [KKUserInfoItem sharedItem].personItem;
    
    if (nil != text) {
        chatItem.type = KKChatTypeText;
        chatItem.content = text;
    }
    
    if (nil != image) {
        chatItem.type = KKChatTypeImage;
        chatItem.originalImage = image;
        chatItem.fakeImage = [image reSize:[KKImageItem imageSizeWithWidth:image.size.width height:image.size.height maxSide:kUI_PM_Image_Side_Max]];
    }
    
    return chatItem;
}

- (void)postPMWithChatItem:(KKChatItem *)chatItem cellItem:(KKChatCellItem *)theCellItem resendWhenFailed:(BOOL)resendWhenFailed {
    __block KKChatCellItem *cellItem = theCellItem;
    
    chatItem.fake = YES;
    
    if (nil == theCellItem) {
        cellItem = [[KKChatCellItem alloc] initWithRawItem:chatItem];
        cellItem.loading = YES;
    } else {
        //  Reload If exists
        [self.tableView reloadData];
    }
    
    if (KKChatTypeUnknown == chatItem.type) {
        return;
    }
    
    NSString *sessionId = self.chatSessionItem.sessionId;
    
    __weak typeof(self)weakSelf = self;
    
    //    KKChatTextRequestModel *chatInsertRequestModel = [[KKChatTextRequestModel alloc] init];
    
    KKBaseChatPostRequestModel *chatInsertRequestModel = [self chatRequestModelWithChatItem:chatItem];
    
    chatInsertRequestModel.sessionId = self.chatSessionItem.sessionId;
    
    chatInsertRequestModel.successBlock = ^(id responseObject, NSDictionary *headers, KKChatTextRequestModel *requestModel) {
        //        [UIAlertView postAlertWithMessage:@"send success"];
        
        KKChatItem *newChatItem = requestModel.resultItem;
        newChatItem.mine = DDBaseItemBoolTrue;
        cellItem.loading = NO;
        cellItem.rawObject = requestModel.resultItem;
        [cellItem updateItemForLastCreateTime];
        
        [weakSelf.chatItemIds addSafeObject:@(newChatItem.kkId)];
        
        [weakSelf.tableView reloadData];
        [weakSelf.tableView scrollToLastCellAnimated:YES];
        
        weakSelf.chatSessionItem.latestChatMsgItem = newChatItem;
        weakSelf.latestMsgRequestModel.latestMsgId = newChatItem.kkId;
        
        [weakSelf updateChatSessionItemWithChatItem:newChatItem];
        
        if (resendWhenFailed) {
            [[KKLocalUserStuffItem sharedItem] failChatRemoveChatItem:chatItem sessionId:sessionId];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kLinkNotification_ChatItem_Modified object:nil userInfo:nil];
    };
    
    chatInsertRequestModel.failBlock = ^(NSError *error, NSDictionary *headers, id requestModel) {
        [UIAlertView postAlertWithMessage:@"send failure"];
        
        cellItem.loading = NO;
        
        [weakSelf.tableView reloadData];
        
        if (error.isFatalError) {
            //  致命错误删除缓存信息
            if (resendWhenFailed) {
                [[KKLocalUserStuffItem sharedItem] failChatRemoveChatItem:chatItem sessionId:sessionId];
            } else {
                [weakSelf.dataSource removeCellItem:cellItem];
                [weakSelf.tableView reloadData];
            }
        } else {
            //  非致命错误的时候，才帮用户缓存住评论信息
            if (!resendWhenFailed) {
                //  Add Failed Request to LocalUserStuff
                [[KKLocalUserStuffItem sharedItem] failChatAddChatItem:chatItem sessionId:sessionId];
            }
        }
    };
    
    if (resendWhenFailed) {
        [chatInsertRequestModel load];
    }
    else {
        [self.dataSource trimExcept:[DDMoreCellItem class]];
        [self.tableView reloadData];
        
        NSMutableArray *cellItems = [NSMutableArray arrayWithCapacity:2];
        
        DDBaseCellItem *lastPMCellItem = [self.dataSource lastCellItem];
        if ([lastPMCellItem.rawObject isKindOfClass:[KKChatItem class]]) {
            KKChatItem *lastRawItem = lastPMCellItem.rawObject;
            cellItem.lastCreateTime = lastRawItem.insertTimestamp;
        }
        [cellItems addSafeObject:cellItem];
        
        [self appendCellItems:cellItems withRowAnimation:UITableViewRowAnimationNone completion:^{
            [weakSelf.tableView scrollToLastCellAnimated:YES];
            [weakSelf delayLoadImagesForOnscreenRows];
            [chatInsertRequestModel load];
        }];
        
    }
}

- (KKBaseChatPostRequestModel *)chatRequestModelWithChatItem:(KKChatItem *)chatItem {
    KKBaseChatPostRequestModel *requestModel = nil;
    switch (chatItem.type) {
        case KKChatTypeText:
        {
            KKChatTextRequestModel *aRequestModel = [[KKChatTextRequestModel alloc] init];
            aRequestModel.content = chatItem.content;
            requestModel = aRequestModel;
        }
            break;
        case KKChatTypeImage:
        {
            KKChatImageRequestModel *aRequestModel = [[KKChatImageRequestModel alloc] init];
            aRequestModel.image = chatItem.originalImage;
            requestModel = aRequestModel;
        }
            break;
        default:
            break;
    }
    return requestModel;
}

- (void)updateChatSessionItemWithChatItem:(KKChatItem *)chatItem {
    
}

#pragma mark -
#pragma mark Naivigation Bar
- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    
    [self setNaviTitle:@"客服留言"];
    
//    if (self.personItem) {
//        [self setNaviTitle:self.personItem.name];
//    }
    
    [self setRightBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:_(@"收取") target:self action:@selector(rightBarButtonItemClick:)] animated:animated];
}

#pragma mark -
#pragma mark DataSrouce
- (void)generateDataSource {
    [super generateDataSource];
    
    //    [self insertDefaultCellItems];
}


- (void)insertDefaultCellItems {
    NSMutableArray *cellItemsArray = [NSMutableArray array];
    
    for (int i = 0; i < 9; i ++) {
        KKChatCellItem *cellItem = [[KKChatCellItem alloc] init];
        
        KKChatItem *chatItem = [[KKChatItem alloc] init];
        chatItem.userItem = [KKUserInfoItem sharedItem].personItem;
        chatItem.type = KKChatTypeText;
        chatItem.content = [NSString stringWithFormat:@"%d,All the hurt, all the lies.",i];
        chatItem.mine = (i%2 == 0) ? DDBaseItemBoolTrue : DDBaseItemBoolFalse;
        
        cellItem.rawObject = chatItem;
        [cellItemsArray addSafeObject:cellItem];
    }
    [self.dataSource addCellItems:cellItemsArray];
}

#pragma mark -
#pragma mark NavigationBar actions

- (void)rightBarButtonItemClick:(id)sender {
    //    [self setupLatestRequestModel];
    [self reloadLatestMessages];
}

#pragma mark -
#pragma mark Timmer

- (void)reloadLatestMessages {
    if (self.latestMsgRequestModel.latestMsgId <= 0) {
        return;
    }
    [self.latestMsgRequestModel load];
}

- (void)insertLatestPMsWithRequestModel:(YYBaseRequestModel *)requestModel {
    if (0 == [requestModel.resultItems count]) {
        return;
    }
    
    NSMutableArray *cellItems = [self generateCellItemsWithReqeustModel:requestModel resultItems:requestModel.resultItems];
    
    //    [cellItems reverse];
    
    KKChatCellItem *lastChatCellItem = [self.dataSource lastCellItemForClass:[KKChatCellItem class]];
    __block NSTimeInterval lastCreateTime;
    //TODO:加保护，这里偶尔有Crash,尝试修复
    if ([lastChatCellItem isKindOfClass:[KKChatCellItem class]]) {
        lastCreateTime = [(KKChatItem *)[lastChatCellItem rawObject] insertTimestamp];
    }
    
    __block NSInteger newCursor = 0;
    __block KKChatItem *latestChatItem = nil;
    
    [cellItems enumerateObjectsUsingBlock:^(KKChatCellItem *obj, NSUInteger idx, BOOL *stop) {
        obj.lastCreateTime = lastCreateTime;
        KKChatItem *rawItem = obj.rawObject;
        lastCreateTime = rawItem.insertTimestamp;
        if (rawItem.mine != DDBaseItemBoolTrue && rawItem.userId != [KKAccountItem sharedItem].userId) {
            newCursor = rawItem.kkId;
            //            *stop = YES;
        }
        else {
            [cellItems removeObjectAtIndex:idx];
        }
        latestChatItem = rawItem;
    }];
    
    self.latestMsgRequestModel.latestMsgId = newCursor;
    
    if (nil != latestChatItem) {
        self.chatSessionItem.latestChatMsgItem = latestChatItem;
        [self updateChatSessionItemWithChatItem:latestChatItem];
    }
    
    if ([cellItems count] > 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kLinkNotification_ChatItem_Modified object:nil userInfo:nil];
        [self appendCellItems:cellItems withRowAnimation:UITableViewRowAnimationFade completion:^{
            [self.tableView scrollToLastCellAnimated:YES];
        }];
    }
}

#pragma mark -
#pragma mark Session

- (void)checkSesstionStatus {
    if ( !self.chatSessionItem && self.personItem) {
        self.sessionCheckRequestModel.toUserId = self.personItem.kkId;
        
        [UIAlertView postHUDAlertWithMessage:@"正在生成会话..."];
        
        __weak __typeof(self) weakSelf = self;
        self.sessionCheckRequestModel.successBlock = ^(id responseObject, NSDictionary *headers, KKChatSessionCheckRequestModel *requestModel) {
            [UIAlertView HUDAlertDismiss];
            KKChatSessionItem *sessionItem = requestModel.resultItem;
            if (sessionItem && [sessionItem isKindOfClass:[KKChatSessionItem class]] && sessionItem.sessionId && sessionItem.sessionId.length > 0) {
//                [UIAlertView postAlertWithMessage:@"生成会话成功"];
                weakSelf.chatSessionItem = sessionItem;
                weakSelf.chatListRequestModel.sessionId = weakSelf.chatSessionItem.sessionId;
                [weakSelf.chatListRequestModel load];
            }
            else {
                [UIAlertView postAlertWithMessage:@"生成会话失败"];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
            
        };
        
        self.sessionCheckRequestModel.failBlock = ^(NSError *error, NSDictionary *headers, KKChatSessionCheckRequestModel *requestModel) {
            [UIAlertView HUDAlertDismiss];
            [UIAlertView postAlertWithMessage:@"生成会话失败"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        
        [self.sessionCheckRequestModel load];
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [super scrollViewWillBeginDragging:scrollView];
    self.startPoint = scrollView.contentOffset;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    if (self.startPoint.y - scrollView.contentOffset.y > 70 || scrollView.contentOffset.y < -10) {
        [self.toolbar resignFirstResponder];
        [self.toolbar.textView resignFirstResponder];
        self.tableView.top = 0;
    }
}

#pragma mark -
#pragma mark Photos

- (void)selectPhotoByActionsheet{
    NSMutableArray *actionSheetItems = [[NSMutableArray alloc] init];
    DDTActionSheetItem *actionSheetItem = [[DDTActionSheetItem alloc] init];
    actionSheetItem.buttonTitle = _(@"相机");
    actionSheetItem.selector = @selector(selectPhotoFromCamera);
    [actionSheetItems addObject:actionSheetItem];
    actionSheetItem = nil;
    
    actionSheetItem = [[DDTActionSheetItem alloc] init];
    actionSheetItem.buttonTitle = _(@"从相册中选择");
    actionSheetItem.selector = @selector(selectPhotoFromAlbum);
    [actionSheetItems addObject:actionSheetItem];
    actionSheetItem = nil;
    
    [actionSheetItems addObject:[DDTActionSheetItem cancelActionSheetItem]];
    
    DDTActionSheet *actionSheet = [[DDTActionSheet alloc] initWithTitle:nil ActionSheetItems:actionSheetItems];
    actionSheet.lbDelegate = self;
    [actionSheet showInView:[UINavigationController appNavigationController].view];
}

- (void)selectPhotoFromAlbum {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.allowsEditing = NO;
    
    imagePicker.delegate = self;
    [[UINavigationController appNavigationController] presentViewController:imagePicker animated:YES completion:nil];
}

- (void)selectPhotoFromCamera {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing = NO;
    
    imagePicker.delegate = self;
    [[UINavigationController appNavigationController] presentViewController:imagePicker animated:YES completion:nil];
    
}

#pragma mark -
#pragma mark  UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    image = [image fixOrientation];
    
    [self postPMWithImage:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark KKChatImageCellActions

- (void)kkChatImageCellImagePressedWithInfo:(NSDictionary *)info {
    KKChatCellItem *cellItem = [info objectForKey:kDDTableView_Action_Key_CellItem];
    KKChatImageCell *cell = [info objectForKey:kDDTableView_Action_Key_Cell];
    
    KKChatItem *chatItem = cellItem.rawObject;
    
    if (chatItem.fake) {
        return;
    }
    
    
    CGRect startFrame = [cell.photoImageView convertRect:cell.photoImageView.frame toView:[AppDelegate sharedAppDelegate].window];
    CGRect endFrame = [AppDelegate sharedAppDelegate].window.bounds;
    
    [self resignToolbarFirstResponser];
    
    [[DDImageViewer getInstance] viewFullScreenImageWithImageUrl:chatItem.imageItem.urlMiddle placeHolderImage:cell.photoImageView.image startFrame:startFrame endFrame:endFrame animated:YES];
}

- (void)kkChatCellAvaterPressedWithInfo:(NSDictionary *)info {
    
}

- (void)kkChatCellLongPressedWithInfo:(NSDictionary *)info {
    
}

- (void)kkChatCellOperationButtonPressedWithInfo:(NSDictionary *)info {
    NSMutableArray *actionSheetItems = [[NSMutableArray alloc] initWithCapacity:3];
    DDTActionSheetItem *actionSheetItem = nil;
    
    actionSheetItem = [[DDTActionSheetItem alloc] init];
    actionSheetItem.buttonTitle = _(@"重新发送");
    actionSheetItem.selector = @selector(resendFailPM:);
    actionSheetItem.userInfo = info;
    [actionSheetItems addObject:actionSheetItem];
    actionSheetItem = nil;
    
    actionSheetItem = [[DDTActionSheetItem alloc] init];
    actionSheetItem.buttonTitle = _(@"删除");
    actionSheetItem.selector = @selector(deleteFailPM:);
    actionSheetItem.userInfo = info;
    [actionSheetItems addObject:actionSheetItem];
    actionSheetItem = nil;
    
    [actionSheetItems addObject:[DDTActionSheetItem cancelActionSheetItem]];
    
    DDTActionSheet *actionSheet = [[DDTActionSheet alloc] initWithTitle:nil ActionSheetItems:actionSheetItems];
    
    actionSheet.lbDelegate = self;
    [actionSheet showInView:self.navigationController.view];
}

#pragma mark -
#pragma mark sendFail Actions

- (void)resendFailPM:(NSDictionary *)info{
    KKChatCellItem *cellItem = [info objectForKey:kDDTableView_Action_Key_CellItem];
    KKChatItem *rawItem = cellItem.rawObject;
    cellItem.loading = YES;
    
    [self postPMWithChatItem:rawItem cellItem:cellItem resendWhenFailed:YES];
}

- (void)deleteFailPM:(NSDictionary *)info {
    KKChatCellItem *cellItem = [info objectForKey:kDDTableView_Action_Key_CellItem];
    NSIndexPath *indexPath = [info objectForKey:kDDTableView_Action_Key_IndexPath];
    [self deleteCellItem:cellItem atIndexPath:indexPath withRowAnimation:UITableViewRowAnimationFade completion:^{
        [self.dataSource trim];
        
        if ([self.dataSource isEmpty]) {
            [self.dataSource addCellItem:[self theEmptyCellItemWithCorrectCellHeight]];
        }
        
        [self.tableView reloadData];
    }];
    
    [[KKLocalUserStuffItem sharedItem] failChatRemoveChatItem:cellItem.rawObject sessionId:self.chatSessionItem.sessionId];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLinkNotification_ChatItem_Modified object:nil userInfo:nil];
}

#pragma mark -
#pragma mark Sub methods

- (void)resignToolbarFirstResponser {
    [self.toolbar.textView resignFirstResponder];
}


@end
