//
//  LH_NativeLoadingView.m
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LH_NativeLoadingView.h"

@implementation LH_NativeLoadingView

/*重写载入视图*/
- (id)initLoadingViewWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		//菊花视图
		loadView = [[UIActivityIndicatorView alloc]init];
		loadView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
		loadView.frame = CGRectMake(0, 0, 20, 20);
		[loadView setCenter:CGPointMake(160, 380)];
		loadView.tag = 22;
		[self addSubview:loadView];
		
	}
	return self;
}

- (void)startLoading
{	
	if (loadView) 
	{
		[loadView startAnimating];
	}
}

- (void)endLoading
{
	if (loadView)
	{
		[loadView stopAnimating];
	}
	
}
- (void)dealloc {
	[loadView release];
    [super dealloc];
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
