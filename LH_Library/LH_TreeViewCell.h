//
//  LH_TreeViewCell.h
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LH_TreeNode.h"
@interface LH_TreeViewCell : UITableViewCell
{
    UIButton     *btnExpand;//按钮：用于展开子节点
	SEL          onExpand;//selector:点击“+”展开按钮时触发
	LH_TreeNode  *treeNode;//每个单元格表示一个节点
	UILabel      *label;//标签：显示节点title
	id           owner;//表示onExpand方法委托给哪个对象
	UIImageView  *imgIcon;//图标
	BOOL         isOnlyNode;
}

@property (assign) SEL          onExpand;
@property (retain) id           owner;
@property (retain) UIImageView  *imgIcon;
@property (assign) BOOL         isOnlyNode;
+ (int) indent;
+ (void)setIndent:(int)value;
+ (int)icoWidth;
+ (void)setIcoWidth:(int)value;
+ (int)icoHeight;
+ (void)setIcoHeight:(int)value;
+ (int)labelMarginLeft;
+ (void)setLabelMarginLeft:(int)value;
- (void)setTreeNode:(LH_TreeNode *)node;
- (int)getIndent;
@end
