//
//  LH_ImageButton.h
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LH_ImageLoader.h"

@protocol LH_ImageButtonDelegate;
@interface LH_ImageButton : UIButton<LH_ImageLoaderObserver> {
@private
	NSURL* imageURL;
	UIImage* placeholderImage;
	id<LH_ImageButtonDelegate> delegate;
}

- (id)initWithPlaceholderImage:(UIImage*)anImage; // delegate:nil
- (id)initWithPlaceholderImage:(UIImage*)anImage delegate:(id<LH_ImageButtonDelegate>)aDelegate;

- (void)cancelImageLoad;

@property(nonatomic,retain) NSURL* imageURL;
@property(nonatomic,retain) UIImage* placeholderImage;
@property(nonatomic,assign) id<LH_ImageButtonDelegate> delegate;
@end

@protocol LH_ImageButtonDelegate<NSObject>
@optional
- (void)imageButtonLoadedImage:(LH_ImageButton*)imageButton;
- (void)imageButtonFailedToLoadImage:(LH_ImageButton*)imageButton error:(NSError*)error;
@end