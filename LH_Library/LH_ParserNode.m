//
//  LH_ParserNode.m
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import "LH_ParserNode.h"

#define STRIP(X)	[X stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
@implementation LH_ParserNode
@synthesize parentNode;
@synthesize children = _children;
@synthesize key = _key;
@synthesize leafValue = _leafValue;
@synthesize attributeDict = _attributeDict;
@synthesize isRootNode;

- (LH_ParserNode *) init
{
	if (self = [super init]) 
	{
		self.isRootNode = NO;
	}
	return self;
}

+ (LH_ParserNode *) treeNode
{
	return [[[self alloc] init] autorelease];
}


#pragma mark LH_ParserNode type routines
- (BOOL) isLeaf
{
	return (self.children.count == 0);
}

- (BOOL) hasLeafValue
{
	return (self.leafValue != nil);
}

#pragma mark LH_ParserNode data recovery routines

// Return an array of child keys. No recursion
- (NSArray *) keys
{
	NSMutableArray *results = [NSMutableArray array];
	for (LH_ParserNode *node in self.children) [results addObject:node.key];
	return results;
}

// Return an array of child keys with depth-first recursion.
- (NSArray *) allKeys
{
	NSMutableArray *results = [NSMutableArray array];
	for (LH_ParserNode *node in self.children) 
	{
		[results addObject:node.key];
		[results addObjectsFromArray:node.allKeys];
	}
	return results;
}

- (NSArray *) uniqArray: (NSArray *) anArray
{
	NSMutableArray *array = [NSMutableArray array];
	for (id object in [anArray sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)])
		if (![[array lastObject] isEqualToString:object]) [array addObject:object];
	return array;
}

// Return a sorted, uniq array of child keys. No recursion
- (NSArray *) uniqKeys
{
	return [self uniqArray:[self keys]];
}

// Return a sorted, uniq array of child keys. With depth-first recursion
- (NSArray *) uniqAllKeys
{
	return [self uniqArray:[self allKeys]];
}

// Return an array of child leaves. No recursion
- (NSArray *) leaves
{
	NSMutableArray *results = [NSMutableArray array];
	for (LH_ParserNode *node in self.children) if (node.leafValue) [results addObject:node.leafValue];
	return results;
}

// Return an array of child leaves with depth-first recursion.
- (NSArray *) allLeaves
{
	NSMutableArray *results = [NSMutableArray array];
	for (LH_ParserNode *node in self.children) 
	{
		if (node.leafValue) [results addObject:node.leafValue];
		[results addObjectsFromArray:node.allLeaves];
	}
	return results;
}

#pragma mark LH_ParserNode search and retrieve routines

// Return the first child that matches the key, searching recursively breadth first
- (LH_ParserNode *) objectForKey: (NSString *) aKey
{
	LH_ParserNode *result = nil;
	for (LH_ParserNode *node in self.children) 
		if ([node.key isEqualToString: aKey])
		{
			result = node;
			break;
		}
	if (result) return result;
	else return nil;
}

// Return the first leaf whose key is a match, searching recursively breadth first
- (NSString *) leafForKey: (NSString *) aKey
{
	LH_ParserNode *node = [self objectForKey:aKey];
	return node.leafValue;
}

// Return all children that match the key, including recursive depth first search.
- (NSMutableArray *) objectsForKey: (NSString *) aKey
{
	NSMutableArray *result = [NSMutableArray array];
	for (LH_ParserNode *node in self.children) 
	{
		if ([node.key isEqualToString: aKey]) [result addObject:node];
		[result addObjectsFromArray:[node objectsForKey:aKey]];
	}
	return result;
}

// Return all leaves that match the key, including recursive depth first search.
- (NSMutableArray *) leavesForKey: (NSString *) aKey
{
	NSMutableArray *result = [NSMutableArray array];
	for (LH_ParserNode *node in [self objectsForKey:aKey]) 
		if (node.leafValue)
			[result addObject:node.leafValue];
	return result;
}

// Follow a key path that matches each first found branch, returning object
- (LH_ParserNode *) objectForKeys: (NSArray *) keys
{
	if ([keys count] == 0) return self;
	
	NSMutableArray *nextArray = [NSMutableArray arrayWithArray:keys];
	[nextArray removeObjectAtIndex:0];
	
	for (LH_ParserNode *node in self.children)
	{
		NSLog(@"self.children:%@",node.key);
		if ([node.key isEqualToString:[keys objectAtIndex:0]])
			return [node objectForKeys:nextArray];
	}
	
	return nil;
}

// Follow a key path that matchLH_ParserNodees each first found branch, returning leaf
- (NSString *) leafForKeys: (NSArray *) keys
{
	LH_ParserNode *node = [self objectForKeys:keys];
	return node.leafValue;
}

#pragma mark output utilities

// Print out the tree
- (void) dumpAtIndent: (int) indent into:(NSMutableString *) outstring
{
	for (int i = 0; i < indent; i++) [outstring appendString:@"--"];
	
	[outstring appendFormat:@"[%2d] Key: %@ ", indent, self.key];
	if (self.leafValue) [outstring appendFormat:@"(%@)", STRIP(self.leafValue)];
	[outstring appendString:@"\n"];
	
	for (LH_ParserNode *node in self.children) [node dumpAtIndent:indent + 1 into: outstring];
}

- (NSString *) dump
{
	NSMutableString *outstring = [[NSMutableString alloc] init];
	[self dumpAtIndent:0 into:outstring];
	return [outstring autorelease];
}

#pragma mark conversion utilities
// When you're sure you're the parent of all leaves, transform to a dictionary
- (NSMutableDictionary *) dictionaryForChildren
{
	NSMutableDictionary *results = [NSMutableDictionary dictionary];
	
	for (LH_ParserNode *node in self.children)
		if (node.hasLeafValue) [results setObject:node.leafValue forKey:node.key];
	
	return results;
}

#pragma mark invocation forwarding

// Invocation Forwarding lets node act like array
- (id)forwardingTargetForSelector:(SEL)sel 
{ 
	if ([self.children respondsToSelector:sel]) return self.children; 
	return nil;
}

// Extend selector compliance
- (BOOL)respondsToSelector:(SEL)aSelector
{
	if ( [super respondsToSelector:aSelector] )	return YES;
	if ([self.children respondsToSelector:aSelector]) return YES;
	return NO;
}

// Allow posing as NSArray class for children
- (BOOL)isKindOfClass:(Class)aClass
{
	if (aClass == [LH_ParserNode class]) return YES;
	if ([super isKindOfClass:aClass]) return YES;
	if ([self.children isKindOfClass:aClass]) return YES;
	
	return NO;
}

#pragma mark cleanup
- (void) teardown
{
	for (LH_ParserNode *node in [[self.children copy] autorelease]) [node teardown];
	[self.parentNode.children removeObject:self];
	self.parentNode = nil;
}

- (void) dealloc
{
	self.parentNode = nil;
	self.children = nil;
	self.key = nil;
	self.leafValue = nil;
    self.attributeDict = nil;
	[super dealloc];
}

@end

