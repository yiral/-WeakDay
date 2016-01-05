//
//  MainTableViewCell.m
//  走起WeakDay
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "MainTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface MainTableViewCell ()
//活动图片；
@property (strong, nonatomic) IBOutlet UIImageView *ActivityImageView;
//活动名字；
@property (strong, nonatomic) IBOutlet UILabel *ActivityNameLable;

//活动价格；
@property (strong, nonatomic) IBOutlet UILabel *ActivityPricelLable;
//活动距离；
@property (strong, nonatomic) IBOutlet UIButton *ActivityDistanceBtn;

@end

@implementation MainTableViewCell


-(void)setMainModel:(MainModel *)mainModel{
    self.ActivityNameLable.text = mainModel.title;
    [self.ActivityImageView sd_setImageWithURL:[NSURL URLWithString:mainModel.image_big] placeholderImage:nil];
    self.ActivityPricelLable.text = mainModel.price;
    
//    NSLog(@"%@",self.ActivityNameLable.text);

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
