//
//  DiscoverTableViewCell.m
//  走起WeakDay
//
//  Created by scjy on 16/1/12.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "DiscoverTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DiscoverTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *HeadImageView;
@property (strong, nonatomic) IBOutlet UILabel *lovelyLable;



@end


@implementation DiscoverTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(diccoverModel *)model{
    [self.HeadImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    self.HeadImageView.layer.cornerRadius = 62;
    self.HeadImageView.clipsToBounds = YES;
    self.lovelyLable.text = model.title;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
