//
//  hotTableViewCell.m
//  走起WeakDay
//
//  Created by scjy on 16/1/11.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "hotTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface hotTableViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *MainImageView;

@property (strong, nonatomic) IBOutlet UILabel *FavoriteLable;


@end


@implementation hotTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(hotActivityModel *)model{
    [self.MainImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    self.FavoriteLable.text = model.acticityId;
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
