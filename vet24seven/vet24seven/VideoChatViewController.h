//
//  VideoChatViewController.h
//  vet24seven-ipad
//
//  Created by Edgar Nunez on 1/13/14.
//  Copyright (c) 2014 Edgar Nunez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShowKit/ShowKit.h>

@interface VideoChatViewController : UIViewController

@property (readwrite, strong, nonatomic) UIView *mainVideoUIView;
@property (readwrite, strong, nonatomic) UIView *prevVideoUIView;

@end
