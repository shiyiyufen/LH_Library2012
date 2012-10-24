//
//  LH_WebViewCacheProtocol.h
//  LH_Library
//
//  Created by  on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
// 1. To build, you will need the Reachability code from Apple (included). That requires that you link with
//    `SystemConfiguration.framework`.
//
// 2. At some point early in the program (application:didFinishLaunchingWithOptions:),
//    call the following:
//*******************************************************************************************
//**************[NSURLProtocol registerClass:[LH_WebViewCacheProtocol class]];***************
//*******************************************************************************************
#import <Foundation/Foundation.h>

@interface LH_WebViewCacheProtocol : NSURLProtocol
- (NSString *)cachePathForRequest:(NSURLRequest *)aRequest;
- (BOOL) useCache;
@end
