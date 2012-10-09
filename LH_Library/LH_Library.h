//
//  LH_Library.h
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LH_Library : NSObject

/*两数相加的结果*/
- (NSInteger)resultAfterNumber1:(NSInteger)number1 addNumber2:(NSInteger)number2;

/*控制台输出一段字符串的描述*/
- (void)printDescriptionOfInputString:(NSString *)inputString;
@end
