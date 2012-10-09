//
//  LH_BarButtonItem.h
//  LH_Library
//
//  Created by  on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 自定义BarButtonItem，实现customview
 */
@interface LH_BarButtonItem : UIBarButtonItem

//初始化UIBarButtonItem
- (id)initWithTarget:(id)target action:(SEL)action image:(NSString *)aimage title:(NSString *)atitle;
@end
