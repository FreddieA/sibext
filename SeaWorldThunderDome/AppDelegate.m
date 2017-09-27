//
//  AppDelegate.m
//  SeaWorldThunderDome
//
//  Created by mkirillov on 25/09/2017.
//  Copyright © 2017 freddie-ink. All rights reserved.
//

#import "AppDelegate.h"
#import "CageViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.tintColor = UIColor.whiteColor;
    [_window makeKeyAndVisible];
    _window.rootViewController = [CageViewController new];
    return YES;
}

@end
