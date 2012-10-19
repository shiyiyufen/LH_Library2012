//
//  LH_BaseViewController.h
//  LH_Library
//
//  Created by  on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kLABELTAG 101
#define kPerPageSize 4
#define kInfoViewTag 44
@interface LH_BaseViewController : UIViewController
{
    BOOL noData;
	BOOL reloadData;
	int  size;
	int  index;
    NSInteger currentIndex;
}
//显示或隐藏导航条
- (void)viewControllerHiddenNavigationBar:(BOOL)hidden;
//请求基本数据
- (void)requestData;
//数据初始化
- (void)initData;
//视图初始化
- (void)initView;
//初始化内存
- (void)allocMemory;
//清除数据和视图
- (void)cleanViewAndData;
//右搜索按钮
- (void)createRightSearchBar:(id)target action:(SEL)action;
//显示左边返回
- (void)setLeftItem:(BOOL)b;
//显示右边主页
- (void)setRightItem:(BOOL)b;
//显示左边按钮－》宽度
- (void)setLeftItemWidth:(NSInteger)width;
//显示右边－》宽度
- (void)setRightItemWidth:(NSInteger)width;
- (void)goBackToLastPage;
- (void)goBackToMainPage;
//自定义提示窗
- (void)alert:(NSString*)_alert;
- (void)showAlertViewWithText:(NSString *)str inView:(UIView *)v;
- (void)removeViewSubView;
- (void)sendData:(NSString *)param;
//load data info view
- (void)pleaseLoadData:(NSString *)info inView:(UIView *)aview;
- (void)stopLoadDataInView:(UIView *)aview;
/*
 回到主页，即最初的页面
 */
- (void)goBackToMainPage;
/*
 回到前一页面
 */
- (void)goBackToLastPage;
@end
