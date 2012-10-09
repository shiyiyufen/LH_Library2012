//
//  LH_InputButton.m
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LH_InputButton.h"

@implementation LH_InputButton

@synthesize inputView = _inputView;
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (void)dealloc
{
    [super dealloc];
}
@end
