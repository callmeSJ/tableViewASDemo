//
//  collectionView.m
//  tableViewS
//
//  Created by SJ on 16/7/12.
//  Copyright © 2016年 SJ. All rights reserved.
//
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define NewScale kScreenWidth/320.0000*0.5

#import "collectionView.h"
#import "collectionCell.h"
static NSString *collCell = @"collectionCell";

@interface collectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *array;
@end

@implementation collectionView

-(void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 8;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10*NewScale, 10*NewScale, kScreenWidth-160*NewScale, 80) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[collectionCell class] forCellWithReuseIdentifier:collCell];
    
    [self addSubview:_collectionView];
    
    [self initData];
//    float y = [self collectionViewSize];
//    NSLog(@"%f",y);

}

-(void)initData{
    _array = [[NSMutableArray alloc]initWithObjects:@"谭门",@"博鳌亚洲论坛国际会议中心",@"玉带滩",@"sdsdsdsds",@"sdsdsdsds",@"sdsdsdsds",@"sdsdsdsds",@"sdsdsdsds",@"sdsdsdsds",@"sdsdsdsds",@"sdsdsdsds",nil];
    [_collectionView reloadData];
    
}
//获取collectionView的size
-(float)collectionViewSize{
    NSIndexPath *firstIndexPath = [[_collectionView indexPathsForVisibleItems] firstObject];
    NSLog(@"%@",firstIndexPath);
    NSIndexPath *lastIndexPath = [[_collectionView indexPathsForVisibleItems] lastObject];
    UICollectionViewCell *firstCell = [_collectionView cellForItemAtIndexPath:firstIndexPath];
    UICollectionViewCell *lastCell = [_collectionView cellForItemAtIndexPath:lastIndexPath];
    float y = lastCell.frame.origin.y - firstCell.frame.origin.y;
    NSLog(@"y = %f,%f,%f",y,firstCell.frame.origin.y,lastCell.frame.origin.y);
//    float y = lastCell.frame.origin
    return  y;
}
#pragma mark layout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [_array objectAtIndex:indexPath.row];
    
    //计算字符串长度
//     CGSize detailSize = [@"你的字符串" sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(200, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13.0f]}];
    CGSize x = CGSizeMake(ceilf(size.width)+10, ceilf(size.height));
    return x;
}

#pragma mark collectionView代理方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  _array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    collectionCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:collCell forIndexPath:indexPath];
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.layer.borderWidth = 2;
    cell.layer.cornerRadius = 5;
    
    if(!cell){
        cell = [[collectionCell alloc]init];
    }
    cell.text = [_array objectAtIndex:indexPath.row];


    
    return cell;
    
}

#warning 返回自身是否响应事件，如果不响应会继续传递事件，point表示你的触点，可以用来判断手势的起点
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return NO;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
