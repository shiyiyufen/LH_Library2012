//
//  LH_SearchBar.m
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LH_SearchBar.h"
#import <QuartzCore/QuartzCore.h>
#import "LH_HtmlColor.h"
@implementation LH_SearchBar

@synthesize searchBarBackGroundImageString,cancelButtonBackImageString;

- (void)dealloc
{
    self.searchBarBackGroundImageString = nil;
    self.cancelButtonBackImageString    = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialization code
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        //init code
    }
    return self;
}

- (void)setSearchBarBackGroundImageString:(NSString *)_searchBarBackGroundImageString
{
    if (nil == searchBarBackGroundImageString || ![_searchBarBackGroundImageString isEqualToString:searchBarBackGroundImageString]) 
    {
        [searchBarBackGroundImageString release];
        searchBarBackGroundImageString = [_searchBarBackGroundImageString copy];
        
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		for (UIView *subview in self.subviews)
		{
			if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) 
			{
				UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
				backgroundView.image = [UIImage imageNamed:searchBarBackGroundImageString];
				[self insertSubview:backgroundView aboveSubview:subview];
				[backgroundView release];
				[subview removeFromSuperview];
				break;
			}
		}
		[pool release];
    }
}

- (void)setShowsCancelButton:(BOOL)showsCancelButton animated:(BOOL)animated
{
	[super setShowsCancelButton:showsCancelButton animated:animated];
    if (nil == cancelButtonBackImageString) return;
    
	if (showsCancelButton) 
	{
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		for(UIView *v in self.subviews)
		{
			if ([v isKindOfClass:[UIButton class]])
			{
                UIButton *btn = (UIButton *)v;
                //v.frame = CGRectMake(btn.frame.origin.x - 20, btn.frame.origin.y, 64, 34);
				[btn setTitle:@"取 消" forState:UIControlStateNormal];
				[btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
                [btn setTitleColor:[LH_HtmlColor colorWithHexString:@"#9a520b"] forState:UIControlStateNormal];
				btn.layer.cornerRadius = 2.0f;
				btn.layer.masksToBounds = YES;
                
                NSString *mainPath = [[NSBundle mainBundle] resourcePath];
                
                NSString *path  = [[NSString alloc] initWithFormat:@"%@/%@.png",mainPath,cancelButtonBackImageString];
                NSString *path1 = [[NSString alloc] initWithFormat:@"%@/%@1.png",mainPath,cancelButtonBackImageString];
                
				[btn setBackgroundImage:[UIImage imageWithContentsOfFile:path]  forState:UIControlStateNormal];
				[btn setBackgroundImage:[UIImage imageWithContentsOfFile:path1] forState:UIControlStateHighlighted];
                
                [path release];
                [path1 release];
				break;
			}
		}
		[pool release];
	}
	
}
@end