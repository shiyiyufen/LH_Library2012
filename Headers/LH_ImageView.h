//
//  LH_ImageView.h
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LH_ImageLoader.h"

@protocol LH_ImageViewDelegate;
@interface LH_ImageView : UIImageView<LH_ImageLoaderObserver> {
@private
	NSURL* imageURL;
	UIImage* placeholderImage;
	id<LH_ImageViewDelegate> delegate;
}

- (id)initWithPlaceholderImage:(UIImage*)anImage; // delegate:nil
- (id)initWithPlaceholderImage:(UIImage*)anImage delegate:(id<LH_ImageViewDelegate>)aDelegate;

- (void)cancelImageLoad;

@property(nonatomic,retain) NSURL* imageURL;
@property(nonatomic,retain) UIImage* placeholderImage;
@property(nonatomic,assign) id<LH_ImageViewDelegate> delegate;
@end

@protocol LH_ImageViewDelegate<NSObject>
@optional
- (void)imageViewLoadedImage:(LH_ImageView*)imageView;
- (void)imageViewFailedToLoadImage:(LH_ImageView*)imageView error:(NSError*)error;
@end