//
//  SoftCubeClient.m
//  ShopSample
//
//  Created by Administrator on 28.02.16.
//  Copyright © 2016 SoftCube. All rights reserved.
//

#import "SoftCubeClient.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <UIKit/UIKit.h>
#import "SCHttpClient.h"

#define SC_DEBUG YES

@implementation SoftCubeClient



+ (SoftCubeClient *)sharedClient {
    static SoftCubeClient *__shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __shared = [[SoftCubeClient alloc] init];
    });
    return __shared;
}

-(void)setUserEmail:(NSString *)userEmail{
    [SCData sharedData].userEmail = userEmail;
}

-(void)setUserName:(NSString *)userName{
    [SCData sharedData].userName = userName;
}

-(NSString *)getUserEmail{
  return  [SCData sharedData].userEmail;
}

-(NSString *)getUserName{
    return  [SCData sharedData].userName;
}





- (NSDictionary *) pageView:(NSString *) pageUrl{
    NSDictionary * data = [[SCData sharedData] createPageViewData:pageUrl];
    if ([self checkNetwork]) {
        [[SCHttpClient client] postData:data siteId:[SCData sharedData].siteId debug:SC_DEBUG];
    }
    return data;
}
- (NSDictionary *)  productPage:(NSString *)productKey isInStock:(BOOL)isInStock price:(float)price tags:(NSArray *)tags{
    NSDictionary * data = [[SCData sharedData] createProductPageData:productKey isInStock:isInStock price:price tags:tags];
    if ([self checkNetwork]) {
        [[SCHttpClient client] postData:data siteId:[SCData sharedData].siteId debug:SC_DEBUG];
    }
    return data;
}

- (NSDictionary *)  statusCart:(NSArray *) cartItems{
    NSDictionary * data = [[SCData sharedData] createStatusCartData:cartItems];
    if ([self checkNetwork]) {
        [[SCHttpClient client] postData:data siteId:[SCData sharedData].siteId debug:SC_DEBUG];
    }
    return data;
}

- (NSDictionary *)  purchasedItemsWithOrderNumber:(NSString *) orderNumber GUID:(NSString *) GUID{
    NSDictionary * data = [[SCData sharedData] createPurchasedItemsData:orderNumber GUID:GUID purchasedItems:nil];
    if ([self checkNetwork]) {
        [[SCHttpClient client] postData:data siteId:[SCData sharedData].siteId debug:SC_DEBUG];
    }
    return data;
}

- (NSDictionary *)  purchasedItemsWithOrderNumber:(NSString *) orderNumber GUID:(NSString *) GUID purchasedItems:(NSArray *) purchasedItems{
    NSDictionary * data = [[SCData sharedData] createPurchasedItemsData:orderNumber GUID:GUID purchasedItems:purchasedItems];
    if ([self checkNetwork]) {
        [[SCHttpClient client] postData:data siteId:[SCData sharedData].siteId debug:SC_DEBUG];
    }
    return data;
}



- (BOOL) checkNetwork {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    BOOL connected;
    BOOL isConnected;
    const char *host = "www.apple.com";
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host);
    SCNetworkReachabilityFlags flags;
    connected = SCNetworkReachabilityGetFlags(reachability, &flags);
    isConnected = NO;
    isConnected = connected && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
    CFRelease(reachability);
    return isConnected;
}

@end
