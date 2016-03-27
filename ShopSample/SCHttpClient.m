//
//  SCHttpClient.m
//  ShopSample
//
//  Created by Administrator on 28.02.16.
//  Copyright © 2016 SoftCube. All rights reserved.
//

#import "SCHttpClient.h"

#define SOFTCUBE_URL  @"http://tracker.softcube.com/"
#define HOST @"tracker.softcube.com"
#define CONTENT_TYPE @"application/x-www-form-urlencoded"
#define TAG @"SCHttpClient"

@implementation SCHttpClient


+ (SCHttpClient *)client {
    static SCHttpClient *__sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedClient = [[SCHttpClient alloc] init];
    });
    return __sharedClient;
}


- (void)postData:(NSDictionary *)data
        siteId:(NSString *)siteId
               debug:(BOOL)debug{
    
  
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions error:nil];
    NSString *jsonString = @"";
 
    if (!jsonData) {
        jsonString = @"{}";
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }

    if(debug){
        NSLog(@"%@ SITE_ID: %@", TAG, siteId);
        NSLog(@"%@ JSON: %@", TAG, jsonString);
    }
    
    
    NSString * postDataString = [NSString stringWithFormat:@"id=%@&site=%@", jsonString, siteId?siteId:@""];

    NSURL *URL = [NSURL URLWithString:SOFTCUBE_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:15.0];
    
    [request setValue:CONTENT_TYPE forHTTPHeaderField:@"Content-Type"];

    [request setHTTPMethod:@"POST"];
    NSError *error;
   
    
    if(debug){
        if(error){
            NSLog(@"%@ Error: %@", TAG, error);
        }
    }
    


    NSData *postData = [postDataString dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:postData];

    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data,
                                    NSURLResponse *response,
                                    NSError *error) {
                    if(debug){
                        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
                            NSLog(@"%@ Code: %ld", TAG, statusCode);
                        }
                        if(error){
                                NSLog(@"%@ Error: %@", TAG, error);
                        }
                    }
                    
                }] resume];
    

}


@end
