//
//  SCHttpClient.h
//  ShopSample
//
//  Created by Administrator on 28.02.16.
//  Copyright © 2016 SoftCube. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^CompletionBlock)(NSDictionary *response, NSError *error);

@interface SCHttpClient : NSObject
+ (SCHttpClient *)client;

- (void)postData:(NSDictionary *)data
          siteId:(NSString *)siteId
           debug:(BOOL)debug;
@end
