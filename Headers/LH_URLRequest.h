//
//  LH_URLRequest.h
//  LH_Library
//
//  Created by  on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
enum LHRequestKind
{
    LHRequestKindNormal = 541114,
    LHRequestKindWebView
};

@interface LH_URLRequest : NSURLRequest
{
    enum LHRequestKind _requestKind;//区别是不是webview请求
}
@property (assign, nonatomic) enum LHRequestKind requestKind;
@end
