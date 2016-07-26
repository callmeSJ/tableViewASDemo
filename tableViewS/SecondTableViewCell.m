//
//  SecondTableViewCell.m
//  tableViewS
//
//  Created by SJ on 16/7/12.
//  Copyright © 2016年 SJ. All rights reserved.
//
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define NewScale kScreenWidth/320.0000*0.5

#import "SecondTableViewCell.h"
#import "collectionView.h"

@implementation SecondTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        //图片
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(18*NewScale, 28*NewScale, 125*NewScale, 126*NewScale)];
        imgView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:imgView];
        
        collectionView *colView = [[collectionView alloc]initWithFrame:CGRectMake(150*NewScale, 28*NewScale, kScreenWidth - 150*NewScale, 90)];
        [colView createCollectionView];
        [self.contentView addSubview:colView];
        
    }
    return self;
}

@end
