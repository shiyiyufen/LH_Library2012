//
//  LH_TreeNode.m
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LH_TreeNode.h"

@implementation LH_TreeNode
@synthesize p_node,children,data,title,key,fatherKey,expanded,hidden,isFatherNode,isOnlyNode;
- (void)dealloc
{
	self.p_node   = nil;
	self.children = nil;
	self.data     = nil;
	self.title    = nil;
	self.key      = nil;
	self.fatherKey = nil;
	[super dealloc];
}

-(id)init
{
	if (self=[super init]) 
	{
		p_node   = nil;
		children = nil;
		key      = nil;
        fatherKey = nil;
        isOnlyNode = NO;
	}
	return self;
}

-(void)setDeep:(int)value
{
	deep = value;
}

-(void)addChild:(LH_TreeNode *)child
{
	if (children == nil)
	{
		children = [[NSMutableArray alloc] init];
	}
	child.p_node = self;	
	[children addObject:child];
}
- (void)removeAllChildren
{
	self.children = nil;
}

- (int)childrenCount
{
	return children==nil?0:self.children.count;
}

- (int)deep
{
	return p_node==nil?0:p_node.deep+1;
}

- (BOOL)hasChildren
{
	if(children==nil || self.children.count==0)
		return NO;
	else return YES;
}

+ (LH_TreeNode *)findNodeByKey:(NSString*)_key :(LH_TreeNode *)node
{
	if ([_key isEqualToString:[node key]]) 
	{//如果node就匹配，返回node
		return node;
	}else if([node hasChildren])
	{//如果node有子节点，查找node 的子节点		
		for(LH_TreeNode *each in [node children])
		{
			//NSLog(@"retrieve node:%@ %@",each.title,each.key);
			LH_TreeNode *a = [LH_TreeNode findNodeByKey:_key :each];
			if (a != nil) 
			{
				return a;
			}
		}
	}
	//如果node没有子节点,则查找终止,返回nil
	return nil;		
}
+ (void)getNodes:(LH_TreeNode *)root :(NSMutableArray*) array
{
	if(![root hidden])
	{    //只有节点被设置为“不隐藏”的时候才返回节点
		[array addObject:root];
		NSLog(@"root:%@",root);
	}
	if ([root hasChildren] && [root expanded])//是父节点
	{
		NSLog(@"hasChildren:%@",[root children]);
		for(LH_TreeNode *each in [root children])
		{
			[LH_TreeNode getNodes:each :array];
		}
	}
	return;
}

@end
