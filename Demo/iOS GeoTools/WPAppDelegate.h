//
//  WPAppDelegate.h
//  iOS GeoTools
//
//  Created by Will Pearse on 8/05/13.
//  Copyright (c) 2013 MobileNet Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WPViewController;

@interface WPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) WPViewController *viewController;

@end
