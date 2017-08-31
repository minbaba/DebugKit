//
//  YWViewController.m
//  DebugKit
//
//  Created by minbaba on 08/11/2017.
//  Copyright (c) 2017 minbaba. All rights reserved.
//

#import "YWViewController.h"




@interface YWViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation YWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://baidu.com"]];
    [_webView loadRequest:request];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
