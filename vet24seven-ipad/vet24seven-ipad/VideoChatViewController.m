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
    mainVideoUIView = [[UIView alloc] initWithFrame: [UIScreen mainScreen].bounds];
    mainVideoUIView.backgroundColor = [UIColor darkGrayColor];
    mainVideoUIView.autoresizesSubviews = YES;
    mainVideoUIView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.view = mainVideoUIView;
    
    prevVideoUIView = [[UIView alloc] initWithFrame: CGRectMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2, (self.view.bounds.size.width / 2) - 10, (self.view.bounds.size.height / 2) - 10)];
    prevVideoUIView.backgroundColor = [UIColor lightGrayColor];
    prevVideoUIView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview: prevVideoUIView];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44);
    NSMutableArray *items = [[NSMutableArray alloc] init];
    UIBarButtonItem *dismissButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone target: self action: @selector(endCall)];
    [items addObject: dismissButton];
    [toolbar setItems:items animated: NO];
    [self.view addSubview:toolbar];
    
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

        [ShowKit setState: SHKVideoInputDeviceResolution720p forKey: SHKVideoInputDeviceResolutionKey];
        
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
