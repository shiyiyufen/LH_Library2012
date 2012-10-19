//
//  LH_WebDataManager.h
//  LH_Library
//
//  Created by  on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LH_DataCache.h"
#import "LH_WebDataDownloader.h"

@protocol LH_WebDataManagerDelegate;
@interface LH_WebDataManager : NSObject<LH_DataCacheDelegate,LH_WebDataDownloaderDelegate> {
	NSMutableArray *delegates;
    NSMutableArray *downloaders;
    NSMutableDictionary *downloaderForURL;
    NSMutableArray *failedURLs;
}

+ (id)sharedManager;
- (NSData *)dataWithURL:(NSURL *)url;

- (void)downloadWithURL:(NSURL *)url delegate:(id<LH_WebDataManagerDelegate>)delegate;
- (void)downloadWithURL:(NSURL *)url delegate:(id<LH_WebDataManagerDelegate>)delegate refreshCache:(BOOL)refreshCache;
- (void)downloadWithURL:(NSURL *)url delegate:(id<LH_WebDataManagerDelegate>)delegate refreshCache:(BOOL)refreshCache retryFailed:(BOOL)retryFailed;
/**
 refreshCache=YES,重新下载并覆盖已有的cache;
 retryFailed=YES,失败后可以再次下载;
 lowPriority=YES,低优先级.
 **/
- (void)downloadWithURL:(NSURL *)url delegate:(id<LH_WebDataManagerDelegate>)delegate refreshCache:(BOOL)refreshCache retryFailed:(BOOL)retryFailed lowPriority:(BOOL)lowPriority;
- (void)cancelForDelegate:(id<LH_WebDataManagerDelegate>)delegate;

@end


@protocol LH_WebDataManagerDelegate <NSObject>

@optional
- (void)webDataManager:(LH_WebDataManager *)dataManager didFinishWithData:(NSData *)aData isCache:(BOOL)isCache;
- (void)webDataManager:(LH_WebDataManager *)dataManager didFailWithError:(NSError *)error;

@end