//
//  LH_SinaWeiboViewController.h
//  LH_Library
//
//  Created by  on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LH_BaseViewController.h"
//新浪微博
#import "WBEngine.h"
#import "WBLogInAlertView.h"
#define kSinaWeiboAppKey @"2274041630"
#define kSinaWeiboAppSecret @"5a196b338213ae1264af4566e7bba2b5"
@interface LH_SinaWeiboViewController : LH_BaseViewController
<
WBLogInAlertViewDelegate,
WBEngineDelegate
>
{
    //sina
	WBEngine                *weiboEngine;
	NSInteger               success;
	UIActivityIndicatorView *indicatorView;
    
@private
    UIImage                 *sendImage;
    NSString                *sendText;
}
//sina
@property (nonatomic,retain) WBEngine       *weiboEngine;
@property (nonatomic,retain) UIImage        *sendImage;
@property (nonatomic,  copy) NSString       *sendText;
- (void) willSendShareDataWithText:(NSString *)text image:(UIImage *)img;
//sina
- (void)shareMe:(id)sender;
@end

