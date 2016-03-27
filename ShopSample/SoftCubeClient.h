//
//  SoftCubeClient.h
//  ShopSample
//
//  Created by Administrator on 28.02.16.
//  Copyright © 2016 SoftCube. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCData.h"

@interface SoftCubeClient : NSObject

@property (nonatomic, weak) SCData *data;
@property (nonatomic, weak) NSString *userName;
@property (nonatomic, weak) NSString *userEmail;
@property (nonatomic, weak) NSString *userDeviceId;

+ (SoftCubeClient *)sharedClient;
- (NSDictionary *) pageView:(NSString *) pageUrl;
- (NSDictionary *) productPage:(NSString *)productKey isInStock:(BOOL)isInStock price:(float)price tags:(NSArray *)tags;
- (NSDictionary *) statusCart:(NSArray *) cartItems;
- (NSDictionary *) purchasedItemsWithOrderNumber:(NSString *) orderNumber GUID:(NSString *) GUID;
- (NSDictionary *) purchasedItemsWithOrderNumber:(NSString *) orderNumber GUID:(NSString *) GUID purchasedItems:(NSArray *) purchasedItems;

@end
