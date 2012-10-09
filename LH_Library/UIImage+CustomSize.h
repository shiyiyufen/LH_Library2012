//
//  UIImage+CustomSize.h
//  CompanyMailProject
//
//  Created by apple on 12-5-10.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*
 IOS5版本以下适用，IOS5有新方法
 */
@interface UIImage(UIImage_CustomSize)
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;
@end
