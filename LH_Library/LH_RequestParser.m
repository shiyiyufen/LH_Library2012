//
//  LH_RequestParser.m
//  LH_Library
//
//  Created by  on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LH_RequestParser.h"


@implementation LH_RequestParser
@synthesize receivedata,messages;
@synthesize delegate = _delegate;
@synthesize currentIndex;

static const NSString *interfaceAddress = @"http://sccyls.iwanshang.com";

- (void)dealloc
{
    self.delegate = nil;
    self.messages = nil;
	self.receivedata = nil;
	[interfaceString release];
	interfaceString = nil;
	[super dealloc];
}

- (void)startDown
{
	if (![self isCancelled] && !willCancle) 
	{
		//异步
		connection_ = [[NSURLConnection connectionWithRequest:request delegate:self] retain];
        
        timer = [[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(check) userInfo:nil repeats:NO] retain];
	}
}

- (void)check
{
    if (!finished)
    {
        NSLog(@"cancle timer!!!!");
        [self cancleTimer];
        willCancle = YES;
		if (connection_)
		{
			[connection_ cancel];
		}
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (_delegate && [self.delegate respondsToSelector:@selector(didFinishDataLoading:atIndex:)])
        {
            [self.delegate didFailLoadDataAtIndex:self.currentIndex];
        }
    }
}

/*取消timer*/
- (void)cancleTimer
{
    if (timer || [timer isValid]) 
    {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)arequest redirectResponse:(NSURLResponse *)response
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	if ([self isCancelled] || willCancle)
	{
		[connection_ cancel];
		return nil;
	}
	return arequest;
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[receivedata setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	if ([self isCancelled] || willCancle) return;
	[receivedata appendData:data];
	data = nil;
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	finished = TRUE;
	[connection_ release];
	connection_ = nil;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	if ([self isCancelled] || willCancle) 
	{
		willCancle = NO;
		self.delegate = nil;
		return;
	}
	willCancle = NO;
	
	if (parser)
	{
		[parser release];
	}
	if (nil == messages)
	{
		messages = [[NSMutableArray alloc] init];
	}
	
	parser = [[LH_XMLParser alloc] init];
    NSLog(@"receivedata:%@",receivedata);
	LH_ParserNode *rootNode = [[parser parseXMLFromData:receivedata] retain];
    if (!rootNode) {
        [self.delegate didFailLoadDataAtIndex:self.currentIndex];
        [rootNode release];
        return;
    }
	NSMutableArray *resultArray = [[NSMutableArray alloc] init];
	NSAutoreleasePool *pool     = [[NSAutoreleasePool alloc] init];
	for (int i = 0;i < rootNode.children.count; i++)
	{
		LH_ParserNode *node  = [rootNode.children objectAtIndex:i];
		NSDictionary *dic = [self getNodeElementDic:node];
		NSLog(@"getNodeElementDic:%@",dic);
		if (!dic || [dic count] == 0) 
		{
			break;
		}
        if ([dic objectForKey:@"delete"]) 
        {
            continue;
        }
		NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:dic];
		[resultArray addObject:dictionary];
		[dictionary release];
		dictionary = nil;
	}
    [rootNode release];
	[pool release];
	
	if (_delegate && [self.delegate respondsToSelector:@selector(didFinishDataLoading: atIndex:)])
	{
		[self.delegate didFinishDataLoading:resultArray atIndex:self.currentIndex];
	}
	
	//NSLog(@"connection :%@ ",resultArray);
	[resultArray release];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"errorerror:%@",[error description]);
    [self.delegate didFailLoadDataAtIndex:self.currentIndex];
	[connection_ release];
	connection_ = nil;
    finished = TRUE;
}

/*
 组装xml字符串
 */
- (NSString *)setXMLWithParms:(NSDictionary *)parms
{
    if (nil == parms) return nil;
    NSMutableString *string = [[NSMutableString alloc] init];
    [string appendString:@"<from>"];
    int count = [parms count];
	if (count > 0)//有参数->组装参数
	{
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		for (id key in parms) 
		{
			[string appendFormat:@"<%@>%@</%@>",key,[parms objectForKey:key],key];
		}
        [pool release];
	}
    [string appendString:@"</from>"];
    return [string autorelease];
}

- (NSDictionary *)getNodeElementDic:(LH_ParserNode *)node
{
	NSMutableDictionary *myDic  = [[NSMutableDictionary alloc] init];
	if (node.children.count > 0)//有孩子节点，读取孩子节点内容
	{
		
		for (int i = 0; i < node.children.count; i ++)
		{
            NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
			LH_ParserNode *n = [node.children objectAtIndex:i];
			if ([n.key isEqualToString:@"systemMessage"])
			{
				[myDic release];
				myDic = [[NSMutableDictionary alloc] init];
				break;
			}else
			{
				if(n.children.count > 0)
				{
					NSDictionary *dic = [self getNodeElementDic:n];
					[myDic setObject:dic forKey:n.key];
				}else
				{
					if ([n.leafValue isEqualToString:@"--"] || !n.leafValue || n.leafValue == (id)[NSNull null] || n.leafValue.length == 0) 
					{
						[myDic setObject:@"" forKey:n.key];
					}else 
					{
						[myDic setObject:n.leafValue forKey:n.key];
					}
				}
			}
            [pool release];
		}
	}else//没有孩子节点，直接读取值
	{
		if ([node.key isEqualToString:@"systemMessage"])
		{
			[myDic release];
			myDic = [[NSMutableDictionary alloc] init];
		}else
		{
			if ([node.leafValue isEqualToString:@"--"] || !node.leafValue || node.leafValue == (id)[NSNull null] || node.leafValue.length == 0) 
			{
				[myDic setObject:@"" forKey:node.key];
			}else 
			{
				[myDic setObject:node.leafValue forKey:node.key];
			}
		}
	}
	return [myDic autorelease];
}

/*建立同步连接并返回数据*/
- (NSArray *)requestSynchConnectWithAddress:(NSString *)subaddress
                                      parms:(NSDictionary *)parms
{
    NSString *xml = [[NSString alloc] initWithFormat:@"%@%@",interfaceAddress,subaddress];
	NSLog(@"xmlc 12345:%@",xml);
	subaddress = nil;
	NSMutableURLRequest *myRequest = [[NSMutableURLRequest alloc]init];
	[myRequest setURL:[NSURL URLWithString:xml]];
	[myRequest setHTTPMethod:@"POST"];//请求方式
	[myRequest addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    [myRequest setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    
	//数据流
	NSMutableData *data = [NSMutableData data];//要发送的xml数据
    NSString *send = [[self setXMLWithParms:parms] retain];NSLog(@"setXMLWithParms:%@",send);
    parms = nil;
    if (send)
    {
        [data appendData:[send dataUsingEncoding:NSUTF8StringEncoding]];//utf-8编码
    }
    [send release];
    send = nil;
	[myRequest setHTTPBody:data];
	[xml release];
	xml = nil;
    
	NSHTTPURLResponse* urlResponse = nil;
	NSData *responseData = [NSURLConnection sendSynchronousRequest:myRequest 
												 returningResponse:&urlResponse error:nil];  
	NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"result:%@",result);
	[myRequest release];
	if ([urlResponse statusCode] < 200 || [urlResponse statusCode] >= 300)
    {
        NSLog(@"远程服务器出错!");
        [result release];
        result = nil;
		return nil;
	}else
    {
		NSData *data = [NSData dataWithBytes:[result UTF8String] length:[result length]];
        if (parser)
        {
            [parser release];
        }
        parser = [[LH_XMLParser alloc] init];
        LH_ParserNode *rootNode = [parser parseXMLFromData:data];
        NSMutableArray *resultArray = [[NSMutableArray alloc] init];
        
        for (int i = 0;i < rootNode.children.count; i++)
        {
            NSAutoreleasePool *pool     = [[NSAutoreleasePool alloc] init];
            LH_ParserNode *node  = [rootNode.children objectAtIndex:i];
            NSDictionary *dic = [self getNodeElementDic:node];
            NSLog(@"getNodeElementDic:%@",dic);
            if (!dic || [dic count] == 0) 
            {
                break;
            }
            NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:dic];
            [resultArray addObject:dictionary];
            [dictionary release];
            dictionary = nil;
            [pool release];
        }
        
		[result release];
        result = nil;
		return [resultArray autorelease];
	}
}

- (void)buildConnectWithRequestAddress:(NSString *)address
                                 parms:(NSDictionary *)parms
                              delegate:(id)target
{
	willCancle = NO;
	NSString *xml = [[NSString alloc] initWithFormat:@"%@%@",interfaceAddress,[address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSLog(@"xml eee:%@",xml);
	
	request = [[NSMutableURLRequest alloc]init];
	[request setURL:[NSURL URLWithString:xml]];
	[request setHTTPMethod:@"POST"];//请求方式
	[request addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    
	//数据流
	NSMutableData *data = [NSMutableData data];//要发送的xml数据
    NSString *send = [[self setXMLWithParms:parms] retain];
	[data appendData:[send dataUsingEncoding:NSUTF8StringEncoding]];//utf-8编码
    [send release];
    send = nil;
	[request setHTTPBody:data];
	[xml release];
	xml = nil;
	
	self.delegate = target;
	receivedata = [[NSMutableData data] retain];
} 

-(BOOL)isConcurrent 
{
    //返回yes表示支持异步调用，否则为支持同步调用
    return YES;
}

- (BOOL)isExecuting
{
    return connection_ == nil; 
}

- (BOOL)isFinished
{
    return connection_ == nil;  
}

- (void)cancel
{
	if (![self isCancelled] || !willCancle )
	{
		willCancle = YES;
        finished = YES;
		if (connection_)
		{
			[connection_ cancel];
		}
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	}
	[super cancel];
}

- (void)main
{
	[super main];
	// do a little work
    if ([self isCancelled] || willCancle) 
	{
		return; 
	}
    // do a little more work
    if ([self isCancelled] || willCancle)
	{
		return; 
	}
}

@end

