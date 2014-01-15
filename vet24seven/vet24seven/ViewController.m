//
//  ViewController.m
//  vet24seven
//
//  Created by Edgar Nunez on 1/5/14.
//  Copyright (c) 2014 Edgar Nunez. All rights reserved.
//

#import "ViewController.h"

#import <ShowKit/ShowKit.h>

#define VET24SEVEN_URL_IPHONE @"http://demo.vet24seven.com"

@interface ViewController () {
    UIWebView *appWebView;
}

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
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(connectionStateChanged:)
     name:SHKConnectionStatusChangedNotification
     object:nil];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"request url: %@", request.URL.absoluteString);
    
    if ([request.URL.absoluteString isEqualToString: @"http://demo.vet24seven.com/choose.php?user_id=3"]) {
        [ShowKit login: @"238.edgar.a.nunezgmail.com" password: @"123456"];
    }
    
    NSString *confirmURL = @"http://demo.vet24seven.com/confirmation.php?referenceNumber=";
    NSRange range = [request.URL.absoluteString rangeOfString: confirmURL];
    
    if (range.location != NSNotFound) {
        [ShowKit initiateCallWithSubscriber: @"238.calbertlai"];
    }
    
    return YES;
}

#pragma mark -
#pragma mark ShowKit callbacks

- (void) connectionStateChanged: (NSNotification*) notification
{
    SHKNotification* showNotice;
    NSString* value;
    
    showNotice = (SHKNotification*) [notification object];
    value = (NSString*) showNotice.Value;
    
    if ([value isEqualToString: SHKConnectionStatusCallTerminated]){
        //call is terminated
    } else if ([value isEqualToString: SHKConnectionStatusInCall]) {
        //call just got changed to in call,
        
    } else if ([value isEqualToString: SHKConnectionStatusLoggedIn]) {
        NSLog(@"238.edgar.a.nunezgmail.com is logged in.");
        
    } else if ([value isEqualToString: SHKConnectionStatusNotConnected]) {
        //user is no longer connected
    } else if ([value isEqualToString: SHKConnectionStatusLoginFailed]) {
        //login has failed
        NSLog(@"user login failed.");
    } else if ([value isEqualToString: SHKConnectionStatusCallIncoming]) {
        //user has a call incoming, accept or reject the call
        UIAlertView *callAlert = [[UIAlertView alloc] initWithTitle: @"Incoming V-Consult" message: @"You have an incoming V-Consult. Do you want to accept this consultation & begin a video session?" delegate: self cancelButtonTitle: @"No" otherButtonTitles: @"Yes", nil];
        [callAlert show];
    }
}

@end
