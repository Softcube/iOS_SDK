//
//  AppDelegate.h
//  ShopSample
//
//  Created by Kristi on 03.01.16.
//  Copyright © 2016 SoftCube. All rights reserved.
//

#import <UIKit/UIKit.h>
#define APP             ((AppDelegate*)[[UIApplication sharedApplication] delegate])

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray * items;
@property (strong, nonatomic) NSMutableDictionary * cart;

@end

