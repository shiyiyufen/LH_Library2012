//
//  LH_SearchBar.h
//  LH_Library
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LH_SearchBar : UISearchBar
{
    @private
    NSString   *searchBarBackGroundImageString;//背景图片
    NSString   *cancelButtonBackImageString;//取消按钮背景图片：x.png/x1.png
}
@property (copy  , nonatomic) NSString   *searchBarBackGroundImageString;//背景图片
@property (copy  , nonatomic) NSString   *cancelButtonBackImageString;//取消按钮背景图片：x.png/x1.png
@end