//
//  LH_CustomSearchBar.h
//  LH_Library
//
//  Created by  on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define LH_SEARCHBAR_HEIGHT 44
@protocol LH_CustomSearchBarDelegate;
@interface LH_CustomSearchBar : UIImageView
<UITextFieldDelegate>
{
    UIButton    *rightButton;
    UITextField *inputTextField;
    @private
    id <LH_CustomSearchBarDelegate> _delegate;
    
    NSString   *placeholder;//占位符
    NSString   *searchBarBackGroundImageString;//背景图片
    NSString   *cancelButtonBackImageString;//取消按钮背景图
    NSString   *cancelButtonImageString;//取消按钮图片
    NSString   *cancelButtonTitle;//取消按钮文字
}
@property (retain, nonatomic) UIButton    *rightButton;
@property (retain, nonatomic) UITextField *inputTextField;

@property (assign, nonatomic) id <LH_CustomSearchBarDelegate> delegate;
@property (copy  , nonatomic) NSString   *placeholder;//占位符

@property (copy  , nonatomic) NSString   *searchBarBackGroundImageString;//背景图片
@property (copy  , nonatomic) NSString   *cancelButtonBackImageString;//取消按钮背景图
@property (copy  , nonatomic) NSString   *cancelButtonImageString;//取消按钮图片
@property (copy  , nonatomic) NSString   *cancelButtonTitle;//取消按钮文字

//init
//自定义初始化
- (id)initLHSearchBarWithFrame:(CGRect)frame;

//views
//创建输入框
- (void)createSearchBarTextField;

@end

@protocol LH_CustomSearchBarDelegate <NSObject>

@required
//搜索事件被执行
- (void)lh_SearchBarSearchButtonClick:(LH_CustomSearchBar *)searchbar;

@optional

//文本框能够编辑
- (BOOL)lh_SearchBarShouldBeginEditing:(LH_CustomSearchBar *)searchbar;
//文本框开始编辑
- (void)lh_SearchBarDidBeginEditing:(LH_CustomSearchBar *)searchbar;
//取消键盘事件被执行
- (void)lh_SearchBarCancelButtonClick:(LH_CustomSearchBar *)searchbar;

@end