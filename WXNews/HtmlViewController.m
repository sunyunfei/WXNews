//
//  HtmlViewController.m
//  医院查询Demo
//
//  Created by 孙云 on 16/5/4.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import "HtmlViewController.h"

@interface HtmlViewController ()<UIWebViewDelegate>
{
    UIWebView *webView;
    UIActivityIndicatorView *activeView;
}
@end

@implementation HtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"正文";
    [self initWebView];
    [self initActiveView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  加载webview
 */
- (void)initWebView{

    webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}
- (void)initActiveView{

    activeView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    activeView.center = self.view.center;
    activeView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:activeView];
    [activeView bringSubviewToFront:self.view];
}
- (void)webViewDidStartLoad:(UIWebView *)webView{

    [activeView startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{

    [activeView stopAnimating];
}
@end
