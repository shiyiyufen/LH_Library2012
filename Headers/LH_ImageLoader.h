//
//  LH_ImageLoader.h
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef __EGOIL_USE_BLOCKS
#define __EGOIL_USE_BLOCKS 0
#endif

#ifndef __EGOIL_USE_NOTIF
#define __EGOIL_USE_NOTIF 1
#endif

@protocol LH_ImageLoaderObserver;
@interface LH_ImageLoader : NSObject/*<NSURLConnectionDelegate>*/ {
@private
	NSDictionary* _currentConnections;
	NSMutableDictionary* currentConnections;
#if __EGOIL_USE_BLOCKS
	dispatch_queue_t _operationQueue;
#endif
    
	NSLock* connectionsLock;
}

+ (LH_ImageLoader*)sharedImageLoader;

- (BOOL)isLoadingImageURL:(NSURL*)aURL;

#if __EGOIL_USE_NOTIF
- (void)loadImageForURL:(NSURL*)aURL observer:(id<LH_ImageLoaderObserver>)observer;
- (UIImage*)imageForURL:(NSURL*)aURL shouldLoadWithObserver:(id<LH_ImageLoaderObserver>)observer;

- (void)removeObserver:(id<LH_ImageLoaderObserver>)observer;
- (void)removeObserver:(id<LH_ImageLoaderObserver>)observer forURL:(NSURL*)aURL;
#endif

#if __EGOIL_USE_BLOCKS
- (void)loadImageForURL:(NSURL*)aURL completion:(void (^)(UIImage* image, NSURL* imageURL, NSError* error))completion;
- (void)loadImageForURL:(NSURL*)aURL style:(NSString*)style styler:(UIImage* (^)(UIImage* image))styler completion:(void (^)(UIImage* image, NSURL* imageURL, NSError* error))completion;
#endif

- (BOOL)hasLoadedImageURL:(NSURL*)aURL;
- (void)cancelLoadForURL:(NSURL*)aURL;

- (void)clearCacheForURL:(NSURL*)aURL;
- (void)clearCacheForURL:(NSURL*)aURL style:(NSString*)style;

@property(nonatomic,retain) NSDictionary* currentConnections;
@end

@protocol LH_ImageLoaderObserver<NSObject>
@optional
- (void)imageLoaderDidLoad:(NSNotification*)notification; // Object will be LH_ImageLoader, userInfo will contain imageURL and image
- (void)imageLoaderDidFailToLoad:(NSNotification*)notification; // Object will be LH_ImageLoader, userInfo will contain error
@end

