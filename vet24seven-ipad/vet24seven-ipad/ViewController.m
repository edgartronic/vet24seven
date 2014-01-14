//
//  ViewController.m
//  vet24seven-ipad
//
//  Created by Edgar Nunez on 1/8/14.
//  Copyright (c) 2014 Edgar Nunez. All rights reserved.
//

#import "ViewController.h"
#import <ShowKit/ShowKit.h>
#import "VideoChatViewController.h"

#define VET24SEVEN_URL_IPHONE @"http://demo.vet24seven.com/vet"

@interface ViewController () {
    UIWebView *appWebView;
}

- (void) launchVideoChatWithUsername: (NSString *) user andPass: (NSString *) password;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    appWebView = [[UIWebView alloc] initWithFrame: self.view.bounds];
    appWebView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    appWebView.delegate = self;
    [self.view addSubview: appWebView];
    
    NSURL *_url = [NSURL URLWithString: VET24SEVEN_URL_IPHONE];
    [appWebView loadRequest: [NSURLRequest requestWithURL: _url]];
    
}

- (void) viewDidAppear:(BOOL)animated {
    [self launchVideoChatWithUsername: nil andPass: nil];
}

- (void) launchVideoChatWithUsername: (NSString *) user andPass: (NSString *) password {
    
    VideoChatViewController *videoChatController = [[VideoChatViewController alloc] init];
    [self presentViewController: videoChatController animated: YES completion: nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    
    return YES;
}

@end
