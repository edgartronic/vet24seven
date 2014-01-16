//
//  VideoChatViewController.m
//  vet24seven-ipad
//
//  Created by Edgar Nunez on 1/13/14.
//  Copyright (c) 2014 Edgar Nunez. All rights reserved.
//

#import "VideoChatViewController.h"

@interface VideoChatViewController ()

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
        
    }
    return self;
}

- (void) loadView {
    CGRect r = [UIScreen mainScreen].bounds;
    
    UIView *bg = [[UIView alloc] initWithFrame: r];
    bg.backgroundColor = [UIColor lightGrayColor];
    bg.autoresizesSubviews = YES;
    self.view = bg;
    
    mainVideoUIView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 1024, 724)];
    mainVideoUIView.backgroundColor = [UIColor darkGrayColor];
    mainVideoUIView.autoresizesSubviews = YES;
    [self.view addSubview: mainVideoUIView];
//    
//    prevVideoUIView = [[UIView alloc] initWithFrame: CGRectMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2, (self.view.bounds.size.width / 2) - 60, (self.view.bounds.size.height / 2) - 60)];
//    prevVideoUIView.backgroundColor = [UIColor lightGrayColor];
//    prevVideoUIView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    [self.view addSubview: prevVideoUIView];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleDefault;
    toolbar.frame = CGRectMake(0, 724, 1024, 44);
    
    UIBarButtonItem *button1 = [[UIBarButtonItem alloc] initWithTitle: @"Done" style: UIBarButtonItemStyleDone target: self action: @selector(endCall)];
    button1.style = UIBarButtonItemStyleDone;
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target: self action: nil];
    
    NSArray *ar = [NSArray arrayWithObjects: button1, spacer, nil];
    
    //add buttons to the toolbar
    [toolbar setItems: ar];
    
    //add toolbar to the main view
    [self.view addSubview: toolbar];
    
}


- (void) viewDidAppear:(BOOL)animated {
    [ShowKit setState: self.mainVideoUIView forKey: SHKMainDisplayViewKey];
    [ShowKit setState: self.prevVideoUIView forKey: SHKPreviewDisplayViewKey];
    [ShowKit setState: SHKVideoLocalPreviewEnabled forKey: SHKVideoLocalPreviewModeKey];
    
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

- (void) endCall {
    [ShowKit hangupCall];
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (void) connectionStateChanged: (NSNotification*) notification
{
    SHKNotification* showNotice;
    NSString* value;
    
    showNotice = (SHKNotification*) [notification object];
    value = (NSString*) showNotice.Value;
    
    if ([value isEqualToString: SHKConnectionStatusCallTerminated]){
        //call is terminated
        [[NSNotificationCenter defaultCenter] removeObserver: self];
        [self dismissViewControllerAnimated: YES completion: nil];

    } else if ([value isEqualToString: SHKConnectionStatusInCall]) {
        
        
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
