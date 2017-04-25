# YYSliderMenu
封装滑动切换的view，当内容小于等于7个时自动占满屏幕，7个以上滑动显示，选中内容居中显示，滑动条平滑滚动效果。
## ScreenShoot
![ScreenShoot](https://github.com/yangyin-sunny/YYSliderMenu/raw/master/images-folder/screenShoot.png)
## how to use
(1)封装

    -(void) createClassifyView:(NSArray*) dataArray{
    
    _sliderMenuView=[[SliderMenuView alloc] initWithFrame:CGRectMake(0,20, ScreenWidth, [self getTopMentHeight]) titles:dataArray];
    _sliderMenuView.delegate=self;
    
    [self.view addSubview:_sliderMenuView];
   }
  
（2）调用

    _catTypesArray=@[@"推荐",@"美妆测试测试",@"运动",@"配饰",@"生活",@"母婴测试",@"测试1",@"测试测试",@"测试3",@"测试4"];
    [self createClassifyView:_catTypesArray];
    
## Requirements
* Xcode 7.3+
* iOS8+

## details
 如果您对我的代码有更好的建议，欢迎探讨~~ 博客我会抽空补上~~ 么么哒~第一次捯饬开源轮子,如果觉得好 欢迎star~~hahaha
