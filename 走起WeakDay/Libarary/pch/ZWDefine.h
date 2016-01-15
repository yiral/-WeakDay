//
//  ZWDefine.h
//  走起WeakDay
//
//统一定义所有的接口；

//  Created by scjy on 16/1/6.
//  Copyright © 2016年 刘海艳. All rights reserved.
//
#import "UIViewController+Comment.h"

typedef NS_ENUM(NSInteger,classifyListType) {
    classifyListTypeShowReportoire = 1,//演出剧目
    classifyListTypeTourisePlace,     //景点场馆；
    classifyListTypeStudyPUZ,        //学习益智；
    classifyListTypeFamilyTravel    //亲子驴友
    
};

#ifndef ZWDefine_h
#define ZWDefine_h

//首页数据接口；
#define kMainDtaList @"http://e.kumi.cn/app/v1.3/index.php?_s_=02a411494fa910f5177d82a6b0a63788&_t_=1451307342&channelid=appstore&cityid=1&lat=34.62172291944134&limit=30&lng=112.4149512442411&page=1"
//http://e.kumi.cn/app/v1.3/catelist.php?

//活动详情接口；
#define kActivityDetail @"http://e.kumi.cn/app/articleinfo.php?_s_=6055add057b829033bb586a3e00c5e9a&_t_=1452071715&channelid=appstore&cityid=1&lat=34.61356779156581&lng=112.4141403843618"
//活动专题
#define kActivityTheme @"http://e.kumi.cn/app/positioninfo.php?_s_=1b2f0563dade7abdfdb4b7caa5b36110&_t_=1452218405&channelid=appstore&cityid=1&lat=34.61349052974207&lng=112.4139739846577&page=1"
//竞选活动接口；
#define kGoodActivity @"http://e.kumi.cn/app/articlelist.php?_s_=a9d09aa8b7692ebee5c8a123deacf775&_t_=1452236979&channelid=appstore&cityid=1&lat=34.61351314785497&limit=30&lng=112.4140755658942&type=1"

//http://e.kumi.cn/app/positionlist.php?_s_=e2b71c66789428d5385b06c178a88db2&_t_=1452237051&channelid=appstore&cityid=1&lat=34.61351314785497&lng=112.4140755658942&page=1
//limit=30&
//热门专题接口；
#define HotActivity @"http://e.kumi.cn/app/positionlist.php?_s_=e2b71c66789428d5385b06c178a88db2&_t_=1452237051&channelid=appstore&cityid=1&lat=34.61351314785497&limit=30&lng=112.4140755658942"

//分类列表接口
#define classify @"http://e.kumi.cn/app/v1.3/catelist.php?_s_=78284130ab87a8396ec03073eac9c50a&_t_=1452495156&channelid=appstore&cityid=1&lat=34.61356398594803&limit=30&lng=112.4140434532402"

//第二主页面，发现的接口；
#define discovery @"http://e.kumi.cn/app/found.php?_s_=a82c7d49216aedb18c04a20fd9b0d5b2&_t_=1451310230&channelid=appstore&cityid=1&lat=34.62172291944134&lng=112.4149512442411"

#define RGB(x,y,z) [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]

#define SeparatorColor RGB(228, 228, 228) //222 160 改成170

//新浪微博分享；
#define AppKey @"3959439932"

#define AppSecret @"d0d079dc48483bced9fb7345c0d12f9a"

//#define kSecret @"http://https://api.weibo.com/oauth2/default.html"

#define kRedirectURI @"https://api.weibo.com/oauth2/default.html"


//微信分享；
#define kWeiXinAppId @"wxbe67a52b21099443"

#define kWeiXinAppSerect @"3890ba8944c04aad45e2bede75db0a7b"

#endif /* ZWDefine_h */
