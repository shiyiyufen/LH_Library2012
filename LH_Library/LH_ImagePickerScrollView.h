//
//  LH_ImagePickerScrollView.h
//  LH_Library
//
//  Created by  on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ImagePickerDelegate;
/*主要实现呈现从相册中选取图片，然后呈现到scroll中，加一个删除按钮*/
@interface LH_ImagePickerScrollView : UIScrollView
{
    @private
    id <ImagePickerDelegate> _deleteDelegate;
    NSMutableArray   *_images;//图片数组
    NSInteger        _imgWidth;//图片宽度
}
@property (assign, nonatomic) id <ImagePickerDelegate> deleteDelegate;
@property (readonly,nonatomic,retain) NSMutableArray *images;
@property (assign, nonatomic) NSInteger imgWidth;
/*把image添加到scroll中*/
- (void)addImage:(UIImage *)image atIndex:(NSInteger)index;
@end

@protocol ImagePickerDelegate <NSObject>

@optional
//删除了这张图片
- (void)didDeleteImageAtIndex:(NSInteger)index;

@end