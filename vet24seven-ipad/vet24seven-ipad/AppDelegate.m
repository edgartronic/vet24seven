//
//  AppDelegate.m
//  vet24seven-ipad
//
//  Created by Edgar Nunez on 1/8/14.
//  Copyright (c) 2014 Edgar Nunez. All rights reserved.
//

#import "AppDelegate.h"
#import <ShowKit/ShowKit.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(connectionStateChanged:)
     name:SHKConnectionStatusChangedNotification
     object:nil];
    
    [ShowKit login: @"238.edgar.a.nunezgmail.com" password: @"123456"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

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
        //this is where you would display anything inside the call
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
