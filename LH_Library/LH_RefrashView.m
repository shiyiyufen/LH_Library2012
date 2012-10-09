//
//  LH_RefrashView.m
//  LH_Library
//
//  Created by  on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LH_RefrashView.h"
#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f


@interface LH_RefrashView (Private)
- (void)setState:(PullDownToRefreshState)aState;
@end

@implementation LH_RefrashView

@synthesize delegate=_delegate;


- (id)initWithFrame:(CGRect)frame 
{
    if (self = [super initWithFrame:frame]) 
	{
		
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];
		
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont systemFontOfSize:12.0f];
		label.textColor = TEXT_COLOR;
		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		[self addSubview:label];
		_lastUpdatedLabel=label;
		[label release];
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont boldSystemFontOfSize:13.0f];
		label.textColor = TEXT_COLOR;
		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		[self addSubview:label];
		_statusLabel=label;
		[label release];
		
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(25.0f, frame.size.height - 65.0f, 30.0f, 55.0f);
		layer.contentsGravity = kCAGravityResizeAspect;
		layer.contents = (id)[UIImage imageNamed:@"grayArrow.png"].CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) 
		{
			layer.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		
		[[self layer] addSublayer:layer];
		_arrowImage=layer;
		
		UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		view.frame = CGRectMake(25.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
		[self addSubview:view];
		_activityView = view;
		[view release];
		
		[self setState:PullDownToRefreshNormal];
		
    }
	
    return self;
	
}


#pragma mark -
#pragma mark Setters
/*更新上次刷新时间*/
- (void)refreshLastUpdatedDate 
{	
	if ([_delegate respondsToSelector:@selector(pullDownToRefreshTableHeaderDataSourceLastUpdated:)])
	{
		NSDate *date = [_delegate pullDownToRefreshTableHeaderDataSourceLastUpdated:self];
		
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setAMSymbol:@"上午"];
		[formatter setPMSymbol:@"下午"];
		[formatter setDateFormat:@"MM/dd/yyyy hh:mm:a"];
		_lastUpdatedLabel.text = [NSString stringWithFormat:@"上一次更新: %@", [formatter stringFromDate:date]];
		[[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"EGORefreshTableView_LastRefresh"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		[formatter release];
		
	} else 
	{
		_lastUpdatedLabel.text = nil;
	}
}

- (void)setState:(PullDownToRefreshState)aState
{	
	switch (aState)
	{
		case PullDownToRefreshPulling:
			
			_statusLabel.text = NSLocalizedString(@"释放手指刷新...", @"Release to refresh status");
			[CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
			_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];
			
			break;
		case PullDownToRefreshNormal:
			
			if (_state == PullDownToRefreshPulling) 
			{
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}
			
			_statusLabel.text = NSLocalizedString(@"下拉刷新...", @"Pull down to refresh status");
			[_activityView stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden = NO;
			_arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
			
			[self refreshLastUpdatedDate];
			
			break;
		case PullDownToRefreshLoading:
			
			_statusLabel.text = NSLocalizedString(@"请稍候...", @"Loading Status");
			[_activityView startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden = YES;
			[CATransaction commit];
			
			break;
		default:
			break;
	}
	
	_state = aState;
}


#pragma mark -
#pragma mark ScrollView Methods

- (void)pullDownToRefreshScrollViewDidScroll:(UIScrollView *)scrollView 
{		
	if (_state == PullDownToRefreshLoading)
	{
		CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
		offset         = MIN(offset, 60);
		scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
		
	} else if (scrollView.isDragging) 
	{
		BOOL _loading = NO;
		if ([_delegate respondsToSelector:@selector(pullDownToRefreshTableHeaderDataSourceIsLoading:)]) 
		{
			_loading = [_delegate pullDownToRefreshTableHeaderDataSourceIsLoading:self];
		}
		
		if (_state == PullDownToRefreshPulling && 
			scrollView.contentOffset.y > -65.0f && 
			scrollView.contentOffset.y < 0.0f && !_loading) 
		{
			[self setState:PullDownToRefreshNormal];
		} else if (_state == PullDownToRefreshNormal &&
				   scrollView.contentOffset.y < -65.0f && 
				   !_loading) 
		{
			[self setState:PullDownToRefreshPulling];
		}
		if (scrollView.contentInset.top != 0) 
		{
			scrollView.contentInset = UIEdgeInsetsZero;
		}
	}
}

- (void)pullDownToRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView 
{	
	BOOL _loading = NO;
	if ([_delegate respondsToSelector:@selector(pullDownToRefreshTableHeaderDataSourceIsLoading:)]) 
	{
		_loading = [_delegate pullDownToRefreshTableHeaderDataSourceIsLoading:self];
	}
	
	if (scrollView.contentOffset.y <= - 65.0f && !_loading) 
	{
		if ([_delegate respondsToSelector:@selector(pullDownToRefreshTableHeaderDidTriggerRefresh:)]) 
		{
			[_delegate pullDownToRefreshTableHeaderDidTriggerRefresh:self];
		}
		
		[self setState:PullDownToRefreshLoading];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
		
	}
}

- (void)pullDownToRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView 
{	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
	[scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[self setState:PullDownToRefreshNormal];
	
}


#pragma mark -
#pragma mark Dealloc

- (void)dealloc
{	
	_delegate=nil;
	_activityView = nil;
	_statusLabel = nil;
	_arrowImage = nil;
	_lastUpdatedLabel = nil;
    [super dealloc];
}


@end

