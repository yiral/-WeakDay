//
//  goodTableViewCell.m
//  走起WeakDay
//
//  Created by scjy on 16/1/8.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "goodTableViewCell.h"
#import "GoogActivityModel.h"
@interface goodTableViewCell (){
    
    IBOutlet UIImageView *headImageView;
    IBOutlet UILabel *ActiviteDistanceLable;
    IBOutlet UIImageView *ageImageView;
    
    IBOutlet UILabel *ActivityTitLable;
    
    IBOutlet UILabel *ActivityPricrLable;
    IBOutlet UIButton *loveContButton;
    
    IBOutlet UILabel *ageLable;
    

    
    
}

@end


@implementation goodTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.frame = CGRectMake(0, 0, kScreenWidth, 90);
}


-(void)setModel:(GoogActivityModel *)model{
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
