//
//  ShareView.m
//  走起WeakDay
//
//  Created by scjy on 16/1/14.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "ShareView.h"
#import <MessageUI/MessageUI.h>
#import "ProgressHUD.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"
#import "WBHttpRequest+WeiboShare.h"

@interface ShareView ()

@property (nonatomic, strong) UIView *shareView;
@property(nonatomic, strong) UIView *blackView;


@end

@implementation ShareView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configShareView];
    }
    return self;
}
-(void)configShareView{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    self.blackView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    self.blackView.backgroundColor = [UIColor colorWithRed:188/255.0 green:196/255.0 blue:231/255.0 alpha:1.0];
    
    self.shareView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 200, kScreenWidth, 200)];
    _shareView.backgroundColor = [UIColor cyanColor];
    [window addSubview:_shareView];
    
    //微博
    UIButton *weiboButton = [UIButton buttonWithType:UIButtonTypeCustom];
    weiboButton.frame = CGRectMake(20, 40, 35, 35);
    [weiboButton addTarget:self action:@selector(shareWeiBo) forControlEvents:UIControlEventTouchUpInside];
    [weiboButton setImage:[UIImage imageNamed:@"ic_com_sina_weibo_sdk_login_button_with_frame_logo_focused"] forState:UIControlStateNormal];
    [_shareView addSubview:weiboButton];
    
    //circle;
    UIButton *circleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    circleButton.frame = CGRectMake(120, 40, 35, 35);
    [circleButton setImage:[UIImage imageNamed:@"py_normal"] forState:UIControlStateNormal];
    [circleButton addTarget:self action:@selector(shareCircle) forControlEvents:UIControlEventTouchUpInside];
    [_shareView addSubview:circleButton];
    
    //微信；
    UIButton *friendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    friendButton.frame = CGRectMake(220, 40, 35, 35);
    [friendButton setImage:[UIImage imageNamed:@"wx_normal"] forState:UIControlStateNormal];
    [friendButton addTarget:self action:@selector(shareFriend) forControlEvents:UIControlEventTouchUpInside];
    [_shareView addSubview:friendButton];
    
    
    //remove;
    UIButton *removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    removeButton.frame = CGRectMake(20, 130, kScreenWidth - 40, 40);
    [removeButton setTitle:@"取消" forState:UIControlStateNormal];
    [removeButton addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    [_shareView addSubview:removeButton];
    
    
    

    
    
}
#pragma mark-------------------share分享
-(void)shareWeiBo{
    
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:myDelegate.wbtoken];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    
    [WeiboSDK sendRequest:request];
    self.shareView.hidden = YES;
    
    
}
- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
    message.text = NSLocalizedString(@"测试通过WeiboSDK发送文字到微博!", nil);
    return message;
}


-(void)shareCircle{
    
    
    
}
-(void)shareFriend{
    
    
}

-(void)remove{
    //    [UIView animateWithDuration:<#(NSTimeInterval)#> animations:^{
    //        <#code#>
    //    } completion:^(BOOL finished) {
    //        [self.]
    //    }]
    //    self.shareView.hidden = YES;
//    [UIView an];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
