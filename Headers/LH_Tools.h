//
//  LH_Tools.h
//  LH_Library
//
//  Created by  on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
enum DateType
{
    DateTypeYMD = 2121,
    DateTypeOriginal,
    DateTypeHMS
};

//文件是否存在于路径
BOOL fileIsExsitAtPath(NSString *path);

@interface LH_Tools : NSObject
//解密->实例
- (NSString *)decodeStringWithString:(NSString *)inputString;
//加密->实例
- (NSString *)encodeStringWithString:(NSString *)inputString;
//获取当前时间字符串－》实例
- (NSString *)nowDateWithFormat:(enum DateType)dateType;
//日期转换成字符串－》实例
- (NSString *)stringWithDate:(NSDate *)date inFormatter:(enum DateType)dateType;
/*
 把文件拷贝到沙盒
 */
- (BOOL)copyFileToDocumentBox:(NSString *)fileName;

//判断两个日期先后
- (BOOL)judgeDate1:(NSDate *)date1 isEarlierThanDate2:(NSDate *)date2;



//解密->类
+ (NSString *)returnDecodeStringWithString:(NSString *)inputString;

//加密->类
+ (NSString *)returnEncodeStringWithString:(NSString *)inputString;

//获取当前时间字符串－》类
+ (NSString *)returnNowDateWithFormat:(enum DateType)dateType;

//日期转换成字符串－》类
+ (NSString *)returnStringWithDate:(NSDate *)date inFormatter:(enum DateType)dateType;

//读取info.plist中的程序名称
+ (NSString *)ReadNameFromInfoPlist;

//将16进制转换成颜色
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

//通过特殊字符截取字符串
+ (NSArray *)splistString:(NSString *)string withIdentifier:(NSString *)identifier;

//从本地资源文件读取->实例
- (NSString *)getBundleFile:(NSString *)filename;

//从本地资源文件读取->类
+ (NSString *)returnBundleFile:(NSString *)filename;
@end
