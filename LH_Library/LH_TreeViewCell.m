//
//  LH_TreeViewCell.m
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LH_TreeViewCell.h"
#import "LH_HtmlColor.h"
static int indent     = 15;//默认缩进值15
static int icoHeight  = 32;//默认图标32高
static int icoWidth   = 32;//默认图标32宽
static int labelMarginLeft = 2;//默认标签左边留空2
@implementation LH_TreeViewCell
@synthesize onExpand,imgIcon,owner,isOnlyNode;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) 
	{
        
        //        UIView *selector = [[UIView alloc] init];
        //        selector.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@".png"]];
        //        cell.selectedBackgroundView = selector;
        //        [selector release];
    }
    return self;
}

+ (int)indent
{
	return indent;
}

+ (void)setIndent:(int)value
{
	indent=value;
}

+ (int)icoWidth
{
	return icoWidth;
}

+ (void)setIcoWidth:(int)value
{
	icoWidth=value;
}

+ (int)icoHeight
{
	return icoHeight;
}

+ (void)setIcoHeight:(int)value
{
	icoHeight=value;
}

+ (int)labelMarginLeft
{
	return labelMarginLeft;
}

+ (void)setLabelMarginLeft:(int)value
{
	labelMarginLeft=value;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)onExpand:(id)sender
{
    if (isOnlyNode) return;
	treeNode.expanded=!treeNode.expanded;//切换“展开/收起”状态
	if(treeNode.expanded)
	{//若展开状态设置“+/-”号图标
		[btnExpand setImage:[UIImage imageNamed:@"sharpD.png"] forState:UIControlStateNormal];
	}else 
	{
		[btnExpand setImage:[UIImage imageNamed:@"sharpR.png"] forState:UIControlStateNormal];
	}
	if(owner!=nil && onExpand!=nil)//若用户设置了onExpand属性则调用
		[owner performSelector:onExpand withObject:treeNode];
}

- (int)getIndent
{
	return indent;
}

- (void)setTreeNode:(LH_TreeNode *)node
{
	treeNode=node;
	if (label==nil)
	{
		btnExpand=[[UIButton alloc]initWithFrame:CGRectMake(270, 30, 20, 20)];
		[btnExpand addTarget:self action:@selector(onExpand:)
			forControlEvents:UIControlEventTouchUpInside];
		label=[[UILabel alloc] init];
		[self addSubview:label];
		[self addSubview:btnExpand];
	}else 
	{
		[btnExpand setFrame:CGRectMake(270, 30, 20, 20)];
		[label setFrame:CGRectMake(32+labelMarginLeft+icoWidth+(indent*node.deep), 0, 200, 36)];
	}
	if ([node isFatherNode])
	{
		NSLog(@"node has children");
		label.frame = CGRectMake(20, 20, 200,40);
		label.font = [UIFont boldSystemFontOfSize:18];
		label.textColor = [LH_HtmlColor colorWithHexString:@"#9a520b"];
		if ([node expanded]) 
		{
			[btnExpand setImage:[UIImage imageNamed:@"sharpD.png"] forState:UIControlStateNormal];
		}else 
		{
			UIImage *img=[UIImage imageNamed:@"sharpR.png"];
			//NSLog(@"%d",img==nil);
			[btnExpand setImage:img forState:UIControlStateNormal];
		}
	}else
	{
		label.textColor = [UIColor lightGrayColor];
		label.frame = CGRectMake(60, 5, 200,30);
		label.font = [UIFont systemFontOfSize:14];
		[btnExpand setImage:nil forState:UIControlStateNormal];
	}
	[label setText:node.title];
}
- (void)dealloc {
    [super dealloc];
}
@end
