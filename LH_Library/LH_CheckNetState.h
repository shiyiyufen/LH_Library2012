//
//  LH_CheckNetState.h
//  LH_Library
//
//  Created by  on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LH_CheckNetState : NSObject
+ (BOOL)isExistenceNetwork;
+ (NSString *)checkNetworkType;
+ (BOOL)connectedToNetWork;
@end
