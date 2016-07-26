//
//  ViewController.m
//  tableViewS
//
//  Created by SJ on 16/7/2.
//  Copyright © 2016年 SJ. All rights reserved.
//
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define NewScale kScreenWidth/320.0000*0.5


#import "ViewController.h"
#import "cycleScrollImg.h"
#import "tableCellTableViewCell.h"
#import "SecondTableViewCell.h"
#import "collectionView.h"
static NSString *tableViewCell = @"tableViewCell";
static NSString *tableViewCell2 = @"tableViewCell2";

@interface ViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    BOOL flag ;
    float collectionHeight;
}
@property(nonatomic,strong)UITableView *tableView;
//高
//@property(nonatomic,strong)UITableView *tableView2;
#warning 告诉我这个数组声明出来是用来做什么的，没用的东西麻烦删掉或者注释解释是保留参数好吗
//@property(nonatomic,strong)NSArray *tableArray;
//@property(nonatomic,strong)UIButton *button1;
//@property(nonatomic,strong)UIButton *button2;


#warning 新增参数，标记选择按钮
@property (nonatomic, assign) NSInteger btnIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    flag = true;
    // Do any additional setup after loading the view, typically from a nib.
    _btnIndex = 0;
    collectionHeight = 0;
    [self createTableView];
    [self getCollectionHeight];

}
//获得高
-(void)getCollectionHeight{
    collectionView *colView = [[collectionView alloc]init];
    collectionHeight = [colView collectionViewSize];
}

#pragma mark 创建tableview
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight- 20) style:UITableViewStyleGrouped];
    [_tableView registerClass:[tableCellTableViewCell class] forCellReuseIdentifier:tableViewCell];
    [_tableView registerClass:[SecondTableViewCell class] forCellReuseIdentifier:tableViewCell2];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.tableHeaderView = [self createScrollerImg];
    
//    _tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight-20) style:UITableViewStyleGrouped];
//    [_tableView2 registerClass:[SecondTableViewCell class] forCellReuseIdentifier:tableViewCell2];
//    _tableView2.backgroundColor = [UIColor whiteColor];
//    _tableView2.delegate = self;
//    _tableView2.dataSource = self;
//    _tableView2.tableFooterView = [UIView new];
//    _tableView2.tableHeaderView = [self createScrollerImg];
//    _tableView2.hidden = YES;
//    [self.view addSubview:_tableView2];
    //创建滚动图片视图
//    CGFloat height = 803*kScreenWidth/1600;
//    
//    cycleScrollImg *img = [[cycleScrollImg alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, height)];
//    [img createCycleScrollImg];
//    _tableView.tableHeaderView = img;
    [self.view addSubview:_tableView];
}

//创建头视图
#warning tableView的结构要搞清楚，按钮明显是控制下面Cell的显示的，是跟下面的Cell是一伙的，怎么可以跟轮播图放在一起当做头视图呢
-(UIView *)createScrollerImg{
    CGFloat height = 803*kScreenWidth/1600;
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, height)];

    cycleScrollImg *img = [[cycleScrollImg alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    [img createCycleScrollImg];
    
//    _button1 = [[UIButton alloc]initWithFrame:CGRectMake(20, height + 25, 60, 30)];
//    _button1.backgroundColor = [UIColor whiteColor];
//    [_button1 setTitle:@"项目介绍" forState:UIControlStateNormal];
//    _button1.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
//    [_button1 addTarget:self action:@selector(firstButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    [_button1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    
//    
//    _button2 = [[UIButton alloc]initWithFrame:CGRectMake(120, height + 25, 60, 30)];
//    _button2.backgroundColor = [UIColor whiteColor];
//    [_button2 setTitle:@"户型介绍" forState:UIControlStateNormal];
//    _button2.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
//    [_button2 addTarget:self action:@selector(secondButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    [_button2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [headView addSubview:img];
//    [headView addSubview:_button1];
//    [headView addSubview:_button2];

   // [self.view addSubview:headView];
    return headView;
}

#warning 创建第一分区头视图
-(UIView *)createBtnView{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    
    NSArray *titleArray  = @[@"项目介绍",@"户型介绍"];
    for (int i =0; i<titleArray.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth*0.5*i, 0, kScreenWidth*0.5, 60)];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
        [btn addTarget:self action:@selector(btnSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.tag = 10000+i;
        [backView addSubview:btn];
        if (_btnIndex == i) {
            //当前选中按钮关闭交互
            btn.selected = YES;
            btn.userInteractionEnabled = NO;
        }
    }
    return backView;
    
}

#pragma mark  按钮点击方法

-(void)btnSelectAction:(UIButton *)btn{
    for (UIView *view in btn.superview.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *sBtn = (UIButton *)view;
            if (sBtn.isSelected) {
                sBtn.selected = NO;
                sBtn.userInteractionEnabled = YES;
            }
        }
//        btn.selected = YES;
//        btn.userInteractionEnabled = NO;
    }
    btn.selected = YES;
    btn.userInteractionEnabled = NO;

    //修改选中按钮，直接刷新table
    _btnIndex = btn.tag - 10000;
    [_tableView reloadData];
}
//-(void)firstButtonAction{
//    _tableView.hidden = NO;
//    _tableView2.hidden = YES;
//}
//
//-(void)secondButtonAction{
//    _tableView.hidden = YES;
//    _tableView2.hidden = NO;
//}


#pragma mark tableview的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#warning 新增第一分区头视图代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 60;
    }else{
        return 0;
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return  [self createBtnView];
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_btnIndex == 0){
        return 185*NewScale;
    }else{
        return 185*NewScale +30;
        
//    return collectionHeight + 100*NewScale;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
#warning 根据选中的按钮输出不同的Cell
    if (_btnIndex == 0) {
        tableCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.imgView.backgroundColor = [UIColor redColor];
            cell.lable1.text = @"度假宝1号(5年期)";
            cell.lable2.text = @"【海南】博鳌.海域度假公寓";
                return cell;

    }else{
        SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell2];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
    }
//    if(tableView == _tableView){
//    tableCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.imgView.backgroundColor = [UIColor redColor];
//    cell.lable1.text = @"度假宝1号(5年期)";
//    cell.lable2.text = @"【海南】博鳌.海域度假公寓";
//        return cell;
//
//    }else if(tableView == _tableView2){
//        SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell2];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//
//    }
    
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选择");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
