//
//  LH_Imageview+WebCache.h
//  LH_Library
//
//  Created by  on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LH_Cache.h"
#import "LH_WebDataManager.h"

@interface UIImageView(LH_WebCacheCategory)<LH_WebDataManagerDelegate>

- (void)setImageWithURL:(NSURL *)url;
- (void)setImageWithURL:(NSURL *)url refreshCache:(BOOL)refreshCache;
- (void)setImageWithURL:(NSURL *)url refreshCache:(BOOL)refreshCache placeholderImage:(UIImage *)placeholder;
- (void)cancelCurrentImageLoad;

@end

