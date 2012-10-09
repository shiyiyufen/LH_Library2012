
//
//  LH_ParserNode.h
//  CompanyMailProject
//
//  Created by apple on 12-7-3.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
/*
 1、teardown：清除所有节点
 2、isLeaf：判断是否是叶子节点
 3、hasLeafValue：判断节点是否有值
 4、- (NSArray *) leaves：返回节点的所有一级子节点值
 5、- (NSArray *) allLeaves：返回节点的所有子节点的值
 6、keys; 返回节点所有一级子节点名称。
 7、 allKeys; 返回节点所有子节点名称。
 8、 uniqKeys;返回节点一级子节点名称，不重复。
 9、uniqAllKeys;返回节点子节点名称，不重复。
 10、- (TreeNode *) objectForKey：根据节点名称查询节点
 11、- (NSString *) leafForKey: (NSString *) aKey：根据节点名称查询出节点的值
 12、- (NSMutableArray *) objectsForKey: (NSString *) aKey;根据节点名称查询出所以满足条件的节点
 13、- (NSMutableArray *) leavesForKey: (NSString *) aKey;根据节点名称查询出所以满足条件的节点的值
 14、- (TreeNode *) objectForKeys: (NSArray *) keys;：根据节点名称路径查询出第一个满足条件的节点。
 15、- (NSString *) leafForKeys: (NSArray *) keys 根据节点名称路径查询出第一个满足条件的节点的值。
 16、- (NSMutableDictionary *) dictionaryForChildren：将树转换成dictionary
 */
#import <Foundation/Foundation.h>


@interface LH_ParserNode : NSObject 
{
	LH_ParserNode     *parentNode;
	NSMutableArray *_children;
	NSString       *_key;
	NSString       *_leafValue;
	NSDictionary   *_attributeDict;
	BOOL           isRootNode;
}
@property (nonatomic,assign) BOOL           isRootNode;
@property (nonatomic,retain) LH_ParserNode     *parentNode;
@property (nonatomic,retain) NSMutableArray *children;
@property (nonatomic,retain) NSString       *key;
@property (nonatomic,retain) NSString       *leafValue;
@property (nonatomic,retain) NSDictionary   *attributeDict;

@property (nonatomic, readonly) BOOL			isLeaf;
@property (nonatomic, readonly) BOOL			hasLeafValue;

@property (nonatomic, readonly) NSArray			*keys;
@property (nonatomic, readonly) NSArray			*allKeys;
@property (nonatomic, readonly) NSArray			*uniqKeys;
@property (nonatomic, readonly) NSArray			*uniqAllKeys;
@property (nonatomic, readonly) NSArray			*leaves;
@property (nonatomic, readonly) NSArray			*allLeaves;

@property (nonatomic, readonly) NSString		*dump;


+ (LH_ParserNode *) treeNode;
- (NSString *) dump;
- (void) teardown;

// Leaf Utils
- (BOOL) isLeaf;
- (BOOL) hasLeafValue;
- (NSArray *) leaves;
- (NSArray *) allLeaves;

// Key Utils
- (NSArray *) keys; 
- (NSArray *) allKeys; 
- (NSArray *) uniqKeys;
- (NSArray *) uniqAllKeys;


// Search Utils
- (LH_ParserNode *) objectForKey: (NSString *) aKey;
- (NSString *) leafForKey: (NSString *) aKey;
- (NSMutableArray *) objectsForKey: (NSString *) aKey;
- (NSMutableArray *) leavesForKey: (NSString *) aKey;
- (LH_ParserNode *) objectForKeys: (NSArray *) keys;
- (NSString *) leafForKeys: (NSArray *) keys;

// Convert Utils
- (NSMutableDictionary *) dictionaryForChildren;
@end

