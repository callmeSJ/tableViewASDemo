//
//  tableCellTableViewCell.m
//  tableViewS
//
//  Created by SJ on 16/7/10.
//  Copyright © 2016年 SJ. All rights reserved.
//

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define NewScale kScreenWidth/320.0000*0.5


#import "tableCellTableViewCell.h"

@interface tableCellTableViewCell()

@property (nonatomic, strong) UILabel *label;

@end
@implementation tableCellTableViewCell

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
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.8, 0.8, 0.8, 1 });
        //图片
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(18*NewScale, 28*NewScale, 125*NewScale, 126*NewScale)];
        [self.contentView addSubview:_imgView];
        //第一行lable
        self.lable1 = [[UILabel alloc]initWithFrame:CGRectMake(171*NewScale, 38*NewScale, 190*NewScale, 35*NewScale)];
        self.lable1.font = [UIFont fontWithName:@"Arial" size:22*NewScale];
        self.lable1.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_lable1];
        //第二行lable
        self.lable2 = [[UILabel alloc]initWithFrame:CGRectMake(171*NewScale, 78*NewScale, 220*NewScale, 30*NewScale)];
        self.lable2.font = [UIFont fontWithName:@"Arial" size:17*NewScale];
        self.lable2.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_lable2];
        //银卡
        UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(171*NewScale, 136*NewScale, 50*NewScale, 28*NewScale)];
        [button1 setTitle:@"银卡" forState:UIControlStateNormal];
        button1.titleLabel.font = [UIFont fontWithName:@"Arial" size:17*NewScale];
        [button1.layer setBorderWidth:1];
        [button1.layer setBorderColor:colorref];
        [button1.layer setCornerRadius:5];
        [button1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:button1];
        //金卡
        UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(232*NewScale, 136*NewScale, 50*NewScale, 28*NewScale)];
        [button2 setTitle:@"金卡" forState:UIControlStateNormal];
        button2.titleLabel.font = [UIFont fontWithName:@"Arial" size:17*NewScale];
        [button2.layer setBorderWidth:1];
        [button2.layer setBorderColor:colorref];
        [button2.layer setCornerRadius:5];
        [button2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        [self.contentView addSubview:button2];
        //白金卡
        UIButton *button3 = [[UIButton alloc]initWithFrame:CGRectMake(290*NewScale, 136*NewScale, 60*NewScale, 28*NewScale)];
        [button3 setTitle:@"白金卡" forState:UIControlStateNormal];
        button3.titleLabel.font = [UIFont fontWithName:@"Arial" size:17*NewScale];
        [button3.layer setBorderWidth:1];
        [button3.layer setBorderColor:colorref];
        [button3.layer setCornerRadius:5];
        [button3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:button3];
        //购买按钮
        UIButton *button4 = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth - 109*NewScale), 70*NewScale, 90*NewScale, 45*NewScale)];
        [button4 setTitle:@"购买" forState:UIControlStateNormal];
        [button4.layer setCornerRadius:5];
        button4.titleLabel.font = [UIFont fontWithName:@"Arial" size:17*NewScale];
        [button4 setTintColor:[UIColor whiteColor]];
        [button4 setBackgroundColor:[UIColor colorWithRed:37/255.0f green:161/255.0f blue:174/255.0f alpha:1]];
        [self.contentView addSubview:button4];
    }
    return  self;

}



-(void)setText:(NSString *)text{
    //任何的重写Set方法，都要先把原来的Set功能给实现才能编写其他功能
    _text = text;

    //因为Cell的复用属性，所以所有的创建最好用懒加载的方式,而且要先把contentView上的视图全部移除，避免重复粘贴
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(18, 20, 100, 20)];
    }
    _label.text = _text;
    _label.textColor = [UIColor blackColor];
    
    //自定义的View都要添加在contentView上，不能直接添加在Cell上，不然会影响Cell的编辑状态
    [self.contentView addSubview:_label];
    /*
     UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(200, 20, 100, 20)];
     lable1.text = @"11";
     lable1.textColor = [UIColor blackColor];
     [self.contentView addSubview:lable1];
     
     UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(120, 6, 48, 48)];
     imageView.image = [UIImage imageNamed:@"China.png"];
     [self.contentView addSubview:imageView];
     */
    
    
}


@end
