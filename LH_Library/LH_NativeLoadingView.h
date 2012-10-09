//
//  LH_NativeLoadingView.h
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kLOADINGTAG 9902
@interface LH_NativeLoadingView : UIView
{
    UIActivityIndicatorView *loadView;
}
/*重写载入视图*/
- (id)initLoadingViewWithFrame:(CGRect)frame;
- (void)startLoading;
- (void)endLoading;
@end
