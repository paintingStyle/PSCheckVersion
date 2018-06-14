//
//  PSCheckVersionView.m
//  tyfocg
//
//  Created by paintingStyle on 2018/4/19.
//  Copyright © 2018年 com.worldTravelNetscape.tyfocg. All rights reserved.
//

#import "PSCheckVersionView.h"
#import "PSAppInfo.h"
#if __has_include(<Masonry.h>)
#import <Masonry.h>
#else
#import "Masonry.h"
#endif

#define kExplainLabelLayoutMaxWidth CGRectGetWidth(self.scrollView.frame)-1 -(15*2)
#define kRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@interface PSCheckVersionView()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *latestVersionLabel;

@property (nonatomic, strong) UILabel *packetSizeLabel;
@property (nonatomic, strong) UILabel *currentVersionLabel;
@property (nonatomic, strong) UILabel *updateTimeLabel;

@property (nonatomic, strong) UILabel *updateExplainLabel;
@property (nonatomic, strong) UILabel *explainLabel;

@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UIView *centerLineView;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) PSAppInfo *appInfo;
@property (nonatomic, assign) BOOL isCompulsoryUpdate;
@property (nonatomic, copy) void (^confirmBlock)(void);
@property (nonatomic, copy) void (^cancelBlock)(void);

@end

@implementation PSCheckVersionView

- (instancetype)initWithAppInfo:(PSAppInfo *)info
                        confirm:(void(^)(void))confirm
                         cancel:(void(^)(void))cancel {

    if (self = [super init]) {

        self.appInfo = info;
        self.confirmBlock = confirm;
        self.cancelBlock = cancel;
        self.isCompulsoryUpdate = (cancel == nil);
        [self configUI];
    }
    return self;
}

- (instancetype)initWithAppInfo:(PSAppInfo *)info
                        confirm:(void(^)(void))confirm {
    
    return [self initWithAppInfo:info confirm:confirm cancel:nil];
}

- (void)configUI {

    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;

    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];

    self.contentView = [[UIView alloc] init];
    [self.scrollView addSubview:self.contentView];

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = kRGBColor(23, 24, 28);
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.text = @"最新版本";
    [self.contentView addSubview:self.titleLabel];

    self.latestVersionLabel = [[UILabel alloc] init];
    self.latestVersionLabel.textColor = [UIColor whiteColor];
    self.latestVersionLabel.backgroundColor = kRGBColor(228, 30, 30);
    self.latestVersionLabel.font = [UIFont systemFontOfSize:12.0f];
    self.latestVersionLabel.text = self.appInfo.releaseVersion;
    self.latestVersionLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.latestVersionLabel];
    
    self.packetSizeLabel = [[UILabel alloc] init];
    self.packetSizeLabel.textColor = kRGBColor(119, 119, 119);
    self.packetSizeLabel.font = [UIFont systemFontOfSize:12.0f];
    self.packetSizeLabel.text = [NSString stringWithFormat:@"包大小: %@",self.appInfo.fileSize];
    self.packetSizeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.packetSizeLabel];
    
    self.currentVersionLabel = [[UILabel alloc] init];
    self.currentVersionLabel.textColor = kRGBColor(119, 119, 119);
    self.currentVersionLabel.font = [UIFont systemFontOfSize:12.0f];
    self.currentVersionLabel.text = [NSString stringWithFormat:
                                     @"当前版本: %@",self.appInfo.currentVersion];
    self.currentVersionLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.currentVersionLabel];
    
    self.updateTimeLabel = [[UILabel alloc] init];
    self.updateTimeLabel.textColor = kRGBColor(119, 119, 119);
    self.updateTimeLabel.font = [UIFont systemFontOfSize:12.0f];
    self.updateTimeLabel.textAlignment = NSTextAlignmentLeft;
    self.updateTimeLabel.text = [NSString stringWithFormat:
                                 @"更新时间: %@",self.appInfo.releaseDate];
    [self.contentView addSubview:self.updateTimeLabel];
    
    self.updateExplainLabel = [[UILabel alloc] init];
    self.updateExplainLabel.textColor = kRGBColor(119, 119, 119);
    self.updateExplainLabel.font = [UIFont systemFontOfSize:12.0f];
    self.updateExplainLabel.textAlignment = NSTextAlignmentLeft;
    self.updateExplainLabel.text = @"更新日志";
    [self.contentView addSubview:self.updateExplainLabel];
    
    self.explainLabel = [[UILabel alloc] init];
    self.explainLabel.textColor = kRGBColor(119, 119, 119);
    self.explainLabel.font = [UIFont systemFontOfSize:12.0f];
    self.explainLabel.numberOfLines = 0;
    self.explainLabel.textAlignment = NSTextAlignmentLeft;
    self.explainLabel.preferredMaxLayoutWidth = kExplainLabelLayoutMaxWidth;
    self.explainLabel.text = self.appInfo.releaseLog;
    [self.contentView addSubview:self.explainLabel];
    
    self.bottomLineView = [[UIView alloc] init];
    self.bottomLineView.backgroundColor = kRGBColor(223, 223, 223);
    [self addSubview:self.bottomLineView];

    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.confirmButton setTitleColor:kRGBColor(69, 149, 236)
                             forState:UIControlStateNormal];
    [self.confirmButton setTitle:@"立即更新" forState:UIControlStateNormal];
    [self addSubview:self.confirmButton];
    [self.confirmButton addTarget:self action:@selector(confirmButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];

    if (!self.isCompulsoryUpdate) {
        self.centerLineView = [[UIView alloc] init];
        self.centerLineView.backgroundColor = kRGBColor(223, 223, 223);
        [self addSubview:self.centerLineView];
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:kRGBColor(23, 24, 28) forState:UIControlStateNormal];
        [self addSubview:self.cancelButton];
        [self.cancelButton addTarget:self action:@selector(cancelButtonDidClicked) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)confirmButtonDidClicked {

    if (self.confirmBlock) {
        self.confirmBlock();
    }
}

- (void)cancelButtonDidClicked {

    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (CGFloat)calculationContentViewHeight {

    CGFloat explainLabelHeight = 0;
    if (self.explainLabel.text.length > 0) {
        CGRect frame = [self.explainLabel.text boundingRectWithSize:CGSizeMake(kExplainLabelLayoutMaxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:self.explainLabel.font } context:nil];
        explainLabelHeight = frame.size.height + 1;
    }

    CGFloat h =
    22 + 15
    + 22
    + (12 *3) + (2 *8)
    + 20
    + 15
    + 16
    + explainLabelHeight
    + 16;
    
    return ceil(h);
}

- (void)layoutSubviews {

    [super layoutSubviews];

    // 布局完成获取frame，计算滚动视图内容高度
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@([self calculationContentViewHeight]));
    }];
}

+ (BOOL)requiresConstraintBasedLayout {

    return YES;
}

- (void)updateConstraints {

    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.bottomLineView.mas_top);
    }];

    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.edges.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(self.scrollView).offset(-1); // 禁止左右滚动
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height); // 设置初始值
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.contentView).offset(22);
        make.centerX.mas_equalTo(self.contentView).offset(-22);
        make.height.mas_equalTo(@15);
    }];

    [self.latestVersionLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(self.titleLabel.mas_right).offset(22);
        make.centerY.mas_equalTo(self.titleLabel);
        make.width.mas_greaterThanOrEqualTo(@44);
        make.height.mas_equalTo(self.titleLabel);
    }];

    [self.packetSizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.latestVersionLabel.mas_bottom).offset(22);
        make.left.mas_equalTo(self.contentView).offset(15);
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.height.mas_equalTo(@12);
    }];

    [self.currentVersionLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.packetSizeLabel.mas_bottom).offset(8);
        make.left.right.mas_equalTo(self.packetSizeLabel);
        make.height.mas_equalTo(@12);
    }];

    [self.updateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.currentVersionLabel.mas_bottom).offset(8);
        make.left.right.mas_equalTo(self.currentVersionLabel);
        make.height.mas_equalTo(@12);
    }];

    [self.updateExplainLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.updateTimeLabel.mas_bottom).offset(20);
        make.left.right.mas_equalTo(self.updateTimeLabel);
        make.height.mas_equalTo(@15);
    }];

    [self.explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(self.updateExplainLabel.mas_bottom).offset(16);
        make.left.right.mas_equalTo(self.updateExplainLabel);
        make.bottom.mas_equalTo(self.contentView).offset(-16);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(self).offset(-45);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(@1);
    }];
    
    if (!self.isCompulsoryUpdate) {
        
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.centerLineView.mas_right);
            make.height.mas_equalTo(self.cancelButton);
            make.right.bottom.mas_equalTo(self);
        }];
        
        [self.centerLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.bottomLineView.mas_bottom).offset(6);
            make.bottom.mas_equalTo(self).offset(-6);
            make.centerX.mas_equalTo(self);
            make.width.mas_equalTo(@1);
        }];
        
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(self.centerLineView.mas_left);
            make.top.mas_equalTo(self.bottomLineView);
            make.left.bottom.mas_equalTo(self);
        }];
    }else {
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.bottomLineView);
            make.bottom.mas_equalTo(self);
        }];
    }
    
    [super updateConstraints];
}

@end
