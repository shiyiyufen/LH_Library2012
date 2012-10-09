//
//  LH_WebView.m
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LH_WebView.h"

@implementation LH_WebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
	{
        // Initialization code.
		self.backgroundColor= [UIColor clearColor];
		self.opaque = NO;
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		for(UIView* subView in [self subviews])
		{
			if([subView isKindOfClass:[UIScrollView class]])
			{
				for(UIView* shadowView in [subView subviews])
				{
					if([shadowView isKindOfClass:[UIImageView class]])
					{
						[shadowView setHidden:YES];
					}
				}
			}
		}
		[pool release];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
