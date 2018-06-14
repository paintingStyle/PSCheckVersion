//
//  PSAppInfo.m
//  tyfocg
//
//  Created by paintingStyle on 2018/4/19.
//  Copyright © 2018年 com.worldTravelNetscape.tyfocg. All rights reserved.
//

#import "PSAppInfo.h"

@implementation PSAppInfo

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super init];
    if (self) {
        
        self.appId = dict[@"trackId"];
        self.bundleId = dict[@"bundleId"];
        self.currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
        self.releaseVersion = dict[@"version"];
        self.releaseLog = dict[@"releaseNotes"];
        self.releaseDate = dict[@"currentVersionReleaseDate"];
        self.appStoreUrl = dict[@"trackViewUrl"];
        self.appAbstract = dict[@"description"];
        self.sellerName = dict[@"sellerName"];
        self.fileSize = dict[@"fileSizeBytes"];
        self.screenshotUrls = dict[@"screenshotUrls"];
    
        self.releaseDate = [self formatReleaseDate];
        self.fileSize = [self formatFileSizeByMB];
    }
    return self;
}

- (NSString *)formatReleaseDate {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    NSDate *date = [dateFormatter dateFromString:self.releaseDate];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:timeZone];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *releaseDate= [dateFormatter stringFromDate:date];
    
    return releaseDate;
}

- (NSString *)formatFileSizeByMB {
    
    CGFloat fileSizeByMB = ([self.fileSize integerValue] /(1000 *1000));
    NSString *fileSize = [NSString stringWithFormat:@"%.0fMB",fileSizeByMB];
    return fileSize;
}

@end
