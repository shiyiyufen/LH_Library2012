//
//  LH_CustomSearchBar.m
//  LH_Library
//
//  Created by  on 12-10-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LH_CustomSearchBar.h"
#import <QuartzCore/QuartzCore.h>
#import "LH_HtmlColor.h"
@implementation LH_CustomSearchBar
@synthesize delegate = _delegate;
@synthesize placeholder,searchBarBackGroundImageString,cancelButtonBackImageString,cancelButtonTitle,cancelButtonImageString;
@synthesize rightButton,inputTextField;

- (void)dealloc
{
    self.delegate = nil;
    self.placeholder = nil;
    self.cancelButtonTitle = nil;
    self.cancelButtonImageString = nil;
    self.cancelButtonBackImageString = nil;
    self.searchBarBackGroundImageString = nil;
    
    [rightButton release];
    [inputTextField release];
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        //init code
        NSLog(@"无效设置，请使用专属初始化方法!:init");
    }
    return self;
}

//- (void)setFrame:(CGRect)frame
//{
//    NSLog(@"无效设置，请使用专属初始化方法!");
//}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialization code
        NSLog(@"无效设置，请使用专属初始化方法!:initWithFrame");
    }
    return self;
}

//自定义初始化
- (id)initLHSearchBarWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) 
    {
        self.userInteractionEnabled = YES;
        //防止搜索框太窄
        CGRect f = frame;
        NSInteger height = f.size.height;
        if (LH_SEARCHBAR_HEIGHT >f.size.height)
        {
            height = LH_SEARCHBAR_HEIGHT;
        }
        f.size.height = height;
        frame = f;
    
        self.frame = frame;
        // Initialization code
        
        [self createSearchBarTextField];
        NSLog(@"height:%d",height);
        
        UIButton *btn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        btn.frame = CGRectMake(270, (height - 32)/2-5, 43, 32);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.rightButton = btn;
        [btn release];
    }
    return self;
}


- (void)setCancelButtonTitle:(NSString *)_cancelButtonTitle
{
    [cancelButtonTitle release];
    cancelButtonTitle = [_cancelButtonTitle copy];
    
    [self.rightButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(resign) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setCancelButtonBackImageString:(NSString *)_cancelButtonBackImageString
{
    [cancelButtonBackImageString release];
    cancelButtonBackImageString = [_cancelButtonBackImageString copy];
    
    NSString *mainPath = [[NSBundle mainBundle] resourcePath];
    
    NSString *path  = [[NSString alloc] initWithFormat:@"%@/%@.png",mainPath,cancelButtonBackImageString];
    NSString *path1 = [[NSString alloc] initWithFormat:@"%@/%@1.png",mainPath,cancelButtonBackImageString];
    
    [self.rightButton setBackgroundImage:[UIImage imageWithContentsOfFile:path]  forState:UIControlStateNormal];
    [self.rightButton setBackgroundImage:[UIImage imageWithContentsOfFile:path1] forState:UIControlStateHighlighted];
    
    [path release];
    [path1 release];
}

- (void)setCancelButtonImageString:(NSString *)_cancelButtonImageString
{
    [cancelButtonImageString release];
    cancelButtonImageString = [_cancelButtonImageString copy];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:cancelButtonImageString ofType:nil];
    [self.rightButton setImage:[UIImage imageWithContentsOfFile:path]  forState:UIControlStateNormal];
}

- (void)setSearchBarBackGroundImageString:(NSString *)_searchBarBackGroundImageString
{
    if (nil == _searchBarBackGroundImageString) return;
    
    [searchBarBackGroundImageString release];
    searchBarBackGroundImageString = [_searchBarBackGroundImageString copy];
    
    self.image = [UIImage imageNamed:searchBarBackGroundImageString];
}

- (void)setPlaceholder:(NSString *)_placeholder
{
    [placeholder release];
    placeholder = [_placeholder copy];
    
    self.inputTextField.placeholder = placeholder;
}

- (void)setInputTextField:(UITextField *)_inputTextField
{
    [inputTextField removeFromSuperview];
    [inputTextField release];
    inputTextField = [_inputTextField retain];
    
    [self addSubview:inputTextField];
}

- (void)setRightButton:(UIButton *)_rightButton
{
    [rightButton removeFromSuperview];
    [rightButton release];
    rightButton = [_rightButton retain];
    
    
    [self addSubview:rightButton];
}

//创建输入框
- (void)createSearchBarTextField
{
    if (self.frame.size.height >= 44 && self.frame.size.width == 320)
    {
        UITextField *textField    = [[UITextField alloc] init];
        textField.delegate = self;
        textField.frame = CGRectMake(10, (self.frame.size.height - 32)/2 - 5, 320 - 60 + 4, 32);
        textField.backgroundColor = [UIColor whiteColor];
        textField.clearButtonMode = UITextFieldViewModeUnlessEditing;
        textField.layer.masksToBounds = YES;
        textField.layer.cornerRadius  = 5.0f;
        textField.layer.borderWidth   = 2.0f;
        textField.layer.borderColor   = [[LH_HtmlColor colorWithHexString:@"#2e97ff"] CGColor];
        textField.font = [UIFont systemFontOfSize:14];
        textField.returnKeyType = UIReturnKeySearch;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.inputTextField = textField;
        [textField release];
    }else
    {
        NSLog(@"无效设置:self.frame.size.height >= 44 && self.frame.size.width == 320");
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (nil != self.delegate && [self.delegate respondsToSelector:@selector(lh_SearchBarShouldBeginEditing:)])
    {
        return [self.delegate lh_SearchBarShouldBeginEditing:self];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (nil != self.delegate && [self.delegate respondsToSelector:@selector(lh_SearchBarDidBeginEditing:)])
    {
        [self.delegate lh_SearchBarDidBeginEditing:self];
    }
    
    //新的取消按钮
    UIButton *btn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    btn.frame = CGRectMake(270, (self.frame.size.height - 32)/2-5, 43, 32);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[self.rightButton backgroundImageForState:UIControlStateNormal] forState:UIControlStateNormal];
    [btn setBackgroundImage:[self.rightButton backgroundImageForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn setTitle:@"取 消" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(resign) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton = btn;
    [btn release];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //新的取消按钮
    UIButton *btn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    btn.frame = CGRectMake(270, (self.frame.size.height - 32)/2-5, 43, 32);
    
    [btn setBackgroundImage:[self.rightButton backgroundImageForState:UIControlStateNormal] forState:UIControlStateNormal];
    [btn setBackgroundImage:[self.rightButton backgroundImageForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:self.cancelButtonImageString ofType:nil];
    [btn setImage:[UIImage imageWithContentsOfFile:path]  forState:UIControlStateNormal];
    
    self.rightButton = btn;
    [btn release];
}

- (void)resign
{
    if (nil != self.delegate && [self.delegate respondsToSelector:@selector(lh_SearchBarCancelButtonClick:)])
    {
        [self.delegate lh_SearchBarCancelButtonClick:self];
        return;
    }
    [self.inputTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.inputTextField resignFirstResponder];
    if (nil != self.delegate && [self.delegate respondsToSelector:@selector(lh_SearchBarSearchButtonClick:)])
    {
        [self.delegate lh_SearchBarSearchButtonClick:self];
    }else
    {
        NSLog(@"警告：需要实现搜索回调方法");
    }
    return YES;
}

@end
