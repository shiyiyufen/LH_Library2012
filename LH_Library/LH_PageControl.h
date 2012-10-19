//
//  LH_PageControl.h
//  LH_Library
//
//  Created by  on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LH_PageControl : UIPageControl
{
    UIImage *imagePageStateNormal;
	UIImage *imagePageStateHighlighted;
    @private
    CGSize  _pcSize;
}
@property (assign, nonatomic) CGSize pcSize;
//自定义初始化方法
- (id)initLH_PageControlWithFrame:(CGRect)frame;
@property (nonatomic, retain) UIImage *imagePageStateNormal;
@property (nonatomic, retain) UIImage *imagePageStateHighlighted;
@end
