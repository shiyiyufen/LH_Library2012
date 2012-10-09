//
//  LH_DataBase.m
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

//******************************************
#define SQLITENAME @"food.sqlite"
//******************************************

#import "LH_DataBase.h"

//静态全局
static PLSqliteDatabase * dbPointer;
@implementation LH_DataBase
- (PLSqliteDatabase *)opena
{
	NSString *resourcePath = [[NSBundle mainBundle]pathForResource:SQLITENAME ofType:nil];
	NSFileManager *manager = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *realPath = [paths objectAtIndex:0];
	realPath = [realPath stringByAppendingPathComponent:SQLITENAME];
	NSLog(@"realPath:%@",realPath);
	if (![manager fileExistsAtPath:realPath])//目标路径没有，拷贝
	{
		if ([manager copyItemAtPath:resourcePath toPath:realPath error:nil]) 
		{
			NSLog(@"执行数据库拷贝成功");
		}
	}
	
	PLSqliteDatabase * db = [[PLSqliteDatabase alloc]initWithPath:realPath];
	[db open];
	return [db autorelease];
}
//打开数据库
+ (PLSqliteDatabase *)openDB
{
	if (dbPointer) return dbPointer;
	NSString *resourcePath = [[NSBundle mainBundle]pathForResource:SQLITENAME ofType:nil];
	NSFileManager *manager = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *realPath = [paths objectAtIndex:0];
	realPath = [realPath stringByAppendingPathComponent:SQLITENAME];
	NSLog(@"realPath:%@",realPath);
	if (![manager fileExistsAtPath:realPath])//目标路径没有，拷贝
	{
		if ([manager copyItemAtPath:resourcePath toPath:realPath error:nil]) 
		{
			NSLog(@"执行数据库拷贝成功");
		}
	}
	
	dbPointer = [[PLSqliteDatabase alloc]initWithPath:realPath];
	[dbPointer open];
	NSLog(@"data:%@",dbPointer);
	return dbPointer;
}

//添加更新操作数据
+ (BOOL)operateDbUpdate:(NSString *)updateString
{
	PLSqliteDatabase *data = [LH_DataBase openDB];
	NSLog(@"data:%@",data);
	BOOL result = [data executeUpdate:updateString];
	return result;
}

//查询数据
+ (id)operateDbSelecte:(NSString *)string
{
	PLSqliteDatabase *data = [LH_DataBase openDB];
	id<PLResultSet>rs = [data executeQuery:string];
	return rs;
}

@end
