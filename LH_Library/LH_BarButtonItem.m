//
//  LH_BarButtonItem.m
//  LH_Library
//
//  Created by  on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LH_BarButtonItem.h"

@implementation LH_BarButtonItem
/*
 初始化UIBarButtonItem
 */
- (id)initWithTarget:(id)target action:(SEL)action image:(NSString *)aimage title:(NSString *)atitle
{
	//构造返回item的按钮视图
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn retain];
	btn.frame = CGRectMake(0, 0, 44, 44);
	//按钮文字
	if (nil != atitle) 
	{
		[btn setTitle:atitle forState:UIControlStateNormal];
		[btn setTitle:atitle forState:UIControlStateHighlighted];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
	}
	[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	//按钮背景图
	if (nil != aimage) 
	{
		NSString *clickStr = [[NSString alloc]initWithFormat:@"%@1.png",aimage];
		NSString *normalStr = [[NSString alloc]initWithFormat:@"%@.png",aimage];
		NSLog(@"%@",normalStr);
		[btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] 
																  pathForResource:normalStr 
																  ofType:nil]] 
					   forState:UIControlStateNormal];
		[btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] 
																  pathForResource:clickStr 
																  ofType:nil]] 
					   forState:UIControlStateHighlighted];
		[clickStr release];
		clickStr = nil;
		[normalStr release];
		normalStr = nil;
	}
	[btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	self = [self initWithCustomView:btn];
	//[btn release];
	return self;
}

@end
