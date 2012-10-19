//
//  LH_SelectorView.h
//  LH_Library
//
//  Created by  on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
enum SelectorStyle
{
    SelectorStyleUIView = 989,
    SelectorStyleUINavigationView
};
@protocol LH_SelectorDelegate;
@interface LH_SelectorView : UIView
<UITableViewDelegate,
UITableViewDataSource
>
{
    @private
    id <LH_SelectorDelegate> _delegate;
    NSArray     *_selectorItems;//选项数组
    NSString    *_title;//标题
    UIColor     *_titleColor;//标题颜色
    NSInteger   _selectedIndex;//当前选择的索引
    NSString    *_separatorImageString;//分隔图片名称
    BOOL        isSupportMultipleAnswer;//是否支持多选
}
@property (assign, nonatomic) id <LH_SelectorDelegate> delegate;
@property (assign, nonatomic) BOOL      isSupportMultipleAnswer;
@property (readonly,assign,nonatomic) NSInteger selectedIndex;
@property (copy  , nonatomic) NSString  *title;
@property (copy  , nonatomic) UIColor   *titleColor;
@property (copy  , nonatomic) NSString  *separatorImageString;
@property (readonly,nonatomic,retain) NSArray   *selectorItems;
//自定义初始化
- (id)initWithSelectorWithFrame:(CGRect)frame selectorStyle:(enum SelectorStyle)selectorStyle;
@end

@protocol LH_SelectorDelegate <NSObject>
@optional
//选择某一项
- (void)didSelectMeAtIndex:(NSInteger)myIndex withCategoryid:(NSString *)categoryid;

@end