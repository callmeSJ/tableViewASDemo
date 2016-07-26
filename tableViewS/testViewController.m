//
//  testViewController.m
//  tableViewS
//
//  Created by SJ on 16/7/10.
//  Copyright © 2016年 SJ. All rights reserved.
//
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#import "testViewController.h"

@interface testViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollerView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)NSArray *imageArray;
@end

@implementation testViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createCycleScrollImg];
}
-(void)createCycleScrollImg{
    _imageArray = @[@"1",@"2",@"3",@"4"];
    [self createScroller];
    [self cretaeTimer];
}
-(void)createScroller{
    CGFloat height = 803*kScreenWidth/1600;
    _scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, height)];
    _scrollerView.showsVerticalScrollIndicator = NO;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.contentSize = CGSizeMake(kScreenWidth*(_imageArray.count + 2), height);
    _scrollerView.pagingEnabled = YES;
    _scrollerView.bounces = NO;
    _scrollerView.delegate = self;
    
    [self.view addSubview:_scrollerView];
    
    //添加图片
    for(int i = 0 ; i < _imageArray.count+2 ; i++){
        NSString *path = [[NSBundle mainBundle] pathForResource:[self getImageStringWithIndex:i] ofType:@"jpg"];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, height)];
        img.image = [UIImage imageWithContentsOfFile:path];
        img.tag = 100 + i;
        img.userInteractionEnabled = YES;
        [_scrollerView addSubview:img];
    }
    _scrollerView.contentOffset = CGPointMake(kScreenWidth, 0);
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(140, height-10, 80, 20)];
    _pageControl.backgroundColor = [UIColor blackColor];
    _pageControl.alpha = 0.5;
    _pageControl.numberOfPages = _imageArray.count;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    
    [_pageControl addTarget:self action:@selector(scrollImg:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    
}

#pragma 滑动图片
-(void)scrollImg:(id)sender{
    if(sender == _pageControl){
        [_scrollerView setContentOffset:CGPointMake((_pageControl.currentPage + 1)*kScreenWidth, 0) animated:YES];
        
    }
    else if(sender == _timer){
        CGPoint point = _scrollerView.contentOffset;
        point.x = point.x +kScreenWidth;
        [_scrollerView setContentOffset:point animated:YES];
    }
}

#pragma mark scroll代理
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/kScreenWidth;
    if(index == 0){
        scrollView.contentOffset = CGPointMake(_imageArray.count*kScreenWidth, 0);
        _pageControl.currentPage = _imageArray.count - 1;
        
    }else if(index == _imageArray.count + 1){
        scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
        _pageControl.currentPage = 0;
    }else{
        _pageControl.currentPage = index - 1;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:_scrollerView];
}


#pragma mark 获取每页对应的图片字符串

-(NSString *)getImageStringWithIndex:(NSInteger)index{
    NSString *imageStr;
    if(index == 0){
        imageStr = _imageArray.lastObject;
    }else if (index == _imageArray.count+1){
        imageStr = _imageArray.firstObject;
    }else{
        imageStr = _imageArray[index - 1];
    }
    return imageStr;
}


#pragma mark 创建定时器
-(void)cretaeTimer{
    if (_timer) {
        [_timer invalidate];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(scrollImg:) userInfo:nil repeats:YES];
}

-(void)dealloc{
    [_timer invalidate];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
