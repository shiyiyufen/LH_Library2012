//
//  LH_ScrollView+CustomScrollBar.h
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIScrollView(LH_ScrollView_CustomScrollBar)
{
    
}

-(void)setHorizontalScrollbarImage:(UIImage *)image;
-(void)setVerticalScrollbarImage:(UIImage *)image;

-(void)setHorizontalScrollbarHeight:(int)height;
-(void)setVerticalScrollbarWidth:(int)width;

- (void)showCustomScrollBar:(BOOL)isVerticalScrollbar;
@end
