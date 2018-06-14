//
//  PSAppInfo.h
//  tyfocg
//
//  Created by paintingStyle on 2018/4/19.
//  Copyright © 2018年 com.worldTravelNetscape.tyfocg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSAppInfo : NSObject

/**
 *  AppId
 */
@property (nonatomic, copy) NSString *appId;

/**
 *  bundleId
 */
@property(nonatomic,copy)NSString *bundleId;

/**
 *  当前版本号
 */
@property (nonatomic, copy) NSString *currentVersion;

/**
 *  更新版本号
 */
@property (nonatomic, copy) NSString *releaseVersion;

/**
 *  更新日志
 */
@property (nonatomic, copy) NSString *releaseLog;

/**
 *  更新时间(yyyy-MM-dd HH:mm)
 */
@property (nonatomic, copy) NSString *releaseDate;

/**
 *  AppStore地址
 */
@property (nonatomic, copy) NSString *appStoreUrl;

/**
 *  APP简介
 */
@property (nonatomic, copy) NSString *appAbstract;

/**
 *  开发商
 */
@property (nonatomic, copy) NSString *sellerName;

/**
 *  文件大小(MB)
 */
@property (nonatomic, copy) NSString *fileSize;

/**
 *  展示图
 */
@property (nonatomic, copy) NSArray *screenshotUrls;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
