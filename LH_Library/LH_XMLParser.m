//
//  LH_XMLParser.m
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LH_XMLParser.h"
@implementation LH_XMLParser
static LH_XMLParser *sharedInstance = nil;

// Use just one parser instance at any time
+(LH_XMLParser *) sharedInstance 
{
    if(!sharedInstance) {
		sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

// Parser returns the tree root. You may have to go down one node to the real results
- (LH_ParserNode *) parse: (NSXMLParser *) parser
{
	stack = [NSMutableArray array];
	
	LH_ParserNode *root = [LH_ParserNode treeNode];
	root.parentNode = nil;
	root.leafValue = nil;
	root.children = [NSMutableArray array];
	
	[stack addObject:root];
	
	[parser setDelegate:self];
	[parser parse];
    [parser release];
    
    NSLog(@"root children :%@",root.children);
	// pop down to real root
	LH_ParserNode *realroot = [[root children] lastObject];
	root.children = nil;
	root.parentNode = nil;
	root.leafValue = nil;
	root.key = nil;
	//NSString * result212 =  [realroot leafForKey:@"name"];
    //	NSLog(@"result212:%@",result212);
	realroot.parentNode = nil;
	return realroot;
}


- (LH_ParserNode *)parseXMLFromURL: (NSURL *) url
{	
	LH_ParserNode *results;
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
	results = [self parse:parser];
	[pool drain];
	return results;
}

- (LH_ParserNode *)parseXMLFromData: (NSData *) data
{	
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSRange range = [result rangeOfString:@"html"];
    if (range.location != NSNotFound)
    {
        [result release];
        result = nil;
        return nil;
    }
    [result release];
    result = nil;
    
	LH_ParserNode *results;
	//NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
	results = [[self parse:parser] retain];
    // [parser release];
	//[pool drain];
	return [results autorelease];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
	currentItem = nil;
}

// Descend to a new element
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) elementName = qName;
	currentItem = elementName;
	NSLog(@"elementName:%@",elementName);
    
	LH_ParserNode *leaf = [[LH_ParserNode treeNode] retain];
	leaf.parentNode = [stack lastObject];
	[(NSMutableArray *)[[stack lastObject] children] addObject:leaf];
	if ([elementName isEqualToString:@"channel"])
	{
		leaf.isRootNode = YES;
	}else
	{
		leaf.isRootNode = NO;
	}
	leaf.attributeDict = [[NSDictionary alloc] initWithDictionary:attributeDict];
	leaf.key = [NSString stringWithString:elementName];
	leaf.leafValue = nil;
	leaf.children = [NSMutableArray array];
	
	[stack addObject:leaf];
    [leaf release];
}

// Pop after finishing element
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	//if ([elementName isEqualToString:@"BasfMessage"])
    //	{
    //		return;
    //	}
	currentItem = nil;
	[stack removeLastObject];
}

// Reached a leaf
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	NSString *utf8String = [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	string = nil;
	//NSLog(@"utf8String : %@",utf8String);
	if ([utf8String isEqualToString:@"systemMessage"])
	{
		utf8String = @" ";
	}
	if (![[stack lastObject] leafValue])
	{
		[[stack lastObject] setLeafValue:utf8String];
		return;
	}
	[[stack lastObject] setLeafValue:[NSString stringWithFormat:@"%@%@", [[stack lastObject] leafValue], utf8String]];
}

@end
