//
//  LH_TreeViewController.h
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LH_TreeNode.h"
#import "LH_TreeViewCell.h"

@protocol getChildNodeArrayDelegate;
@interface LH_TreeViewController : UITableViewController 
<UITableViewDelegate,UITableViewDataSource>
{
	LH_TreeNode        *tree;
	NSMutableArray  *nodes;
@private
	id <getChildNodeArrayDelegate> g_delegate;
}
@property (nonatomic,assign) id g_delegate;
/*
 如果你想呈现自己的树，在子类中覆盖此方法
 */
- (void)initTree;
/*
 如果你想在选中某一个节点时，发生自定义行为，在子类中覆盖此方法
 */
- (void)onSelectedRow:(NSIndexPath *)indexPath :(LH_TreeNode *)node;
/*
 如果你想定义自己的单元格视图（比如更换默认的文件夹图标），在子类中覆盖此方法
*/
- (void)configCell:(LH_TreeViewCell *)cell :(LH_TreeNode *)node;
@end

@protocol getChildNodeArrayDelegate<NSObject>
@optional
/*
 请求子分类数据
 */
- (NSArray *)willRequestSubClassifyDataWithPreId:(NSString *)preid fatherKey:(NSString *)f_key;
@end
