//
//  LH_ScrollView+CustomScrollBar.m
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LH_ScrollView+CustomScrollBar.h"
static const int UIScrollViewHorizontalBarIndexOffset = 0;
static const int UIScrollViewVerticalBarIndexOffset   = 1;


@interface UIScrollView(LH_ScrollView_CustomScrollBarPrivate)
- (UIImageView *)scrollbarImageViewWithIndex:(int)indexOffset;
@end

@implementation UIScrollView(LH_ScrollView_CustomScrollBarPrivate)
- (UIImageView *)scrollbarImageViewWithIndex:(int)indexOffset 
{
    int viewsCount      = [[self subviews] count];
	if (viewsCount <= 0) return nil;
    UIImageView *result = [[self subviews] objectAtIndex:viewsCount - indexOffset - 1];
    return result;
}
@end


@implementation UIScrollView(LH_ScrollView_CustomScrollBar)
BOOL lastResult = YES;

- (void)setHorizontalScrollbarImage:(UIImage *)image 
{    
    UIImageView *scrollBar = [self scrollbarImageViewWithIndex:UIScrollViewHorizontalBarIndexOffset];
	if ([scrollBar isKindOfClass:[UIImageView class]])
	{
		[scrollBar setImage:image]; 
	}
	NSLog(@"scrollBar:%@",scrollBar);
	NSLog(@"image:%@",image);
}

- (void)setVerticalScrollbarImage:(UIImage *)image 
{
    UIImageView *scrollBar = [self scrollbarImageViewWithIndex:UIScrollViewVerticalBarIndexOffset];
    if ([scrollBar isKindOfClass:[UIImageView class]])
	{
		[scrollBar setImage:image]; 
	}
}

- (void)setHorizontalScrollbarHeight:(int)height 
{
    UIImageView *scrollBar = [self scrollbarImageViewWithIndex:UIScrollViewHorizontalBarIndexOffset];
    
    CGRect frame = [scrollBar frame];
    frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height);
    [scrollBar setFrame:frame];
}

- (void)setVerticalScrollbarWidth:(int)width 
{
    UIImageView *scrollBar = [self scrollbarImageViewWithIndex:UIScrollViewVerticalBarIndexOffset];
    
    CGRect frame = [scrollBar frame];
    frame = CGRectMake(frame.origin.x, frame.origin.y, width, frame.size.height);
    [scrollBar setFrame:frame];    
}

- (void)showCustomScrollBar:(BOOL)isVerticalScrollbar
{
	//if (lastResult == isVerticalScrollbar)
    //	{
    //		return;
    //	}
    //	lastResult = isVerticalScrollbar;
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	if (isVerticalScrollbar)
	{
		UIImage *image = [UIImage imageNamed:@"scroll_v.png"];
		image = [image stretchableImageWithLeftCapWidth:0 topCapHeight:5];
		[self setVerticalScrollbarImage:image];
		[self setVerticalScrollbarWidth:7];
	}else
	{
		UIImage *image = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"scroll_h.png" ofType:nil]];
		//image = [image stretchableImageWithLeftCapWidth:5 topCapHeight:0];
		[self setHorizontalScrollbarImage:image];
		[self setHorizontalScrollbarHeight:2];
		[image release];
	}
    
	[pool release];
}
@end
