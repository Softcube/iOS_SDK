//
//  SCData.m
//  ShopSample
//
//  Created by Administrator on 05.03.16.
//  Copyright © 2016 SoftCube. All rights reserved.
//

#import "SCData.h"
#import <UIKit/UIKit.h>

@implementation SCData

+ (SCData *)sharedData {
    static SCData *__shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __shared = [[SCData alloc] init];
        [__shared readSiteId];
    });
    return __shared;
}


-(NSDictionary *)createPurchasedItemsData:(NSString *) orderNumber GUID:(NSString *)GUID purchasedItems:(NSArray *) purchasedItems{
    NSMutableDictionary * generalInfo = [[NSMutableDictionary alloc] initWithDictionary:[self getGeneralInfo:@"PurchasedItems"]];
        
    return @{@"GeneralInfo":generalInfo,
             @"OrderNumber":orderNumber,
             @"PurchasedItems":purchasedItems ? purchasedItems:@[],
             @"GUID":GUID};
}

-(NSDictionary *)createStatusCartData:(NSArray *)items{
    NSMutableDictionary * generalInfo = [[NSMutableDictionary alloc] initWithDictionary:[self getGeneralInfo:@"StatusCart"]];

    NSString * GUID = [[NSUUID UUID] UUIDString];
    
    return @{@"GeneralInfo":generalInfo,
             @"StatusCart":items?items:@[],
             @"GUID":GUID};
}

+(NSDictionary *)createCardItem:(NSString *) productId  price:(float)price priceCurrencyCode:(NSString *)priceCurrencyCode quantity:(int)quantity discount:(float)discount unitPrice:(float)unitPrice tags:(NSArray *)tags{
    
    
    return @{@"product_id":productId,
             @"price":[NSNumber numberWithFloat:price],
             @"quantity":[NSNumber numberWithInt:quantity],
             @"price_currency_code":priceCurrencyCode,
             @"discount":discount != 0 ? [NSNumber numberWithInt:discount] : @"",
             @"unit_price":[NSNumber numberWithFloat:unitPrice],
             @"tag_something":tags?tags:@[]};
}


-(NSDictionary *)createProductPage:(NSString *)productKey isInStock:(BOOL)isInStock price:(float)price tags:(NSArray *)tags{
    return  @{@"productKey":productKey,
                                   @"isInStock":[NSNumber numberWithBool:isInStock],
                                   @"price":[NSNumber numberWithFloat:price],
                                   @"tag_something":tags?tags:@[]};
    
}

-(NSDictionary *)createProductPageData:(NSString *)productKey isInStock:(BOOL)isInStock price:(float)price tags:(NSArray *)tags{
    NSMutableDictionary * generalInfo = [[NSMutableDictionary alloc] initWithDictionary:[self getGeneralInfo:@"ProductPage"]];
    
    
    return @{@"GeneralInfo":generalInfo,
             @"ProductPage":[self createProductPage:productKey isInStock:isInStock price:price tags:tags]};
}

-(NSDictionary *)createPageViewData:(NSString*)pageUrl{
    NSMutableDictionary * generalInfo = [[NSMutableDictionary alloc] initWithDictionary:[self getGeneralInfo:@"PageView"]];
    generalInfo[@"s_location"] = pageUrl;
    return @{@"GeneralInfo":generalInfo};
}

-(NSDictionary *)getDevice{
    return @{@"type":@"mobile",
             @"id":[[UIDevice currentDevice] model],
             @"os":[[UIDevice currentDevice] systemName],
             @"version":[[UIDevice currentDevice] systemVersion],
             @"vendor":@"Apple"};
}

-(NSDictionary *)getScreenDim{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGFloat screenWidth = screenRect.size.width * scale;
    CGFloat screenHeight = screenRect.size.height * scale;
    return @{@"h":[NSNumber numberWithFloat:screenHeight],
             @"w":[NSNumber numberWithFloat:screenWidth]};
}

-(NSDictionary *)getGeneralInfo:(NSString*)eventName{
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE MMM d yyyy HH:mm:ss z"];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    NSString * dateStr = [dateFormatter stringFromDate:[[NSDate alloc] init]];
    
    

    
 return @{
                    @"device":[self getDevice],
                    @"eventName":eventName,
                    @"datetime":dateStr,
                    @"screendim":[self getScreenDim],
                    @"browser":@{},
                    @"siteId":self.siteId ? self.siteId:@"",
                    @"cookies":@{},
                    @"s_location":@"",
                    @"referrer":@"",
                    @"user_name":self.userName ? self.userName : @"",
                    @"user_email":self.userEmail ? self.userEmail : @"",
                    @"user_device_id":self.userDeviceId ? self.userDeviceId : @""
                    };
}

-(void)readSiteId{
    NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
    _siteId =  [infoDict objectForKey:@"SCSiteID"];
    if(!self.siteId){
        NSLog(@"Error: Site ID not found");
    }
}

@end
