//
//  LH_TabbarItem.m
//  LH_Library
//
//  Created by  on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LH_TabbarItem.h"

@implementation LH_TabbarItem
@synthesize imageString;

- (void)dealloc
{
    [imageString release];imageString = nil;
    [super dealloc];
}

//未选择的图像
- (UIImage *)unSelectedImage
{
    NSString *string = [[NSString alloc] initWithFormat:@"%@.png",imageString];
    UIImage *unSelectedImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:string ofType:nil]];
    [string release];
	return [unSelectedImage autorelease];
}

//选择后的图像
- (UIImage *)didSelectedImage
{
    NSString *string = [[NSString alloc] initWithFormat:@"%@1.png",imageString];
    UIImage *selectedImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:string ofType:nil]];
    [string release];
	return [selectedImage autorelease];
}

- (void)setImageString:(NSString *)_imageString
{
    if (nil == imageString || ![imageString isEqualToString:_imageString]) 
    {
        [imageString release];
        imageString = [_imageString copy];
        
        [self setFinishedSelectedImage:[self didSelectedImage] withFinishedUnselectedImage:[self unSelectedImage]];
    }
}

//label颜色
- (void)setItemLabelColorInStateNormal:(UIColor *)normalColor stateSelectedColor:(UIColor *)selectedColor
{
    if ([self respondsToSelector:@selector(setTitleTextAttributes:forState:)]) 
    {
        NSLog(@"*** Support method(iOS 5): setTitleTextAttributes:");
        NSDictionary *normal = [[NSDictionary alloc] initWithObjectsAndKeys:
                                [UIFont systemFontOfSize:12], UITextAttributeFont,
                                normalColor, UITextAttributeTextColor,
                                [UIColor grayColor], UITextAttributeTextShadowColor,
                                [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)], UITextAttributeTextShadowOffset,
                                nil];
        [self setTitleTextAttributes:normal forState:UIControlStateNormal];
        [normal release];
        
        NSDictionary *selected = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  [UIFont systemFontOfSize:12], UITextAttributeFont,
                                  selectedColor, UITextAttributeTextColor,
                                  [UIColor grayColor], UITextAttributeTextShadowColor,
                                  [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)], UITextAttributeTextShadowOffset,
                                  nil];
        [self setTitleTextAttributes:selected forState:UIControlStateSelected];
        [selected release];
        
    }
}

- (id)initWithTitle:(NSString *)title tag:(NSInteger)tag
{
	return [self initWithTitle:title image:nil tag:tag];
}

//ios 4.x
//- (UIImage *) selectedImage
//{
//	NSString *string = [NSString stringWithFormat:@"%@.png",self.imageString];
//	return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:string ofType:nil]];
//}
//
//- (UIImage*) unselectedImage
//{
//	NSString *string = [NSString stringWithFormat:@"%@1.png",self.imageString];
//	return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:string ofType:nil]];
//}
@end

