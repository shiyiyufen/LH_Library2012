//
//  LH_TabbarViewController.h
//  YaPeiAppProject
//
//  Created by  on 12-9-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
static const NSString *LHTABBARITEMKEY_VIEWCONTROLLER = @"viewcontroller";
static const NSString *LHTABBARITEMKEY_IMAGENAME      = @"image";
static const NSString *LHTABBARITEMKEY_TITLE          = @"title";
static const NSString *LHTABBARITEMKEY_TAG            = @"tag";


@interface LH_TabbarViewController : UITabBarController
<UITabBarControllerDelegate>

//配置标签控制器的视图
- (void)loadViewSettingsWithArray:(NSMutableArray *)settings;

@end
