//
//  collectionCell.m
//  tableViewS
//
//  Created by SJ on 16/7/12.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import "collectionCell.h"

@interface collectionCell()

@property(nonatomic,strong)UILabel *lable1;

@end

@implementation collectionCell

-(void)setText:(NSString *)text{
 
    _text = text;
    CGSize size = [_text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13.0f]}];
    CGSize x = CGSizeMake(ceilf(size.width), ceilf(size.height));
    
    for(UIView *view in self.contentView.subviews){
        [view removeFromSuperview];
    }
    if(!_lable1){
        _lable1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, x.width, 10)];
    }
    _lable1.text = _text;
    _lable1.font = [UIFont fontWithName:@"Arial" size:13];
    _lable1.textColor = [UIColor lightGrayColor];
  
    [self.contentView addSubview:_lable1];

}
@end
