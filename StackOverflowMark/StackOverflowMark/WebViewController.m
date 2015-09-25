//
//  WebViewController.m
//  StackOverflowMark
//
//  Created by Mark Lin on 9/16/15.
//  Copyright (c) 2015 Mark Lin. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>


@interface WebViewController ()<WKNavigationDelegate>


@end

@implementation WebViewController


- (void)viewDidLoad {WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame];
  [self.view addSubview:webView];
  webView.navigationDelegate = self;
  
  NSString *baseURL = @"https://stackexchange.com/oauth/dialog";
  NSString *clientID = @"5575";
  NSString *redirectURI = @"https://stackexchange.com/oauth/login_success";
  NSString *finalURL = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseURL,clientID,redirectURI];

  [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:finalURL]]];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
  
  NSLog(@"path: %@",navigationAction.request.URL.path);
  
  if ([navigationAction.request.URL.path isEqualToString:@"/oauth/login_success"]) {
    NSString *fragmentString = navigationAction.request.URL.fragment;
    NSArray *components = [fragmentString componentsSeparatedByString:@"&"];
    NSString *fullTokenParameter = components.firstObject;
    NSString *token = [fullTokenParameter componentsSeparatedByString:@"="].lastObject;
    
    NSString *key = @"*VDTT4nf1ZLSwtuOueeiPw((";

    if (token) {
      
      NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
      [userDefaults setObject:token forKey:@"token"];
      [userDefaults setObject:key forKey:@"key"];
      [self dismissViewControllerAnimated:true completion:nil];
      
    }
    else {
    //error of some sort
    }
  }
  decisionHandler(WKNavigationActionPolicyAllow);
  
}

@end
