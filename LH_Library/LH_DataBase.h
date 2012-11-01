//
//  LH_DataBase.h
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PlausibleDatabase/PlausibleDatabase.h>
@interface LH_DataBase : NSObject

//打开数据库
+ (PLSqliteDatabase *)openDB:(NSString *)db;

//关闭数据库
+ (void)closeDB;

@end
