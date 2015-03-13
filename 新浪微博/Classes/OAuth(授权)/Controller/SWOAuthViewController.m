//
//  SWOAuthViewController.m
//  新浪微博
//
//  Created by apple on 14-7-8.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SWOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "SWControllerTool.h"
#import "SWAccountTool.h"
#import "SWAccount.h"
#import "SWAccessTokenParam.h"
@interface SWOAuthViewController () <UIWebViewDelegate>

@end

@implementation SWOAuthViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.创建UIWebView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    // 2.加载登录页面
    NSString *strUrl = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",SWClientId,SWRedirectUrl];
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    // 3.设置代理
    webView.delegate = self;
}

#pragma mark - UIWebViewDelegate
/**
 *  UIWebView开始加载资源的时候调用(开始发送请求)
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载中..."];
}

/**
 *  UIWebView加载完毕的时候调用(请求完毕)
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

/**
 *  UIWebView加载失败的时候调用(请求失败)
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

/**
 *  UIWebView每当发送一个请求之前，都会先调用这个代理方法（询问代理允不允许加载这个请求）
 *
 *  @param request        即将发送的请求
 
 *  @return YES : 允许加载， NO : 禁止加载
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.获得请求地址
    NSString *url = request.URL.absoluteString;
    
    // 2.判断url是否为回调地址
    NSString *urlStr = [SWRedirectUrl stringByAppendingString:@"/?code="];
    NSRange range = [url rangeOfString:urlStr];
    if (range.location != NSNotFound) { // 是回调地址
        // 截取授权成功后的请求标记
        unsigned long from = range.location + range.length;
        NSString *code = [url substringFromIndex:from];
        
        // 根据code获得一个accessToken
        [self accessTokenWithCode:code];
        
        // 禁止加载回调页面
        return NO;
    }
    
    return YES;
}

/**
 *  根据code获得一个accessToken(发送一个POST请求)
 *
 *  @param code 授权成功后的请求标记
 */
- (void)accessTokenWithCode:(NSString *)code
{
    // 1.封装请求参数
    SWAccessTokenParam *param = [[SWAccessTokenParam alloc] init];
    param.client_id = SWClientId;
    param.client_secret = SWClientSecret;
    param.redirect_uri = SWRedirectUrl;
    param.grant_type = @"authorization_code";
    param.code = code;
    
    // 2.获取AccessToken
    [SWAccountTool accessTokenWithParam:param success:^(SWAccount *account) {
        // 隐藏HUD
        [MBProgressHUD hideHUD];
        [SWAccountTool save:account];
        [SWControllerTool chooseRootViewController];
    } failure:^(NSError *error) {
        // 隐藏HUD
        [MBProgressHUD hideHUD];
        
        SWLog(@"请求失败--%@", error);
    }];
   }

/**
 Request failed: unacceptable content-type: text/plain
 */

@end
