//
//  LH_Cache.h
//  LH_Library
//
//  Created by  on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <TargetConditionals.h>

#if !TARGET_OS_IPHONE
#import <AppKit/AppKit.h>
#ifndef UIImage
#define UIImage NSImage
#endif
#ifndef UIImageView
#define UIImageView NSImageView
#endif
#else
#import <UIKit/UIKit.h>
#endif
