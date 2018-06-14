//
//  PSCheckVersionRequest.m
//  tyfocg
//
//  Created by paintingStyle on 2018/4/19.
//  Copyright © 2018年 com.worldTravelNetscape.tyfocg. All rights reserved.
//

#import "PSCheckVersionRequest.h"
#import "PSCheckVersion.h"

#define kCheckVersioError(_userInfo) [[NSError alloc] initWithDomain:@"PSCheckVersionErrorDomain" code:-1 userInfo:@{NSLocalizedDescriptionKey:_userInfo}]

@implementation PSCheckVersionRequest

+ (void)checkVersionSuccess:(requestSucess)success
                    failure:(requestFailure)failure {
    
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleId = infoDict[@"CFBundleIdentifier"];
    NSString *salesArea = [PSCheckVersion shardInstance].salesArea;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/lookup?country=%@&bundleId=%@",salesArea,bundleId]];
 
    dispatch_async(dispatch_get_global_queue
                (DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
  
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error || !data) {
                    if(failure) {
                        failure(error ?:kCheckVersioError(@"苹果服务器返回数据为nil，请检查你的网络(可能原因:iTunes被墙)"));
                    }
                    return;
                }
                NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                if (responseDict[@"errorMessage"]) {
                    if(failure) {
                        failure(kCheckVersioError(responseDict[@"errorMessage"]));
                    }
                }else {
                    if(success) {
                        success(responseDict);
                    }
                }
            });
            
        }];
        [dataTask resume];
    });
}

@end
