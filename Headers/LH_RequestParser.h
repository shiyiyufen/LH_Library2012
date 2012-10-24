//
//  LH_RequestParser.h
//  LH_Library
//
//  Created by  on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LH_XMLParser.h"
@protocol LH_RequestParserDelegate;
@interface LH_RequestParser : NSOperation 
<NSXMLParserDelegate>
{
    @private
    NSMutableURLRequest       *request;
	NSURLConnection    *connection_;
	BOOL               willCancle;
	NSInteger          currentIndex;//传递参数
	
	id <LH_RequestParserDelegate> _delegate;
	NSString            *interfaceString;//消息借口
	NSMutableData       *receivedata;
	BOOL                finished;
	LH_XMLParser         *parser;
	NSMutableArray      *messages;
    NSTimer             *timer;
    NSString            *_requestBaseURL;//域名
}

@property (nonatomic,assign) NSInteger           currentIndex;//传递参数
@property (nonatomic,assign) id                  delegate;
@property (nonatomic,retain) NSMutableArray      *messages;
@property (nonatomic,retain) NSMutableData       *receivedata;
@property (nonatomic,copy  ) NSString            *requestBaseURL;

/*开始下载*/
- (void)startDown;
/*取消timer*/
- (void)cancleTimer;

/*
 组装xml字符串
 */
- (NSString *)setXMLWithParms:(NSDictionary *)parms;

/*建立同步连接并返回数据*/
- (NSArray *)requestSynchConnectWithAddress:(NSString *)address
                                      parms:(NSDictionary *)parms;

/*
 建立异步连接
 */
- (void)buildConnectWithRequestAddress:(NSString *)address
                                 parms:(NSDictionary *)parms
                              delegate:(id)target;

/*
 内部使用，获取每个节点值，递归
 */
- (NSDictionary *)getNodeElementDic:(LH_ParserNode *)node;
@end

@protocol LH_RequestParserDelegate <NSObject>;

//finish
- (void)didFinishDataLoading:(NSMutableArray *)array atIndex:(NSInteger)index;

//error
- (void)didFailLoadDataAtIndex:(NSInteger)index;
@end

