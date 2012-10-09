//
//  LH_HtmlColor.h
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define DEFAULT_VOID_COLOR 0
@interface LH_HtmlColor : UIColor {
    
}
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
@end
