//
//  LH_XMLParser.h
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LH_ParserNode.h"
@interface LH_XMLParser : NSObject
<NSXMLParserDelegate>
{
	NSMutableArray		*stack;
	NSString            *currentItem;
}

+ (LH_XMLParser *) sharedInstance;
- (LH_ParserNode *) parseXMLFromURL: (NSURL *) url;
- (LH_ParserNode *) parseXMLFromData: (NSData*) data;
@end
