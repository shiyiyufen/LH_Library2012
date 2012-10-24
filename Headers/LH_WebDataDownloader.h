//
//  LH_WebDataDownloader.h
//  LH_Library
//
//  Created by  on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString *const SDWebImageDownloadStartNotification;
extern NSString *const SDWebImageDownloadStopNotification;

@protocol LH_WebDataDownloaderDelegate;
@interface LH_WebDataDownloader : NSObject {
@private
    NSURL *url;
    id<LH_WebDataDownloaderDelegate> delegate;
    NSURLConnection *connection;
    NSMutableData *theData;
	id userInfo;
    BOOL lowPriority;
}

@property (nonatomic, retain) NSURL *url;
@property (nonatomic, assign) id<LH_WebDataDownloaderDelegate> delegate;
@property (nonatomic, retain) NSMutableData *theData;
@property (nonatomic, retain) id userInfo;
@property (nonatomic, readwrite) BOOL lowPriority;

+ (id)downloaderWithURL:(NSURL *)aUrl delegate:(id<LH_WebDataDownloaderDelegate>)aDelegate userInfo:(id)aUserInfo lowPriority:(BOOL)aLowPriority;
+ (id)downloaderWithURL:(NSURL *)aUrl delegate:(id<LH_WebDataDownloaderDelegate>)aDelegate userInfo:(id)aUserInfo;
+ (id)downloaderWithURL:(NSURL *)aUrl delegate:(id<LH_WebDataDownloaderDelegate>)aDelegate;
- (void)start;
- (void)cancel;

// This method is now no-op and is deprecated
+ (void)setMaxConcurrentDownloads:(NSUInteger)max __attribute__((deprecated));

@end

@protocol LH_WebDataDownloaderDelegate <NSObject>

@optional
- (void)dataDownloaderDidFinish:(LH_WebDataDownloader *)downloader;
- (void)dataDownloader:(LH_WebDataDownloader *)downloader didFinishWithData:(NSData *)aData;
- (void)dataDownloader:(LH_WebDataDownloader *)downloader didFailWithError:(NSError *)error;

@end
