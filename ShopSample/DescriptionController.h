//
//  DescriptionController.h
//  ShopSample
//
//  Created by Kristi on 03.01.16.
//  Copyright © 2016 SoftCube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DescriptionController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *titleText;
@property (nonatomic, strong) IBOutlet UILabel *descriptionText;
@property (nonatomic, strong) IBOutlet UILabel *priceText;
@property (nonatomic, strong) IBOutlet UIButton *addCartBtton;
@property (nonatomic, strong) IBOutlet UIImageView *titleImage;

@property (nonatomic, weak) NSDictionary *item;



@end
