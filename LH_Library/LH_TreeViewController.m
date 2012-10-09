//
//  LH_TreeViewController.m
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LH_TreeViewController.h"

@implementation LH_TreeViewController
@synthesize g_delegate;

static const int kClassifyCellHeight = 56;
static const int kImageView1 = 2012;
static const int kImageView2 = 2013;
static const int kFengeTag   = 2014;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self performSelector:@selector(createBackImageView)];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)createBackImageView
{
    UIImage *img1 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"back.png" ofType:nil] ];
    UIImageView *imageview1 = [[UIImageView alloc] initWithImage:img1];
    imageview1.frame = CGRectMake(0, 64, 320, 416);
    imageview1.tag   = kImageView1;
    [self.navigationController.view addSubview:imageview1];
    [imageview1 release];
    
    UIImage *img2 = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"book.png" ofType:nil] ];
    UIImageView *imageview2 = [[UIImageView alloc] initWithImage:img2];
    imageview2.frame = CGRectMake(0, 64, 320, 416);
    imageview2.tag   = kImageView2;
    [self.navigationController.view addSubview:imageview2];
    [imageview2 release];
    imageview1.userInteractionEnabled = YES;
    imageview2.userInteractionEnabled = YES;
    
    //[self.navigationController.view sendSubviewToBack:<#(UIView *)#>];
    [self.navigationController.view sendSubviewToBack:imageview2];
    [self.navigationController.view sendSubviewToBack:imageview1];
}

#pragma mark ===subclass to override methods===
//如果你想呈现自己的树，在子类中覆盖此方法
- (void)initTree
{
	NSLog(@"you need init your tree nodes");
}

//如果你想在选中某一个节点时，发生自定义行为，在子类中覆盖此方法
- (void)onSelectedRow:(NSIndexPath*)indexPath :(LH_TreeNode *)node
{
	NSLog(@"you need rewrite your onSelectedRow: : method");
}

//如果你想定义自己的单元格视图（比如更换默认的文件夹图标），在子类中覆盖此方法
- (void)configCell:(LH_TreeViewCell *)cell :(LH_TreeNode *)node
{
	//NSLog(@"initCell---key:%@,title:%@",node.key,node.title);
}

#pragma mark ===table view datasource methods====
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	return nodes.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString* cellid = @"cell";
	LH_TreeViewCell* cell = (LH_TreeViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
    LH_TreeNode *node = [nodes objectAtIndex:indexPath.row];
	if (cell==nil) 
	{
		cell=[[[LH_TreeViewCell alloc]initWithStyle:UITableViewCellStyleDefault
								 reuseIdentifier:cellid]autorelease];
        
        int height = 0;
        if([node isFatherNode])
        {
            height = 80;
        }else
        {
            height = kClassifyCellHeight;
        }
        
        UIImageView *fenge = [[UIImageView alloc] init];
        fenge.image = [UIImage imageNamed:@"fenge.png"];
        fenge.tag   = kFengeTag;
        fenge.frame = CGRectMake(0, height - 1, tableView.frame.size.width, 1);
        [cell addSubview:fenge];
        [fenge release];
        
        UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b_d_cell.png"]];
        cell.selectedBackgroundView = bg;
        [bg release];
	}
	
    UIImageView *fenge = (UIImageView *)[cell viewWithTag:kFengeTag];
    [fenge retain];
    if (fenge)
    {
        int height = 0;
        if([node isFatherNode])
        {
            height = 80;
        }else
        {
            height = kClassifyCellHeight;
        }
        fenge.frame = CGRectMake(0, height - 1, tableView.frame.size.width, 1);
    }
    [fenge release];
	
    [cell setIsOnlyNode:node.isOnlyNode];
	[cell setOwner:self];
	[cell setOnExpand:@selector(onExpand:)];
	[cell setTreeNode:node];
    
	[self configCell:cell :node];
	if (![node isFatherNode])
	{
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
	}
	return cell;
}

#pragma mark ===table view delegate methods===
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	LH_TreeNode *node = [nodes objectAtIndex:indexPath.row];
	if (![node isFatherNode] || node.isOnlyNode)
	{
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        UIImageView *img1 = (UIImageView *)[self.navigationController.view viewWithTag:kImageView1];
        if (img1) 
        {
            [img1 removeFromSuperview];
        }
        UIImageView *img2 = (UIImageView *)[self.navigationController.view viewWithTag:kImageView2];
        if (img2) 
        {
            [img2 removeFromSuperview];
        }
        [pool drain];
        
		[self onSelectedRow:indexPath :node];
        
	}else
	{
		[self performSelector:@selector(onExpand:) withObject:node];
	}
    
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LH_TreeNode* node = [nodes objectAtIndex:indexPath.row];
	if([node isFatherNode])
	{
		return 80;
	}
	return kClassifyCellHeight;
}

#pragma mark -
-(void)onExpand:(LH_TreeNode *)node
{
    int number = node.childrenCount;
    if (number > 0)
    {
        [node removeAllChildren];
    }
	
	if ([self.g_delegate respondsToSelector:@selector(willRequestSubClassifyDataWithPreId:fatherKey:)])
	{
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		NSArray *array = [self.g_delegate willRequestSubClassifyDataWithPreId:node.key fatherKey:node.fatherKey];
		int count = [array count];
		NSLog(@"nodecount:%d",count);
		for (int i = 0; i < count; i ++)
		{
			NSDictionary *dictionary = [array objectAtIndex:i];
			LH_TreeNode *treeNode = [[LH_TreeNode alloc]init];
			treeNode.title     = [dictionary objectForKey:@"title"];
			treeNode.key       = [dictionary objectForKey:@"link"];
			treeNode.isFatherNode = NO;
			[node addChild:treeNode];
			[treeNode release];
		}
		[pool release];
	}
    
    if (0 != node.childrenCount || number != node.childrenCount)
    {
        node.expanded = !node.expanded;
    }
	nodes = [[NSMutableArray alloc]init];
	[LH_TreeNode getNodes:tree :nodes];
	NSLog(@"nodes:%d",nodes.count);
    
	[self.tableView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    UIImageView *img1 = (UIImageView *)[self.navigationController.view viewWithTag:kImageView1];
    if (img1) 
    {
        [img1 removeFromSuperview];
    }
    UIImageView *img2 = (UIImageView *)[self.navigationController.view viewWithTag:kImageView2];
    if (img2) 
    {
        [img2 removeFromSuperview];
    }
    [pool drain];
}

-(void)dealloc{
	[tree release];
	[nodes release];
	self.g_delegate = nil;
	[super dealloc];
}

@end
