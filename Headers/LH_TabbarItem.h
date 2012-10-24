//
//  LH_TabbarItem.h
//  LH_Library
//
//  Created by  on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LH_TabbarItem : UITabBarItem 
{
	NSString *imageString;//按与未按的图片，共同的名称，后加1
}

@property (nonatomic,   copy) NSString *imageString;
- (id)initWithTitle:(NSString *)title tag:(NSInteger)tag;

//未选择的图像
- (UIImage *)unSelectedImage;
//选择后的图像
- (UIImage *)didSelectedImage;

//label颜色
- (void)setItemLabelColorInStateNormal:(UIColor *)normalColor stateSelectedColor:(UIColor *)selectedColor;
@end
