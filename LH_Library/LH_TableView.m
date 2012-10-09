//
//  LH_TableView.m
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LH_TableView.h"

@implementation LH_TableView

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Initialization code
        self.backgroundColor                = [UIColor clearColor];
		self.separatorStyle                 = UITableViewCellSeparatorStyleNone;
		self.showsVerticalScrollIndicator   = YES;
		self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
