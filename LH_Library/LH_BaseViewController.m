//
//  LH_BaseViewController.m
//  LH_Library
//
//  Created by  on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LH_BaseViewController.h"
#import "LHProgressHUD.h"
#import "LH_HtmlColor.h"
#import "LH_BarButtonItem.h"
@implementation LH_BaseViewController
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self initView];
    //self.view.backgroundColor = [LH_HtmlColor colorWithHexString:@"#eeeeee"];
	[self viewControllerHiddenNavigationBar:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	noData       = NO;
	reloadData   = YES;
	size         = 10;
	index        = 0;
    currentIndex = 0;
    NSLog(@"viewDidLoad 1");
	
}

//显示或隐藏导航条
- (void)viewControllerHiddenNavigationBar:(BOOL)hidden
{
    if (!(self.navigationController.navigationBarHidden & hidden))
    {
        [self.navigationController setNavigationBarHidden:hidden];
    }
}

//请求基本数据
- (void)requestData
{
	//NSLog(@"will requestData");
}

//数据初始化
- (void)initData
{
	//NSLog(@"will initData");
}

//视图初始化
- (void)initView
{
	//NSLog(@"will initView");
}

//初始化内存
- (void)allocMemory
{
    
}

//清除数据和视图
- (void)cleanViewAndData
{
	//NSLog(@"will clean view and data");
    
}

- (void)pleaseLoadData:(NSString *)info inView:(UIView *)aview
{
	if (!info)
	{
		info = @"数据加载中...";
	}
	if (!aview)
	{
		aview = self.view;
	}
	NSLog(@"start info view");
	LHProgressHUD *tagView = (LHProgressHUD *)[aview viewWithTag:kInfoViewTag];
	if (tagView)
	{
		tagView.labelText = info;NSLog(@"update info view");
	}else
	{
		LHProgressHUD *progress = [LHProgressHUD showHUDAddedTo:aview animated:YES];
		progress.tag = kInfoViewTag;
		[progress setLabelText:info];
        [progress resignFirstResponder];
	}
    [tagView resignFirstResponder];
    
}

- (void)stopLoadDataInView:(UIView *)aview
{
	if (!aview)
	{
		aview = self.view;
	}
	LHProgressHUD *tagView = (LHProgressHUD *)[aview viewWithTag:kInfoViewTag];
	if (tagView)
	{
		NSLog(@"hide info view:%@",aview);
		[tagView viewDidHideThisViewInView:aview];
	}
    [tagView resignFirstResponder];
}

//右搜索按钮
- (void)createRightSearchBar:(id)target action:(SEL)action
{
    self.navigationItem.rightBarButtonItem = nil;
    //左边主页按钮
    LH_BarButtonItem *searchItem = [[LH_BarButtonItem alloc]initWithTarget:target
                                                                  action:action
                                                                   image:@"search" 
                                                                   title:nil];
    self.navigationItem.rightBarButtonItem = searchItem;
    [searchItem release];
}


//自定义返回
- (void)setLeftItem_model:(BOOL)b
{
	self.navigationItem.leftBarButtonItem = nil;
	if (b) 
	{
		//左边主页按钮
		LH_BarButtonItem *searchItem = [[LH_BarButtonItem alloc]initWithTarget:self
																	  action:@selector(dismissAction)
																	   image:@"mainL" 
																	   title:nil];
		self.navigationItem.leftBarButtonItem = searchItem;
		[searchItem release];
	}
}

//显示左边返回
- (void) setLeftItem:(BOOL)b
{
	NSLog(@"setLeftItem");
	[self.navigationItem setHidesBackButton:YES];
	if (b) 
	{
		//左边主页按钮
		LH_BarButtonItem *searchItem = [[LH_BarButtonItem alloc]initWithTarget:self
																	  action:@selector(goBackToLastPage)
																	   image:@"right" 
																	   title:@"返回"];
		self.navigationItem.leftBarButtonItem = searchItem;
		[searchItem release];
	}else
	{
		self.navigationItem.leftBarButtonItem = nil;
	}
}

//显示右边主页
- (void) setRightItem:(BOOL)b
{
	if (b)
	{
		//右边返回主页按钮
		LH_BarButtonItem *mainItem = [[LH_BarButtonItem alloc]initWithTarget:self
																	action:@selector(goBackToMainPage)
																	 image:@"left" 
																	 title:nil];
		self.navigationItem.rightBarButtonItem = mainItem;
		[mainItem release];
	}else
	{
		self.navigationItem.rightBarButtonItem = nil;
	}
}


//自定义提示窗
- (void)alert:(NSString*)_alert
{		
	if (!_alert) 
	{
		_alert = @"出错啦!";
	}
	//移除alert
	UIImageView *aview = (UIImageView *)[self.view viewWithTag:666];
	if (aview) 
	{
		UILabel *l = (UILabel *)[aview viewWithTag:kLABELTAG];
		if (l)
		{
			l.text = _alert;
			_alert = nil;
			//动画开始
			[UIView beginAnimations:nil context:nil];
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView setAnimationDuration:4.0f];
			aview.frame = CGRectMake(0, 0, 320, 50);
			[UIView commitAnimations];
			
			[UIView beginAnimations:nil context:nil];
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView setAnimationDuration:2.0f];
			aview.frame = CGRectMake(0, -50, 320, 50);
			[UIView commitAnimations];
			
			return;
		}
	}
	//移除旧视图
	UIImageView *view = (UIImageView*)[self.view viewWithTag:666];
	if (view) {[view removeFromSuperview];}
	//背景视图
	UIImageView *myview = [[UIImageView alloc] init];
	myview.tag = 666;
	UIImage *image = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"alert.png" ofType:nil]];
	myview.frame = CGRectMake(0, -50, 320, 50);
	myview.image = image;
	[image release];
	
	//提示文字
	UILabel *alertLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 30)];
	alertLab.backgroundColor = [UIColor clearColor];
	alertLab.text = _alert;
	alertLab.tag = kLABELTAG;
	alertLab.font = [UIFont boldSystemFontOfSize:14];
	alertLab.textColor = [UIColor whiteColor];
	alertLab.textAlignment = UITextAlignmentCenter;
	[myview addSubview:alertLab];
	[alertLab release];
	
	//动画开始
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDuration:4.0f];
	myview.frame = CGRectMake(0, 0, 320, 50);
	[self.view addSubview:myview];
	[UIView commitAnimations];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:2.0f];
	myview.frame = CGRectMake(0, -50, 320, 50);
	[UIView commitAnimations];
	[myview release];
	_alert = nil;
}

- (void)showAlertViewWithText:(NSString *)str inView:(UIView *)v
{
	if (!str) 
	{
		str = @"出错啦!";
	}
	//移除alert
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	UIImageView *aview = (UIImageView *)[v viewWithTag:666];
	if (aview) 
	{
		UILabel *l = (UILabel *)[aview viewWithTag:kLABELTAG];
		if (l)
		{
			l.text = str;
			
			//动画开始
			[UIView beginAnimations:nil context:nil];
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView setAnimationDuration:4.0f];
			aview.frame = CGRectMake(0, 0, 320, 50);
			[UIView commitAnimations];
			
			[UIView beginAnimations:nil context:nil];
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView setAnimationDuration:2.0f];
			aview.frame = CGRectMake(0, -50, 320, 50);
			[UIView commitAnimations];
			
			return;
		}
	}
	//移除旧视图
	UIImageView *view = (UIImageView*)[v viewWithTag:666];
	if (view) 
	{
		[view removeFromSuperview];
	}
	//背景视图
	UIImageView *myview = [[UIImageView alloc] init];
	myview.tag = 666;
	UIImage *image = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"alert.png" ofType:nil]];
	myview.frame = CGRectMake(0, -50, 320, 50);
	myview.image = image;
	[image release];
	
	//提示文字
	UILabel *alertLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 30)];
	alertLab.backgroundColor = [UIColor clearColor];
	alertLab.text = str;
	alertLab.tag = kLABELTAG;
	alertLab.font = [UIFont boldSystemFontOfSize:14];
	alertLab.textColor = [UIColor whiteColor];
	alertLab.textAlignment = UITextAlignmentCenter;
	[myview addSubview:alertLab];
	[alertLab release];
	
	//动画开始
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDuration:4.0f];
	myview.frame = CGRectMake(0, 0, 320, 50);
	[v addSubview:myview];
	[UIView commitAnimations];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:2.0f];
	myview.frame = CGRectMake(0, -50, 320, 50);
	[UIView commitAnimations];
	[myview release];
	
	[pool release];
}

- (void) removeViewSubView
{
	
}
- (void)sendData:(NSString *)param
{
	
}

- (void)dismissAction
{
	[self dismissModalViewControllerAnimated:YES];
}

/*
 回到前一页面
 */
- (void)goBackToLastPage
{
	NSLog(@"sss");
	[self.navigationController popViewControllerAnimated:YES];
}

/*
 回到主页，即最初的页面
 */
- (void)goBackToMainPage
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self cleanViewAndData];
}
@end
