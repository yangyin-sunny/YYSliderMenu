//
//  common.h
//  YYSliderMenu
//
//  Created by 杨音 on 17/4/24.
//  Copyright © 2017年 杨音. All rights reserved.
//

#ifndef common_h
#define common_h

#define ScreenWidth    [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight   [[UIScreen mainScreen] bounds].size.height
#define tabbarHeight    self.tabBarController.tabBar.size.height
#define ScreenContentHeight  [[UIScreen mainScreen] bounds].size.height-[[UIApplication sharedApplication] statusBarFrame].size.height-self.navigationController.navigationBar.frame.size.height

#define ScreenNoBarContentHeight [[UIScreen mainScreen] bounds].size.height-[[UIApplication sharedApplication] statusBarFrame].size.height

#define IOS9_OR_LATER     ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0f)
#define IOS7_OR_LATER     ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)
#define IOS8_OR_LATER     ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f)
#define IOS9_OR_LATER     ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0f)
#define IOS10_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0f)
#define IOS7_Following    ([ [ [UIDevice currentDevice] systemVersion] floatValue]<7.0)

#define iPhone4      [[UIScreen mainScreen] bounds].size.height==480?1:0
#define iPhone5      [[UIScreen mainScreen] bounds].size.height==568?1:0
#define iPhone6      [[UIScreen mainScreen] bounds].size.height==667?1:0
#define iPhone6Plus     [[UIScreen mainScreen] bounds].size.height==736?1:0
#define kIphoneSize_4Inches  [[UIScreen mainScreen] bounds].size.width==320?1:0

#endif /* common_h */
