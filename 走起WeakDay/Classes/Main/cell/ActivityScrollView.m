//
//  ActivityScrollView.m
//  走起WeakDay
//
//  Created by scjy on 16/1/7.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "ActivityScrollView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "HWTools.h"
#import "UIView+Extension.h"
@interface ActivityScrollView ()

{
    //保存上一次图片底部的高度；
    CGFloat _PreviousImageBottom;
    //上一张图片的高度；
    CGFloat _PreviousImageHeight;

    //最后一个label底部高度
    CGFloat _lastLabelBottom;
}
//图片
@property (strong, nonatomic) IBOutlet UIImageView *headimageView;
//活动题目
@property (strong, nonatomic) IBOutlet UILabel *ActitityTitleLable;
//活动时间
@property (strong, nonatomic) IBOutlet UILabel *ActivityTimeLable;
//喜欢的人数
@property (strong, nonatomic) IBOutlet UILabel *favoriteLable;
//整个视图的加载
@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;
//价格简介
@property (strong, nonatomic) IBOutlet UILabel *priceLable;
//地点
@property (strong, nonatomic) IBOutlet UILabel *activityDressLable;
//联系电话
@property (strong, nonatomic) IBOutlet UILabel *activityPhoneLable;



@end

@implementation ActivityScrollView

-(void)awakeFromNib{
    
    self.mainScrollView.contentSize = CGSizeMake(kScreenWidth, 10000);
}
-(void)setDict:(NSDictionary *)dict{
    //活动图片
    NSArray *urls = dict[@"urls"];
    [self.headimageView sd_setImageWithURL:[NSURL URLWithString:urls[0]] placeholderImage:nil ];
    //活动标题；
    self.ActitityTitleLable.text = dict[@"title"];
    //多少人收藏
    self.favoriteLable.text = [NSString stringWithFormat:@"%@人收藏",dict[@"fav"]];
    //活动电话
    self.activityPhoneLable.text = dict[@"tel"];
    //活动价格
    self.priceLable.text = dict[@"pricedesc"];
    //活动地址；
    self.activityDressLable.text = dict[@"address"];
    
    //活动时间段
    NSString *startTime = [HWTools getDateFromString:dict[@"new_start_date"]];
    NSString *endTime = [HWTools getDateFromString:dict[@"new_end_date"]];
    self.ActivityTimeLable.text = [NSString stringWithFormat:@"  正在进行：%@-%@",startTime,endTime];
    /*
     
     self.activityTitleLable.text = dataDic[@"title"];
     
     NSString *starTime = [HWtools getDateFromString:dataDic[@"new_start_date"]];
     NSString *endTime = [HWtools getDateFromString:dataDic[@"new_end_date"]];
     self.activityTimeLable.text = [NSString stringWithFormat:@"正在进行：%@-%@",starTime,endTime];
     
     */
    
    //活动详情；
    [self drawContantWithArray:dict[@"content"]];
    
}
-(void)drawContantWithArray:(NSArray *)contantArray{


    for (NSDictionary *dic in contantArray) {

        
        //计算文字高度
        CGFloat height = [HWTools getTextHeightWithTest:dic[@"description"] bigestSize:CGSizeMake(kScreenWidth, 1000) textFound:15.0];
        CGFloat y ;
        if (_PreviousImageBottom >400) {
            //一开始第一个lable必须是500开始；即如果图片底部的高度没有值，也就是小于500，也就说明是加载第一个lable，那么y值不应该减去500；
            y =  _PreviousImageBottom ;
        }else{
            y = 400 + _PreviousImageBottom;
        }
        //如果标题存在；
        NSString *tittle = dic[@"title"];
        if (tittle != nil) {
            UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, y, kScreenWidth - 20, 30)];
            titleLable.text = tittle;
            [self.mainScrollView addSubview:titleLable];
            y+=30;
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, y, kScreenWidth - 20, height)];
        label.text = dic[@"description"];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:15.0];
        [self.mainScrollView addSubview:label];
        //保留最后一个lable的高度，是下边lablebar的高度，
        _lastLabelBottom = label.bottom+10;
        
        NSArray *urlsArray = dic[@"urls"];
        if (urlsArray == nil) { //当某一个段落中没有图片的时候，上次图片的高度用上次label的底部高度+10
            _PreviousImageBottom = label.bottom +10;
            

        }else{
            CGFloat lastImageBotton =0.0;
            for (NSDictionary *urldic in urlsArray) {
                CGFloat imgY;
                if (urlsArray.count > 1) {
                    if (lastImageBotton == 0.0) {
                        if (tittle != nil) {
                            imgY = _PreviousImageBottom + label.height+30 +5;
                        }else{
                            imgY = _PreviousImageBottom +label.height +5;
                        }
                    }else{
                        imgY = lastImageBotton + 10;
                    }
                }else{
                    imgY = label.bottom;
                }
                CGFloat width = [urldic[@"width"] integerValue];
                CGFloat imageHeight = [urldic[@"height"] integerValue];
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, imgY, kScreenWidth - 20, (kScreenWidth - 20)/width * imageHeight)];
//                imageView.backgroundColor = [UIColor redColor];
                [imageView sd_setImageWithURL:[NSURL URLWithString:urldic[@"url"]] placeholderImage:nil];
                [self.mainScrollView addSubview:imageView];
                //每次都保留图片底部的高度；就是scrolloview的高度；
                _PreviousImageBottom = imageView.bottom + 5;

                if (urlsArray.count >1) {
                    lastImageBotton = imageView.bottom;
                }


                
            }

        }
        //每次都保留最后图片底部的高度；就是scrolloview的高度；
        _lastLabelBottom = label.bottom > _PreviousImageBottom ? label.bottom+70:_PreviousImageBottom + 70;
        
    }
    
    self.mainScrollView.contentSize = CGSizeMake(kScreenWidth, _lastLabelBottom +20);

}


@end
