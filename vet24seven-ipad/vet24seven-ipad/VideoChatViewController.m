//
//  VideoChatViewController.m
//  vet24seven-ipad
//
//  Created by Edgar Nunez on 1/13/14.
//  Copyright (c) 2014 Edgar Nunez. All rights reserved.
//

#import "VideoChatViewController.h"

@interface VideoChatViewController ()

@property (readwrite, nonatomic) UIView *mainVideoUIView;
@property (readwrite, nonatomic) UIView *prevVideoUIView;

@end

@implementation VideoChatViewController

@synthesize mainVideoUIView, prevVideoUIView;

- (id) init {
    if (self == [super init]) {
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(connectionStateChanged:)
         name:SHKConnectionStatusChangedNotification
         object:nil];
        
        [ShowKit login: @"238.edgar.a.nunezgmail.com" password: @"123456"];
    }
    return self;
}

- (void) loadView {
    mainVideoUIView = [[UIView alloc] initWithFrame: [UIScreen mainScreen].bounds];
    mainVideoUIView.backgroundColor = [UIColor darkGrayColor];
    mainVideoUIView.autoresizesSubviews = YES;
    mainVideoUIView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.view = mainVideoUIView;
    
    prevVideoUIView = [[UIView alloc] initWithFrame: CGRectMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2, (self.view.bounds.size.width / 2) - 10, (self.view.bounds.size.height / 2) - 10)];
    prevVideoUIView.backgroundColor = [UIColor lightGrayColor];
    prevVideoUIView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview: prevVideoUIView];
    
}


- (void) viewDidAppear:(BOOL)animated {
    [ShowKit setState: self.mainVideoUIView forKey: SHKMainDisplayViewKey];
    [ShowKit setState: self.prevVideoUIView forKey: SHKPreviewDisplayViewKey];
    [ShowKit setState: SHKVideoLocalPreviewEnabled forKey: SHKVideoLocalPreviewModeKey];
    
    [ShowKit initiateCallWithSubscriber: @"238.calbertlai"];

}

- (void) viewDidDisappear:(BOOL)animated {
    [ShowKit setState: nil forKey: SHKMainDisplayViewKey];
    [ShowKit setState: nil forKey: SHKPreviewDisplayViewKey];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

        [ShowKit setState: mainVideoUIView forKey: SHKMainDisplayViewKey];
        [ShowKit setState: prevVideoUIView forKey: SHKPreviewDisplayViewKey];
        [ShowKit setState: SHKVideoLocalPreviewEnabled forKey: SHKPreviewDisplayViewKey];
        
    } else if ([value isEqualToString: SHKConnectionStatusLoggedIn]) {
        NSLog(@"user logged in.");
        
    } else if ([value isEqualToString: SHKConnectionStatusNotConnected]) {
        //user is no longer connected
    } else if ([value isEqualToString: SHKConnectionStatusLoginFailed]) {
        //login has failed
        NSLog(@"user login failed.");
    } else if ([value isEqualToString: SHKConnectionStatusCallIncoming]) {
        //user has a call incoming, accept or reject the call
    }
}

@end
