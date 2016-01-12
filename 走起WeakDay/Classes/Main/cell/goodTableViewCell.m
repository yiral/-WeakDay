//
//  goodTableViewCell.m
//  走起WeakDay
//
//  Created by scjy on 16/1/8.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "goodTableViewCell.h"
#import "GoogActivityModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface goodTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *goodImageView;

@property (strong, nonatomic) IBOutlet UILabel *goodTittle;
@property (strong, nonatomic) IBOutlet UILabel *goodPriceLable;
@property (strong, nonatomic) IBOutlet UILabel *goodAgeLable;

@property (strong, nonatomic) IBOutlet UIImageView *goodImageAge;
@property (strong, nonatomic) IBOutlet UILabel *goodDistance;
@property (strong, nonatomic) IBOutlet UIButton *goodFavButton;

@end


@implementation goodTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.frame = CGRectMake(0, 0, kScreenWidth, 90);
}


-(void)setModel:(GoogActivityModel *)model{
    
    [self.goodImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    self.goodImageView.layer.cornerRadius = 20;
    self.goodImageView.clipsToBounds = YES;
    
    self.goodAgeLable.text = model.age;
    self.goodPriceLable.text = model.price;
    self.goodTittle.text = model.title;
    self.goodDistance.text = model.address;
    
    [self.goodFavButton setTitle:[NSString stringWithFormat:@"%lu",[model.counts integerValue]] forState:UIControlStateNormal];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
