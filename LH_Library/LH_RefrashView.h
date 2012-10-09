//
//  LH_RefrashView.h
//  LH_Library
//
//  Created by  on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
typedef enum{
	PullDownToRefreshPulling = 0,
	PullDownToRefreshNormal,
	PullDownToRefreshLoading,	
} PullDownToRefreshState;

@protocol PullDownToRefreshTableHeaderDelegate;
@interface LH_RefrashView : UIView
{
	id                      _delegate;
	PullDownToRefreshState  _state;
	
	UILabel                 *_lastUpdatedLabel;
	UILabel                 *_statusLabel;
	CALayer                 *_arrowImage;
	UIActivityIndicatorView *_activityView;
}

@property(nonatomic,assign) id <PullDownToRefreshTableHeaderDelegate> delegate;

- (void)refreshLastUpdatedDate;
- (void)pullDownToRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)pullDownToRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)pullDownToRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end
@protocol PullDownToRefreshTableHeaderDelegate
- (void)pullDownToRefreshTableHeaderDidTriggerRefresh:(LH_RefrashView *)view;
- (BOOL)pullDownToRefreshTableHeaderDataSourceIsLoading:(LH_RefrashView *)view;
@optional
- (NSDate *)pullDownToRefreshTableHeaderDataSourceLastUpdated:(LH_RefrashView *)view;
@end

