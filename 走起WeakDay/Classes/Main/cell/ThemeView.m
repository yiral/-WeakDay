//
//  ThemeView.m
//  走起WeakDay
//
//  Created by scjy on 16/1/8.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "ThemeView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppDelegate.h"
@interface ThemeView ()
@property(nonatomic, strong) UIImageView *headImageView;
@property(nonatomic, strong) UIScrollView *mainScrollView;
@end

@interface ThemeView ()
{
    //保存上一次图片底部的高度；
    CGFloat _PreviousImageBottom;
    //上一张图片的高度；
    CGFloat _PreviousImageHeight;
    //最后一个label底部高度
    CGFloat _lastLabelBottom;
}
@end

@implementation ThemeView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }
    return self;
}
//自定义视图；
-(void)configView{
    
    
    
    [self.mainScrollView addSubview:self.headImageView];
    [self addSubview:self.mainScrollView];
}


#pragma mark--------------懒加载
-(UIScrollView *)mainScrollView{
    if (_mainScrollView == nil) {
       self.mainScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    
    }
    return _mainScrollView;
}


-(UIImageView *)headImageView{
    if (_headImageView == nil) {
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 186)];
    }
    return _headImageView;
    
    
}

#pragma mark--------------setDic
-(void)setDic:(NSDictionary *)dic{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]] placeholderImage:nil];
    [self drawContantWithArray:dic[@"content"]];
 
}

-(void)drawContantWithArray:(NSArray *)contantArray{
    for (NSDictionary *dic in contantArray) {
        //计算文字高度
        CGFloat height = [HWTools getTextHeightWithTest:dic[@"description"] bigestSize:CGSizeMake(kScreenWidth, 1000) textFound:15.0];
        CGFloat y ;
        if (_PreviousImageBottom >186) {
            //一开始第一个lable必须是500开始；即如果图片底部的高度没有值，也就是小于500，也就说明是加载第一个lable，那么y值不应该减去500；
            y =  _PreviousImageBottom ;
        }else{
            y = 186 + _PreviousImageBottom;
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
                [imageView sd_setImageWithURL:[NSURL URLWithString:urldic[@"url"]] placeholderImage:nil];
                [self.mainScrollView addSubview:imageView];
                //每次都保留图片底部的高度；
                _PreviousImageBottom = imageView.bottom + 5;
                
                if (urlsArray.count >1) {
                    lastImageBotton = imageView.bottom;
                }
            }
            
        }
        
    }
    
    self.mainScrollView.contentSize = CGSizeMake(kScreenWidth, _lastLabelBottom +20);
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
