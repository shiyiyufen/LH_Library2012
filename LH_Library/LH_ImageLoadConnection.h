//
//  LH_ImageLoadConnection.h
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LH_ImageLoadConnectionDelegate;

@interface LH_ImageLoadConnection : NSObject {
@private
	NSURL* _imageURL;
	NSURLResponse* _response;
	NSMutableData* _responseData;
	NSURLConnection* _connection;
	NSTimeInterval _timeoutInterval;
	
	id<LH_ImageLoadConnectionDelegate> _delegate;
}

- (id)initWithImageURL:(NSURL*)aURL delegate:(id)delegate;

- (void)start;
- (void)cancel;

@property(nonatomic,readonly) NSData* responseData;
@property(nonatomic,readonly,getter=imageURL) NSURL* imageURL;

@property(nonatomic,retain) NSURLResponse* response;
@property(nonatomic,assign) id<LH_ImageLoadConnectionDelegate> delegate;

@property(nonatomic,assign) NSTimeInterval timeoutInterval; // Default is 30 seconds

#if __EGOIL_USE_BLOCKS
@property(nonatomic,readonly) NSMutableDictionary* handlers;
#endif

@end

@protocol LH_ImageLoadConnectionDelegate<NSObject>
- (void)imageLoadConnectionDidFinishLoading:(LH_ImageLoadConnection *)connection;
- (void)imageLoadConnection:(LH_ImageLoadConnection *)connection didFailWithError:(NSError *)error;	
@end
