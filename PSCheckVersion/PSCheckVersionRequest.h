//
//  PSCheckVersionRequest.h
//  tyfocg
//
//  Created by paintingStyle on 2018/4/19.
//  Copyright © 2018年 com.worldTravelNetscape.tyfocg. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^requestSucess) (NSDictionary *result);
typedef void(^requestFailure) (NSError *error);

@interface PSCheckVersionRequest : NSObject

+ (void)checkVersionSuccess:(requestSucess)success
                    failure:(requestFailure)failure;

@end
