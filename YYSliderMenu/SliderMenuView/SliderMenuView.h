//
//  SliderMenuView.h
//  Mic
//
//  Created by 杨音 on 17/3/6.
//  Copyright © 2017年 chaossy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"

@protocol MenuViewDelegate;
@interface SliderMenuView : UIView

@property (nonatomic,weak)id<MenuViewDelegate> delegate;
@property(nonatomic,strong)NSArray *categoryArr; //分类数组


- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)categories;
//滚动内容scrollView控制menu的滚动
- (void)selectWithIndex:(int)index;

@end

@protocol MenuViewDelegate <NSObject>
@required
- (void)menuViewDelegate:(SliderMenuView*)menuciew WithIndex:(int)index; //滚动menu内容scrollView滚动
@end