//
//  CartCell.h
//  ShopSample
//
//  Created by Kristi on 03.01.16.
//  Copyright © 2016 SoftCube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *titleCartText;
@property (nonatomic, strong) IBOutlet UILabel *tagsText;
@property (nonatomic, strong) IBOutlet UILabel *qantityText;
@property (nonatomic, strong) IBOutlet UILabel *priceText;
@property (nonatomic, strong) IBOutlet UIImageView *titleCartImage;

@end
