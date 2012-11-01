//
//  LH_ShareWeiboViewController.h
//  LH_Library
//
//  Created by  on 12-10-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LH_BaseViewController.h"
#import "SinaWeiboRequest.h"
#import "SinaWeibo.h"
@class SinaWeibo;
@interface LH_ShareWeiboViewController : LH_BaseViewController
<SinaWeiboDelegate,
SinaWeiboRequestDelegate
>{
    SinaWeibo *_sinaweibo;
    @private
    NSString  *_shareText;//分享的文本内容
    NSString  *_shareImageUrl;//分享的图片网络地址
    UIImage   *_shareImage;//分享的图片
}
@property (copy  , nonatomic) NSString *shareText;
@property (copy  , nonatomic) NSString *shareImageUrl;
@property (retain, nonatomic) UIImage  *shareImage;

@property (readonly, nonatomic) SinaWeibo *sinaweibo;
//初始化新浪weibo 
- (void)initSinaWeiboWithAppKey:(NSString *)appkey appSecret:(NSString *)appsecret appRedirectURI:(NSString *)redirecturl delegate:(id)delegate;
//分享新浪微博->图片
- (BOOL)shareSinaWeiboWithText:(NSString *)text image:(UIImage *)image;
//分享新浪微博->图片
- (BOOL)shareSinaWeiboWithText:(NSString *)text imageURL:(NSString *)imageurl;
@end
