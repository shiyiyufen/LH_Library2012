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

enum SharpStyle2
{
    LH_SharpStyleGray2 = 1,
    LH_SharpStyleBlue2,
    LH_SharpStyleWhite2,
    LH_SharpStyleBlack2
};

@protocol PullDownToRefreshTableHeaderDelegate;
@interface LH_RefrashView : UIView
{
	id                      _delegate;
    enum SharpStyle2        sharpStyle2;
	PullDownToRefreshState  _state;
	
	UILabel                 *_lastUpdatedLabel;
	UILabel                 *_statusLabel;
	CALayer                 *_arrowImage;
	UIActivityIndicatorView *_activityView;
}
@property (assign, nonatomic) enum SharpStyle2 sharpStyle2;
@property (nonatomic, assign) id <PullDownToRefreshTableHeaderDelegate> delegate;

- (NSString *)getBundleFile:(NSString *)filename;

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

