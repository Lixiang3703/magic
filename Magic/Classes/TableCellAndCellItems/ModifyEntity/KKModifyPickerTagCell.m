//
//  KKModifyPickerTagCell.m
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKModifyPickerTagCell.h"
#import "KKModifyPickerTagCellItem.h"

#import "KKPickerView.h"

@interface KKModifyPickerTagCell()

@property (nonatomic, strong) UILabel *tagNameLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *titleButton;

@property (nonatomic, strong) NSArray *pickerItemArray;

//@property (nonatomic, strong) KKPickerView *pickerView;

@end

@implementation KKModifyPickerTagCell

#pragma mark -
#pragma mark Accessor

#pragma mark -
#pragma mark lify cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.seperatorLine.left = 0;
        self.seperatorLine.width = self.width;
        
        //功能名
        self.tagNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kUI_Login_Common_MarginW, 12, kUI_PMSession_Date_Width, kUI_Login_Common_Margin)];
        self.tagNameLabel.textAlignment = NSTextAlignmentLeft;
        self.tagNameLabel.textColor = [UIColor lightGrayColor];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kUI_Login_Common_MarginW, 0, self.width - 2*kUI_Login_Common_MarginW, self.height)];
//        [self.titleLabel addTarget:self tapAction:@selector(titleLabelPressed:)];
        
//        self.titleButton = [[UIButton alloc] initWithFrame:CGRectMake(kUI_Login_Common_MarginW, 0, self.width - 2*kUI_Login_Common_MarginW, self.height)];
//        [self.titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        self.titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        self.titleButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

        [self.contentView addSubview:self.tagNameLabel];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}


- (void)setValuesWithCellItem:(YYBaseCellItem *)cellItem{
    [super setValuesWithCellItem:cellItem];
    
    KKModifyPickerTagCellItem *pickerCellItem = (KKModifyPickerTagCellItem *)cellItem;
    
    self.pickerItemArray = [pickerCellItem.pickerItemArray copy];
    
    self.titleLabel.text = pickerCellItem.titleName; 
//    self.titleButton.titleLabel.text = pickerCellItem.titleName;
    
    [self.titleButton setTitle:pickerCellItem.titleName forState:UIControlStateNormal];
    
    if ([[pickerCellItem.tagName trim] length]) {
        self.tagNameLabel.text = pickerCellItem.tagName;
        self.titleLabel.left = self.tagNameLabel.right + kUI_Login_Common_MarginS;
        self.titleLabel.width = self.width - self.titleLabel.left - kUI_Login_Common_MarginW;
        
//        self.titleButton.left = self.tagNameLabel.right + kUI_Login_Common_MarginS;
//        self.titleButton.width = self.width - self.titleButton.left - kUI_Login_Common_MarginW;
    }
    
}

#pragma mark -

- (void)titleLabelPressed:(id)sender {
    NSLog(@"titleLabelPressed.");
}


@end




