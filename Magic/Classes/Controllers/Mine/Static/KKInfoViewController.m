//
//  KKInfoViewController.m
//  Magic
//
//  Created by lixiang on 15/6/21.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKInfoViewController.h"

#import "DDPageControl.h"
#import "PhotoGalleryViewController.h"

#define kInfoVc_ImageView_Relative_Height          (140)

@interface KKInfoViewController ()<YYPhotoGalleryViewControllerDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UILabel *infoLabel;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DDPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *imageViewArray;

@end

@implementation KKInfoViewController

#pragma mark -
#pragma mark Init

- (void)initSettings {
    [super initSettings];
    
    self.tableSpinnerHidden = YES;
}

#pragma mark -
#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.mainScrollView.contentSize = CGSizeMake([UIDevice screenWidth], 800);
    
    [self.view addSubview:self.mainScrollView];
    
    [self setupImageArray];
    [self setupViews];
    [self setupInfoLabel];
    
    if (self.tableView) {
        [self.tableView removeFromSuperview];
        self.tableView = nil;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupImageArray {
    self.imageViewArray = [NSMutableArray array];
//    UIImage *image = [UIImage imageNamed:@"info1.jpg"];
//    
//    [self.imageViewArray addSafeObject:image];
//    
//    [self.imageViewArray addSafeObject:image];
//    
    for (int i = 1; i <=4; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"info%d.jpg",i]];
        [self.imageViewArray addSafeObject:image];
    }
}

- (void)setupViews{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIDevice screenWidth], kInfoVc_ImageView_Relative_Height * [UIDevice screenWidth] / 320)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.autoresizesSubviews = YES;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    
    CGFloat imageView_width = [UIDevice screenWidth];
    
    UIImageView *oneImageView = nil;
    for (int i = 0; i < self.imageViewArray.count; i ++) {
        oneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*imageView_width, 0, imageView_width, self.scrollView.height)];
        oneImageView.contentMode = UIViewContentModeScaleAspectFill;
        oneImageView.tag = i;
        [oneImageView addTarget:self tapAction:@selector(imagePressed:)];
        
        UIImage *image = [self.imageViewArray objectAtSafeIndex:i];
        if (image && [image isKindOfClass:[UIImage class]]) {
            oneImageView.image = image;
        }
        
        [self.scrollView addSubview:oneImageView];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * self.imageViewArray.count, self.scrollView.height);
    
    //  PageControl
    self.pageControl = [[DDPageControl alloc] initWithFrame:CGRectMake(0, self.scrollView.height - 20, self.scrollView.width, 10) type:DDPageControlTypeBlack];
    self.pageControl.pageIndicatorImage = [UIImage imageNamed:@"kb_control_pot_light"];
    self.pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"kb_control_pot_dark_blue"];
    self.pageControl.numberOfPages = self.imageViewArray.count;

    
    [self.mainScrollView addSubview:self.scrollView];
    [self.mainScrollView addSubview:self.pageControl];
}

- (void)setupInfoLabel {
    self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.scrollView.bottom + 10, [UIDevice screenWidth] - 30, 600)];
    [self.infoLabel setThemeUIType:kThemeBasicLabel_MiddleGray14];
    self.infoLabel.textAlignment = NSTextAlignmentLeft;
    self.infoLabel.numberOfLines = 0;
    
    NSString *infoStr = @"    中理通成立于1998年，是经国家知识产权局和国家工商行政管理总局首批认可和批准的，具有国内外商标、版权、专利代理资格以及律师服务的一站式全产业链知识产权服务机构。17年来，中理通凭借“中正仁和、理达天下、通圆九州”的经营理念和“专业、诚信、敬业、尽职”的执业态度迅速发展壮大，连续多年商标申请量位居全国领先地位，并为多家大型企、事业单位提供常年法律顾问的服务，享有良好的社会声誉，已成为中国领先的大型的综合性知识产权服务机构。 \n\n一体化服务\n    无论是小到一件商标申请或是大到诉讼维权，中理通都会根据行业或技术领域，将事务分配至专业最接近、经验最丰富的团队依照中理通合规流程进行一体化办理，保证专业高效。 \n\n专业的团队\n    中理通律师团队成员主要毕业于北大、人大、中国政法等法学名校，拥有在商标、版权等知识产权领域的多年丰富执业经验。所内亦聘请了曾供职于国家工商行政管理总局商标局、国家知识产权局、北京大学知识产权学院的多名离退休专家作为长期顾问，致力于为客户提供最为权威的专业知识产权法律指导。 \n\n丰富的经验\n    基于在知识产权领域17年的深耕和超过18万客户的服务经验，我们擅长以法律和技术的专业知识解决知识产权中的复杂问题，为客户提供创意、可靠、经济和漂亮的解决方案。 \n\n贴心的伙伴\n    选择中理通，就是为企业选择了值得信赖的知识产权伙伴。伴随着企业的发展壮大，可靠的律师团队会针对不同阶段企业面临知识产权困境进行有针对性的会诊服务，为企业提供标本兼治，后顾无忧的知产规划预案。 \n\n与时俱进的服务\n    中理通依托移动互联技术整合知识产权，为客户免费提供手机端和网页端的知产业务软件，让您真正做到对知识产权最新动态，法律法规和自身知产情况了如指掌。 \n\n大规模优势\n    与国家商标局不到百米的地理位置、和官方良好的沟通关系以及庞大的业务量是中理通向国内外广大客户承诺诚信、快捷和超值知识产权服务的有力保障。我司目前已实现年均申请量超两万件。\n";
    
    CGFloat infoHeight = [infoStr heightWithFont:[UIFont systemFontOfSize:14] constrainedWidth:([UIDevice screenWidth] - 30)];
    self.infoLabel.height = infoHeight;
    
    self.mainScrollView.contentSize = CGSizeMake([UIDevice screenWidth], self.scrollView.height + 10 + infoHeight + 80);
    
    self.infoLabel.text = infoStr;
    
    [self.mainScrollView addSubview:self.infoLabel];
}

#pragma mark -
#pragma mark Navigation Bar
- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    [self setNaviTitle:_(@"中理通简介")];
    
}

#pragma mark -
#pragma mark Actions

- (void)imagePressed:(UITapGestureRecognizer *)gesture {
    UIImageView *imageView = (UIImageView *)gesture.view;
    if (![imageView isKindOfClass:[UIImageView class]]) {
        return;
    }
    
    PhotoGalleryViewController *galleryViewController = [[PhotoGalleryViewController alloc] initWithPhotoSource:self initialIndex:imageView.tag];
    galleryViewController.isLocalUIImages = YES;
    galleryViewController.localUIImageArray = self.imageViewArray;
    [self presentViewController:galleryViewController animated:YES completion:nil];
}

#pragma mark -
#pragma mark YYPhotoGalleryViewControllerDelegate

- (NSUInteger)numberOfPhotosForPhotoGallery:(PhotoGalleryViewController *)gallery {
    return self.imageViewArray.count;
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = (scrollView.contentOffset.x + [UIDevice screenWidth]/2) / [UIDevice screenWidth];
    self.pageControl.currentPage = currentPage;
}

@end
