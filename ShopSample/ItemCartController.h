//
//  ItemCartController.h
//  ShopSample
//
//  Created by Kristi on 03.01.16.
//  Copyright © 2016 SoftCube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCartController : UIViewController


@property (nonatomic, strong) IBOutlet UILabel *totalText;
@property (nonatomic, strong) IBOutlet UILabel *totalContentText;
@property (nonatomic, strong) IBOutlet UILabel *totalPriceText;
@property (nonatomic, strong) IBOutlet UILabel *totalPriceContentText;

@property (nonatomic, strong) NSString *GUID;
@property (nonatomic, strong) NSMutableArray * cartItems;








@end
