//
//  MNAppDelegate.m
//  MNCalendarViewExample
//
//  Created by Min Kim on 7/26/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import "MNAppDelegate.h"
#import "MNViewController.h"

@implementation MNAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  [[MNCalendarView appearance] setSeparatorColor:UIColor.blueColor];

  UITabBarController *controller = [[UITabBarController alloc] init];
  controller.viewControllers = @[
                                 [[MNViewController alloc] initWithCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] title:@"Gregorian"],
                                 [[MNViewController alloc] initWithCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSHebrewCalendar] title:@"Hebrew"],
                                 [[MNViewController alloc] initWithCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSIslamicCalendar] title:@"Islamic"],
                                 [[MNViewController alloc] initWithCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSIndianCalendar] title:@"Indian"],
                                 [[MNViewController alloc] initWithCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSPersianCalendar] title:@"Persian"]
                                 
                                 ];

  self.window.rootViewController = controller;

  [self.window makeKeyAndVisible];
  
  return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
