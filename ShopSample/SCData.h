//
//  SCData.h
//  ShopSample
//
//  Created by Administrator on 05.03.16.
//  Copyright © 2016 SoftCube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCData : NSObject
    @property (nonatomic, strong) NSString *userName;
    @property (nonatomic, strong) NSString *userEmail;
    @property (nonatomic, strong) NSString *siteId;


-(NSDictionary *)createPurchasedItemsData:(NSString *) orderNumber GUID:(NSString *)GUID purchasedItems:(NSArray *) purchasedItems;
-(NSDictionary *)createStatusCartData:(NSArray *)items;
+(NSDictionary *)createCardItem:(NSString *) productId  price:(float)price priceCurrencyCode:(NSString *)priceCurrencyCode quantity:(int)quantity discount:(float)discount unitPrice:(float)unitPrice tags:(NSArray *)tags;
-(NSDictionary *)createProductPage:(NSString *)productKey isInStock:(BOOL)isInStock price:(float)price tags:(NSArray *)tags;

-(NSDictionary *)createProductPageData:(NSString *)productKey isInStock:(BOOL)isInStock price:(float)price tags:(NSArray *)tags;
-(NSDictionary *)createPageViewData:(NSString*)pageUrl;
-(NSDictionary *)getDevice;
-(NSDictionary *)getScreenDim;
-(NSDictionary *)getGeneralInfo:(NSString*)eventName;




+ (SCData *)sharedData;
@end
