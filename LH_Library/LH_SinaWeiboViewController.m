//
//  LH_SinaWeiboViewController.m
//  LH_Library
//
//  Created by  on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "LH_SinaWeiboViewController.h"
#import "LH_HtmlColor.h"
//sina
#import "LHProgressHUD.h"
//sina
//sina
@interface LH_SinaWeiboViewController (Private)

- (void)dismissTimelineViewController;
- (void)presentTimelineViewController:(BOOL)animated;
- (void)presentTimelineViewControllerWithoutAnimation;

@end
//sina
@implementation LH_SinaWeiboViewController
@synthesize weiboEngine,sendImage,sendText;
static int kProgressTag     = 2011;

- (void)dealloc
{
    //sina
	[weiboEngine release];
    [sendImage   release];
    self.sendText = nil;
	//sina
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)shareMe:(id)sender
{
    if (weiboEngine == nil)
	{
		WBEngine *engine = [[WBEngine alloc] initWithAppKey:kSinaWeiboAppKey
												  appSecret:kSinaWeiboAppSecret];
		[engine setRootViewController:self];
		[engine setDelegate:self];
		[engine setRedirectURI:@"http://"];
		[engine setIsUserExclusive:NO];
		self.weiboEngine = engine;
		//[string release];
		[engine release];
	}
	
	//UIView *shareview = [CCShareView shareText:@"ok" imageArray:nil inView:self.view];
	//	[self.view addSubview:shareview];
	//check sina log state
	NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
	NSString *account = [userInfo objectForKey:@"account"];
	NSString *pwd = [userInfo objectForKey:@"pwd"];
	if (!account || [account isEqualToString:@"0"] || !pwd || [pwd isEqualToString:@"0"])
	{
		[weiboEngine logIn];
	}else
	{
		[self willSendShareDataWithText:self.sendText image:self.sendImage];
	}
}


/*是否发送成功*/
- (NSInteger) checkIsSendSuccess
{
	return success;
}


- (void) willSendShareDataWithText:(NSString *)text image:(UIImage *)img
{
	//UIImage *img = [[UIImage alloc] initWithContentsOfFile:[imageArray objectAtIndex:index]];
	[weiboEngine sendWeiBoWithText:text image:img];
	//[img release];
	LHProgressHUD *progress = [LHProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
	progress.tag = kProgressTag;
	progress.labelText = @"发送中...";
	[progress becomeFirstResponder];
	success = 0;
}

- (void)logInAlertView:(WBLogInAlertView *)alertView logInWithUserID:(NSString *)userID password:(NSString *)password
{
	NSLog(@"logInWithUserID:%@",userID);
	NSLog(@"password:%@",password);
}

- (void)engine:(WBEngine *)engine requestDidFailWithError:(NSError *)error
{
	success = -1;
	LHProgressHUD *progress = (LHProgressHUD *)[self.navigationController.view viewWithTag:kProgressTag];
	[progress retain];
	if (progress)
	{
		[progress setLabelText:@"发送失败"];
	}
	[progress resignFirstResponder];
	[progress release];
	[LHProgressHUD hideHUDForView:self.navigationController.view animated:YES];
	
}
- (void)engine:(WBEngine *)engine requestDidSucceedWithResult:(id)result
{
	LHProgressHUD *progress = (LHProgressHUD *)[self.navigationController.view viewWithTag:kProgressTag];
	[progress retain];
	if (progress)
	{
		[progress setLabelText:@"发送成功"];
	}
	[progress resignFirstResponder];
	[progress release];
	[LHProgressHUD hideHUDForView:self.navigationController.view animated:YES];
	success = 1;
}
- (void)dismissTimelineViewController
{
	[self dismissModalViewControllerAnimated:YES];
}

- (void)presentTimelineViewControllerWithoutAnimation
{
	//[self presentTimelineViewController:NO];
}

#pragma mark - WBEngineDelegate Methods

#pragma mark Authorize

- (void)engineAlreadyLoggedIn:(WBEngine *)engine
{
	[indicatorView stopAnimating];
	if ([engine isUserExclusive])
	{
		UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
														   message:@"请先登出！" 
														  delegate:nil
												 cancelButtonTitle:@"确定" 
												 otherButtonTitles:nil];
		[alertView show];
		[alertView release];
	}
}

//登录成功啦
- (void)engineDidLogIn:(WBEngine *)engine
{
	[indicatorView stopAnimating];
    
    [self pleaseLoadData:NSLocalizedString(@"登录成功",nil) inView:self.navigationController.view];
    [self performSelector:@selector(stopLoadDataInView:) withObject:self.navigationController.view afterDelay:0.5f];
    
    [self willSendShareDataWithText:self.sendText image:self.sendImage];
}

- (void)engine:(WBEngine *)engine didFailToLogInWithError:(NSError *)error
{
	[indicatorView stopAnimating];
	UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
													   message:@"登录失败！" 
													  delegate:nil
											 cancelButtonTitle:@"确定" 
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
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

@end
