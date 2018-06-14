//
//  PSCheckVersion.h
//  tyfocg
//
//  Created by paintingStyle on 2018/4/19.
//  Copyright © 2018年 com.worldTravelNetscape.tyfocg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSAppInfo.h"

typedef void(^completeBlock) (PSAppInfo *info, NSError *error);

@interface PSCheckVersion : NSObject

+ (PSCheckVersion *)shardInstance;

/**
 在App内打开(此方式存在延迟，请求苹果服务器完成才能显示弹框)
 */
@property (nonatomic, assign) BOOL openAppStoreInApp;

/**
 如检测到不是最新版本，可设置销售地区，默认为cn，一般情况不用设置
 */
@property (nonatomic, copy) NSString *salesArea;

/**
 检测版本更新,自带UI
 */
+ (void)checkVersion;

/**
 检测版本更新,自带UI（强制更新）
 */
+ (void)checkVersionCompulsoryUpdate;

/**
 检测版本更新,需要自定义UI

 @param completeBlock 完成回调
 */
+ (void)checkVersionCompleteBlock:(completeBlock)completeBlock;

@end
