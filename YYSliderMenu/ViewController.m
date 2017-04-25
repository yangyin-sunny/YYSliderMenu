//
//  ViewController.m
//  YYSliderMenu
//
//  Created by 杨音 on 17/4/24.
//  Copyright © 2017年 杨音. All rights reserved.
//

#import "ViewController.h"
#import "SliderMenuView.h"

@interface ViewController ()<MenuViewDelegate,UIScrollViewDelegate>

@end

@implementation ViewController{
    
    UIScrollView *_mainScrollView;
    SliderMenuView *_sliderMenuView;
    NSArray *_catTypesArray;
    
    BOOL _isPerformRight;
    BOOL _isPerformLeaf;
    
    BOOL _isPerformDisplay;
    BOOL _isPerformHide;
    
     float _lastOffsetX;
    
    //前一个选中分类的索引
    NSInteger _formerIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _catTypesArray=@[@"推荐",@"美妆测试测试",@"运动",@"配饰",@"生活",@"母婴测试",@"测试1",@"测试测试",@"测试3",@"测试4"];
     [self createClassifyView:_catTypesArray];
    
    [self createScrollView];
    
}

/**
 *  创建滚动视图
 */
-(void)  createScrollView{
    
    UIScrollView *scr=[[UIScrollView alloc] initWithFrame:CGRectMake(0, [self getTopMentHeight]+20,
                                                                     ScreenWidth, ScreenHeight)];
    _mainScrollView=scr;
    _mainScrollView.bounces=false;
    _mainScrollView.pagingEnabled=true;
    scr.delegate=self;
    [self.view addSubview:scr];
    scr.contentSize=CGSizeMake(ScreenWidth*_catTypesArray.count, ScreenHeight);
    scr.backgroundColor=[UIColor yellowColor];
    
    
}


/**
 *  顶部菜单栏
 *
 *  @param dataArray <#dataArray description#>
 */
-(void) createClassifyView:(NSArray*) dataArray{
    
    _sliderMenuView=[[SliderMenuView alloc] initWithFrame:CGRectMake(0,20, ScreenWidth, [self getTopMentHeight]) titles:dataArray];
    _sliderMenuView.delegate=self;
    
    [self.view addSubview:_sliderMenuView];
}

-(float) getTopMentHeight{
    
    float classifyViewHeight=0;
    if (iPhone6||iPhone6Plus) {
        
        classifyViewHeight=40;
        
    }else{
        classifyViewHeight=32;
    }
    
    return  classifyViewHeight;
}

/**
 *  分类点击滑动内容视图
 *
 *  @param menuciew    <#menuciew description#>
 *  @param index       <#index description#>
 *  @param formerIndex 前一个选中的分类的下标
 */
- (void)menuViewDelegate:(SliderMenuView*)menuciew WithIndex:(int)index{

    [_mainScrollView setContentOffset:CGPointMake(index*ScreenWidth, 0)];
//    [self goHomeTableView:index];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    BOOL  isLeaf;
    float currentContentOffsetX=scrollView.contentOffset.x;
    if (currentContentOffsetX>_lastOffsetX) {
        
        isLeaf=false;
        
    }else{
        
        isLeaf=true;
    }
    
    NSLog(@"isLeaf=%i",isLeaf);
    
    int currentIndex = scrollView.contentOffset.x / ScreenWidth;
    if (scrollView.contentOffset.x> ((currentIndex*ScreenWidth)+160)) {//屏幕过半
        
        _isPerformLeaf=false;
        if(!isLeaf){
            
            if (!_isPerformRight) {
                
                NSLog(@"selectWithIndex");
                //                //前一选中分类索引
                _formerIndex=currentIndex;
                [_sliderMenuView selectWithIndex:currentIndex+1];
                _isPerformRight=true;
                
                
            }
            
        }
        
        
        
    }
    else{
        _isPerformRight=false;
        
        if(isLeaf){
            
            if (!_isPerformLeaf) {
                
                //前一选中分类索引
                _formerIndex=currentIndex+1;
                [_sliderMenuView selectWithIndex:currentIndex];
                _isPerformLeaf=true;
                
                
            }
            
        }
        
    }
    
    if (scrollView.contentOffset.x>0) {
        
        if (!_isPerformHide) {
            
            _isPerformHide=true;
            _isPerformDisplay=false;
        }
        
    }else{
        
        if (!_isPerformDisplay) {
            
            _isPerformDisplay=true;
            _isPerformHide=false;
        }
        
    }
    
    _lastOffsetX=scrollView.contentOffset.x;
    
    
    
}

@end
