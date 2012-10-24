//
//  LH_DataCache.h
//  LH_Library
//
//  Created by  on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LH_DataCacheDelegate;
@interface LH_DataCache : NSObject 
{
    NSMutableDictionary *memCache;
    NSString *diskCachePath;
    NSOperationQueue *cacheInQueue, *cacheOutQueue;
}

+ (LH_DataCache *)sharedDataCache;
- (void)storeData:(NSData *)aData forKey:(NSString *)key;
- (void)storeData:(NSData *)aData forKey:(NSString *)key toDisk:(BOOL)toDisk;//存储data

- (NSData *)dataFromKey:(NSString *)key;
- (NSData *)dataFromKey:(NSString *)key fromDisk:(BOOL)fromDisk;//得到指定的data
- (void)queryDiskCacheForKey:(NSString *)key delegate:(id <LH_DataCacheDelegate>)delegate userInfo:(NSDictionary *)info;

- (void)removeDataForKey:(NSString *)key;//移除指点的元素
- (void)clearMemory;//清理内存
- (void)clearDisk;//清理所有的缓存
- (void)cleanDisk;//清理过期的缓存

@end


@protocol LH_DataCacheDelegate<NSObject>

@optional
- (void)dataCache:(LH_DataCache *)dataCache didFindData:(NSData *)aData forKey:(NSString *)key userInfo:(NSDictionary *)info;
- (void)dataCache:(LH_DataCache *)dataCache didNotFindDataForKey:(NSString *)key userInfo:(NSDictionary *)info;


@end
