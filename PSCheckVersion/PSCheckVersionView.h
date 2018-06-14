//
//  PSCheckVersionView.h
//  tyfocg
//
//  Created by paintingStyle on 2018/4/19.
//  Copyright © 2018年 com.worldTravelNetscape.tyfocg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PSAppInfo;

@interface PSCheckVersionView : UIView

/**
 初始化更新view

 @param info app信息
 @param confirm 确定
 @param cancel 取消
 @return PSCheckVersionView
 */
- (instancetype)initWithAppInfo:(PSAppInfo *)info
                        confirm:(void(^)(void))confirm
                         cancel:(void(^)(void))cancel;

/**
 初始化更新view（强制更新）

 @param info app信息
 @param confirm 确定
 @return 取消
 */
- (instancetype)initWithAppInfo:(PSAppInfo *)info
                        confirm:(void(^)(void))confirm;

@end
