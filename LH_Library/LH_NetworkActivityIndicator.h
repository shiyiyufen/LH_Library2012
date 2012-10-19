//
//  LH_NetworkActivityIndicator.h
//  LH_Library
//
//  Created by  on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LH_NetworkActivityIndicator : NSObject
+ (id)sharedActivityIndicator;

- (void)startActivity;
- (void)stopActivity;

@end
