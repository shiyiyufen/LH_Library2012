//
//  LH_TreeNode.h
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LH_TreeNode : NSObject
{
    LH_TreeNode    *p_node;//父节点
	NSMutableArray *children;//子节点
	id             data;//节点可以包含任意数据
	NSString       *title;//节点要显示的文字
	NSString       *key;//主键，在树中唯一
    NSString       *fatherKey;
	BOOL           expanded;//标志：节点是否已展开，保留给TreeViewCell使用的
	BOOL           isFatherNode;
    BOOL           isOnlyNode;
	BOOL           hidden;//标志，节点是否隐藏
	int            deep;//节点位于树的第几层,TreeViewCell使用
}
//节点本身不负责内存管理！使用assign(引用计数器不会改变),调用者实例化时需要自己retain
@property (nonatomic,retain) LH_TreeNode  *p_node;
@property (nonatomic,retain) id        data;
@property (nonatomic,retain) NSString  *title,*key,*fatherKey;
@property (nonatomic,assign) BOOL      expanded,hidden,isFatherNode,isOnlyNode;
@property (nonatomic,retain) NSMutableArray* children;
- (int) deep;
- (void)setDeep:(int)value;
//hasChildren的访问方法
- (BOOL)hasChildren;
//子节点的添加方法
- (void)addChild:(LH_TreeNode *)child;
- (void)removeAllChildren;
- (int)childrenCount;
+ (LH_TreeNode *)findNodeByKey:(NSString *)_key :(LH_TreeNode *)node;
+ (void)getNodes:(LH_TreeNode *)root :(NSMutableArray *) array;
@end
