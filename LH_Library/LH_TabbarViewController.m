//
//  LH_TabbarViewController.m
//  YaPeiAppProject
//
//  Created by  on 12-9-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LH_TabbarViewController.h"
#import "LH_TabbarItem.h"
#import "LH_HtmlColor.h"

@implementation LH_TabbarViewController


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


//配置标签控制器的视图
- (void)loadViewSettingsWithArray:(NSMutableArray *)settings
{
    if (0 == [settings count]) return;
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSInteger count = [settings count];
    int i;
    LH_TabbarItem *item = nil;
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    for (i = 0; i < count; i ++)
    {
        NSDictionary *dictionary = [settings objectAtIndex:i];
        UIViewController *viewcontroller = [[dictionary objectForKey:LHTABBARITEMKEY_VIEWCONTROLLER] retain];
        
        item = [[LH_TabbarItem alloc] init];
        item.imageString = [dictionary objectForKey:LHTABBARITEMKEY_IMAGENAME];
        item.tag = [[dictionary objectForKey:LHTABBARITEMKEY_TAG] intValue];
        item.title = [dictionary objectForKey:LHTABBARITEMKEY_TITLE];
        [item setItemLabelColorInStateNormal:[UIColor whiteColor] stateSelectedColor:[LH_HtmlColor colorWithHexString:@"#2e97ff"]];
        
        viewcontroller.tabBarItem = item;
        viewcontroller.title = item.title;
        
        if (0 == i) 
        {
            self.title = item.title;
        }
        [item release];
        [viewControllers addObject:viewcontroller];
        [viewcontroller release];
    }
    [self setViewControllers:viewControllers];
    [viewControllers release];
    [pool drain];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    self.title = viewController.title;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
