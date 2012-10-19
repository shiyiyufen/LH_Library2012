//
//  LH_WebView.h
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LH_WebView : UIWebView
{
    @private
    BOOL     _checkImgURLEnabled;//是否检测图片名称是否带域名，需要导入RegexKitLite.h,RegexKitLite.m,libicucore.dylib
    NSString *_baseURL;//父url
    NSArray  *_imageNames;//html代码所有的图片名称
    NSArray  *_imageNotWebURLHeaderNames;//html代码所有没有带域名的图片名称
}
@property (assign, nonatomic) BOOL checkImgURLEnabled;
@property (copy  , nonatomic) NSString *baseURL;
@property (readonly,retain,nonatomic) NSArray  *imageNames;
@property (readonly,retain,nonatomic) NSArray  *imageNotWebURLHeaderNames;
@end
