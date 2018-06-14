//
//  PSCheckVersion.m
//  tyfocg
//
//  Created by paintingStyle on 2018/4/19.
//  Copyright © 2018年 com.worldTravelNetscape.tyfocg. All rights reserved.
//

#import "PSCheckVersion.h"
#import <StoreKit/StoreKit.h>
#import "PSCheckVersionRequest.h"
#import "PSCheckVersionView.h"
#if __has_include(<Masonry.h>)
#import <Masonry.h>
#else
#import "Masonry.h"
#endif

#define kNoVersionUpdateError [[NSError alloc] initWithDomain:@"PSCheckVersionDomain" code:50000 userInfo:@{NSLocalizedDescriptionKey:@"当前app为最新版本"}]

@interface PSCheckVersion()<SKStoreProductViewControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) PSAppInfo *appInfo;
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) PSCheckVersionView *checkVersionView;

@property (nonatomic, assign) BOOL isCompulsoryUpdate;

@end

@implementation PSCheckVersion

+ (void)checkVersion {
    
    [[PSCheckVersion shardInstance]
     checkVersionAutoAlertCompulsoryUpdate:NO];
}

+ (void)checkVersionCompulsoryUpdate {
    
    [[PSCheckVersion shardInstance]
     checkVersionAutoAlertCompulsoryUpdate:YES];
}

+ (void)checkVersionCompleteBlock:(completeBlock)completeBlock {
    
    [[PSCheckVersion shardInstance] checkVersionCompleteBlock:completeBlock];
}

- (void)show {
    
    if (_coverView) { return; }
    
    __weak typeof(self)weakSelf = self;

    if (self.isCompulsoryUpdate) {
        self.checkVersionView = [[PSCheckVersionView alloc]
                                 initWithAppInfo:self.appInfo
                                 confirm:^{
                                     [weakSelf jumpAppStoreUpdate];
                                 }];
    }else {
        self.checkVersionView = [[PSCheckVersionView alloc]
                                 initWithAppInfo:self.appInfo
                                 confirm:^{
                                     [weakSelf jumpAppStoreUpdate];
                                     [weakSelf hide];
                                 } cancel:^{
                                     [weakSelf hide];
                                 }];
    }
    [self.coverView addSubview:self.checkVersionView];
    [self.checkVersionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.coverView).multipliedBy(0.69);
        make.height.equalTo(self.coverView).multipliedBy(0.57);
        make.center.equalTo(self.coverView);
    }];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.coverView];
}

- (void)hide {
    
    [self.coverView removeFromSuperview];
    self.appInfo = nil;
    self.checkVersionView = nil;
    self.coverView = nil;
}

- (void)checkVersionAutoAlertCompulsoryUpdate:(BOOL)update {
    
    self.isCompulsoryUpdate = update;
    [self checkVersionCompleteBlock:^(PSAppInfo *info, NSError *error) {
        
        if (error) { return; }
        [self show];
    }];
}

- (void)checkVersionCompleteBlock:(completeBlock)completeBlock {
    
    [PSCheckVersionRequest checkVersionSuccess:^(NSDictionary *result) {
        
        NSInteger resultCount = [result[@"resultCount"] integerValue];
        if(resultCount == 1) {
            NSArray *resultList = result[@"results"];
            NSDictionary *resultDict = resultList.firstObject;
            PSAppInfo *appInfo = [[PSAppInfo alloc] initWithDict:resultDict];
            self.appInfo = appInfo;
            if([self checkVersionUpdate]) {
                if (completeBlock) {
                    completeBlock(appInfo, nil);
                }
            }else {
                if (completeBlock) {
                    completeBlock(nil, kNoVersionUpdateError);
                }
            }
            [self debugLog];
        }else {
            if (completeBlock) {
                completeBlock(nil, kNoVersionUpdateError);
            }
        }
    } failure:^(NSError *error) {
       
        #ifdef DEBUG
        NSLog(@"PSCheckVersion检测失败,%@", error.localizedDescription);
        #endif
        if (completeBlock) {
            completeBlock(nil, error);
        }
    }];
}

- (void)debugLog {
#ifdef DEBUG
    NSLog(@"\n**********************************\nPSCheckVersion检测更新完成!\nAppstore最新版本:\n%@\n更新信息:\n%@\n**********************************",self.appInfo.releaseVersion,self.appInfo.releaseLog);
#endif
}

- (BOOL)checkVersionUpdate {

    if([self.appInfo.currentVersion compare:self.appInfo.releaseVersion options:NSNumericSearch]
       == NSOrderedAscending) {
        return YES;
    }
    return NO;
}

- (void)jumpAppStoreUpdate {
    
    if (self.openAppStoreInApp) {
        SKStoreProductViewController *storeViewController = [[SKStoreProductViewController alloc] init];
        storeViewController.delegate = self;
        NSDictionary *parametersDic = @{SKStoreProductParameterITunesItemIdentifier:
                                            self.appInfo.appId};
        [storeViewController loadProductWithParameters:parametersDic completionBlock:^(BOOL result, NSError * _Nullable error) {
            if (result) {
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:storeViewController animated:YES completion:^{
                    
                }];
            }
        }];
    }else {
        [[UIApplication sharedApplication] openURL:
         [NSURL URLWithString:self.appInfo.appStoreUrl]];
    }
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    
    [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (UIView *)coverView {
    
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5f];
    }
    return _coverView;
}

+ (PSCheckVersion *)shardInstance {
  
    static PSCheckVersion *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[PSCheckVersion alloc] init];
        instance.openAppStoreInApp = NO;
        instance.salesArea = @"cn";
    });
    return instance;
}

@end
