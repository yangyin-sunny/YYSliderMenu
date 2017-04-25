//
//  SliderMenuView.m
//  Mic
//
//  Created by 杨音 on 17/3/6.
//  Copyright © 2017年 chaossy. All rights reserved.
//

#import "SliderMenuView.h"

//分类行中每个分类栏的宽度
#define itemWith ScreenWidth/7

@interface SliderMenuView()<UIScrollViewDelegate>{
    
    //顶部分类栏
    UIScrollView *_menuScrollView;
    
    //选中的按钮
    UIButton *selectedBtn;
    
    //分类按钮数组集
    NSMutableArray *_btnArr;
    
    //分类高度
    float _classifyViewHeight;
    
    //下划线
    UIView *_indicatorView;
    
}

@end
@implementation SliderMenuView{

    //分类滑动宽度
     CGFloat  _scrollViewWidth;
    //自适应按钮宽度
    __block CGFloat buttonWidth;
    //自适应按钮title的宽度
    __block CGSize  buttonTitleWidth;
    //自适应所有按钮title的宽度之和
    CGFloat  allButtonTitleWidth;
    //6个以下按钮的间隔
    CGFloat buttonSpacing;
}

- (void)dealloc {
   
}

#pragma mark-初始化分类栏选项滚动页面
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)categories{
    
    self=[super initWithFrame:frame];
    if(self){
        
        _btnArr=[NSMutableArray array];
        _categoryArr=categories;
        self.backgroundColor=[UIColor whiteColor];
        //分类栏创建
        [self initMenuViewWithTitle:categories];
    }
    
    return self;
    
}



#pragma mark   ui布局   begin

/**
 *  创建顶部菜单栏
 *
 *  @param categoriesArr <#categoriesArr description#>
 */
- (void)initMenuViewWithTitle:(NSArray *)categoriesArr{
   
    if (iPhone6||iPhone6Plus) {
        
        _classifyViewHeight=40;
        
    }else{
        _classifyViewHeight=32;
    }
    
    //分类栏滑动
    _menuScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0,0, ScreenWidth, _classifyViewHeight)];
    _menuScrollView.showsHorizontalScrollIndicator=NO;
    _menuScrollView.showsVerticalScrollIndicator=NO;
    _menuScrollView.backgroundColor=[UIColor whiteColor];
    _menuScrollView.delegate=self;
     _menuScrollView.bounces=NO;
    [self addSubview:_menuScrollView];
    
    //按钮文字大小
    float btnFontSize=13;
    
    if (ScreenWidth > 320) {
        
        btnFontSize = 15;
    }
    
    allButtonTitleWidth=0;
    
    //小于等于6个时按钮之间间距
    for (NSString *category in categoriesArr) {
       
        buttonTitleWidth =[self getLabelSize:category withFont:[UIFont systemFontOfSize:btnFontSize] withRowWidth:ScreenWidth];
        buttonTitleWidth.width = 45;
        
        allButtonTitleWidth =allButtonTitleWidth+buttonTitleWidth.width;
    }
    
    buttonSpacing = (ScreenWidth -allButtonTitleWidth)/categoriesArr.count;
    
     _scrollViewWidth=0;
    
    [categoriesArr enumerateObjectsUsingBlock:^(NSString* category, NSUInteger idx, BOOL *stop) {
        
//        if(idx==0)return;
        //根据分类创建按钮
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font=[UIFont systemFontOfSize:btnFontSize];
        button.tag=idx;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(categoryButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.lineBreakMode = 2;

        
        [_menuScrollView addSubview:button];
        [_btnArr addObject:button];
        
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        [button setTitle:category forState:UIControlStateNormal];
        
        
        //设置分类按钮大小和scrollView的宽度
        [self cateBtnsSizeAndScrollViewWith:button indicatorView:nil AndCategory:category AndCategoryArray:categoriesArr];
    
        if(idx==0){
            
            button.selected=YES;
            selectedBtn=button;
            
        }
        
    }];

    [_menuScrollView setContentSize:CGSizeMake(_scrollViewWidth, 0)];
    
     [self addSliderView];
    
    
    
    
}

/**
 *  布局分类按钮
 *
 *  @param button        <#button description#>
 *  @param indicatorView <#indicatorView description#>
 *  @param category      <#category description#>
 *  @param categoriesArr <#categoriesArr description#>
 */
- (void)cateBtnsSizeAndScrollViewWith:(UIButton *)button indicatorView:(UIView *)indicatorView AndCategory:(NSString *)category AndCategoryArray:(NSArray *)categoriesArr{
    
    //按钮文字大小
    float btnFontSize=13;
    
    if (ScreenWidth > 320) {
        
        btnFontSize = 15;
    }
    buttonTitleWidth = [self getLabelSize:category withFont:[UIFont systemFontOfSize:btnFontSize] withRowWidth:ScreenWidth];
    
    if (categoriesArr.count >7) {//分类大于7个按钮
        
        if (ScreenWidth > 320) {
            
            if (ScreenWidth > 375) {    //iphone6p
                
                buttonWidth  = buttonTitleWidth.width+29;
                
                
                button.frame=CGRectMake(_scrollViewWidth, 0, buttonWidth, 40);
                
            }else{    //iphone6
                
                buttonWidth  = buttonTitleWidth.width+26;

                
                button.frame=CGRectMake(_scrollViewWidth, 0, buttonWidth, 40);
                
            }
            
            
        }else{  //iphone5(s)及以下
            
            buttonWidth  = buttonTitleWidth.width+22;
            
            button.frame=CGRectMake(_scrollViewWidth, 0, buttonWidth, 32);
            
        }
        
        //6个以上 分类scorllView宽度
        _scrollViewWidth = _scrollViewWidth+ buttonWidth;
        
        
    }else{ //分类小于等于6个按钮
        
        buttonWidth  = buttonTitleWidth.width+buttonSpacing;
        
        if (ScreenWidth > 320) {
            
            button.frame=CGRectMake(_scrollViewWidth, 0, buttonWidth, 40);
            
        }else{
            
            button.frame=CGRectMake(_scrollViewWidth, 0, buttonWidth, 32);
            
        }
        
        //6个及6个以下按钮 分类scorllView宽度
        _scrollViewWidth = _scrollViewWidth +buttonWidth;
        
    }
    
    
}


/**
 *  添加底部红线
 */
- (void)addSliderView{

    // 选中的下划线 点击，高亮效果
    _indicatorView = [[UIView alloc] init];
    
    float indicatorViewWidth = [self getLabelSize:selectedBtn.titleLabel.text
                                            withFont:selectedBtn.titleLabel.font
                                        withRowWidth:ScreenWidth].width;

    _indicatorView.frame=CGRectMake(0, self.frame.origin.y+self.frame.size.height-2,indicatorViewWidth, 2);
    [self setCenterX:selectedBtn.center.x];

    _indicatorView.backgroundColor = [UIColor redColor];
    [_menuScrollView addSubview:_indicatorView];
}


#pragma mark   ui布局   end



#pragma mark    顶部菜单事件   begin
/**
 *  被动滑动菜单
 *
 *  @param index <#index description#>
 */
- (void)selectWithIndex:(int)index{
    
    selectedBtn=[self switchBtnBack:_btnArr[index] dataArr:_btnArr];
    [self moveCodeWithIndex:(int)selectedBtn.tag];
    [self executeaAnimations];
}


/**
 *  动画执行
 */
-(void)  executeaAnimations{

    float indicatorViewWidth = [self getLabelSize:selectedBtn.titleLabel.text
                                            withFont:selectedBtn.titleLabel.font
                                        withRowWidth:ScreenWidth].width;
    
    _indicatorView.frame=CGRectMake(_indicatorView.frame.origin.x, _indicatorView.frame.origin.y, indicatorViewWidth, _indicatorView.frame.size.height);
    //获取button中心点
    float indicatorViewOffsetX=[self getCenterX:selectedBtn.frame.size.width currentViewWidth:indicatorViewWidth];
    float indicatorViewX=selectedBtn.frame.origin.x+indicatorViewOffsetX;
    
    [UIView animateWithDuration:0.2 animations:^{
        
         _indicatorView.frame=CGRectMake(indicatorViewX, _indicatorView.frame.origin.y, indicatorViewWidth, _indicatorView.frame.size.height);
 
    }];
}


/**
 *  按钮点击
 *
 *  @param btn <#btn description#>
 */
- (void)categoryButtonDidClick:(UIButton *)btn{
    
    selectedBtn=[self switchBtnBack:btn dataArr:_btnArr];
    [self moveCodeWithIndex:(int)btn.tag];
    [self executeaAnimations];
    
    //分类选中或滚动来操作首页scrollView滚动
    if ([self.delegate respondsToSelector:@selector(menuViewDelegate:WithIndex:)]) {
        [self.delegate menuViewDelegate:self WithIndex:(int)btn.tag];
    }
}

/**
 *  使选中的按钮位移到scollview的中间
 */
- (void)moveCodeWithIndex:(int )index {
    
    if (index==0) {
        return;
    }
    //分类按钮移动
    UIButton *btn = _menuScrollView.subviews[index-1];
     //UIButton *btn = _menuScrollView.subviews[index];
    CGRect newframe = [btn convertRect:self.bounds toView:nil];
    CGFloat distance = newframe.origin.x  - self.center.x;
    CGFloat contenoffsetX = _menuScrollView.contentOffset.x;
    int count = (int)_menuScrollView.subviews.count;
    
    if (index > count-1) return;
    
    if ( _menuScrollView.contentOffset.x + btn.frame.origin.x   > self.center.x) {
        
        [_menuScrollView setContentOffset:CGPointMake(contenoffsetX + distance+ btn.frame.size.width, 0) animated:YES];
        
    }else{
        
        [_menuScrollView setContentOffset:CGPointMake(0 , 0) animated:YES];

    }
    
}

#pragma mark    顶部菜单事件   end


#pragma mark-scrollView代理方法  begin
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x <= 0) { //当滑动偏移contentOffset.x小于0 回到原点
        
        [scrollView setContentOffset:CGPointMake(0 , 0)];
        
        
    }else if(scrollView.contentOffset.x + self.frame.size.width >= scrollView.contentSize.width){ //当滑动偏移contentOffset.x加上容器宽度大于scrollview的contentSize.width时 setContentOffset为scrollview显示内容的的最大偏移
        
        [scrollView setContentOffset:CGPointMake(scrollView.contentSize.width - self.frame.size.width, 0)];
        
    }
}
#pragma mark-scrollView代理方法  end


//获得文字宽高 变化label高度
- (CGSize)getLabelSize:(NSString*)lbtext
             withFont:(UIFont*)font
         withRowWidth:(float)width{
    
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize labelsize ;//= [lbtext sizeWithFont:font constrainedToSize:CGSizeMake(width, constrainedHeight) lineBreakMode:UILineBreakModeWordWrap];
    
    if (IOS7_OR_LATER) {
        
        labelsize= [lbtext boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                        options: NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }else{
        labelsize = [lbtext sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
    }
    return labelsize;
    
    
}

/**
 *  选中指定按钮
 *
 *  @param button  <#button description#>
 *  @param dataArr <#dataArr description#>
 *
 *  @return <#return value description#>
 */
- (UIButton*) switchBtnBack:(UIButton *)button dataArr:(NSArray*)dataArr{
    
    UIButton *selectBtn=nil;
    for (UIButton *ItemBtn in dataArr) {
        
        if (ItemBtn==button) {
            
            ItemBtn.selected=YES;
            selectBtn=ItemBtn;
            
        }else {
            ItemBtn.selected=NO;
        }
    }
    
    return selectBtn;
}

-(void)setCenterX:(CGFloat)centerX {
    _indicatorView.center = CGPointMake(centerX, self.center.y);
}

- (float) getCenterX:(float) fatherWidth
   currentViewWidth:(float)currentViewWidth{
    
    return   fatherWidth/2-currentViewWidth/2;
}
@end
