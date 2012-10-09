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
- (PLSqliteDatabase *)opena;
//打开数据库
+ (PLSqliteDatabase *)openDB;
//添加更新操作数据
+ (BOOL)operateDbUpdate:(NSString *)updateString;
//查询数据
+ (id)operateDbSelecte:(NSString *)string;
@end
