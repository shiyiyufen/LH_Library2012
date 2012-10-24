//
//  LH_RefrashViewController.h
//  LH_Library
//
//  Created by  on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LH_BaseViewController.h"
#import "LH_RefrashView.h"
enum SharpStyle
{
    LH_SharpStyleGray = 1,
    LH_SharpStyleBlue,
    LH_SharpStyleWhite,
    LH_SharpStyleBlack
};

@interface LH_RefrashViewController : LH_BaseViewController
<UIScrollViewDelegate,PullDownToRefreshTableHeaderDelegate
>{
    enum SharpStyle       sharpStyle;
    LH_RefrashView        *_refrashHeaderView;
	BOOL                  _reloading;
	UIScrollView          *_refrashScroll;
}
@property (assign, nonatomic) enum SharpStyle sharpStyle;
@property (nonatomic,retain) UIScrollView     *refrashScroll;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end
