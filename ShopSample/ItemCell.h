//
//  ItemCell.h
//  ShopSample
//
//  Created by Kristi on 03.01.16.
//  Copyright © 2016 SoftCube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *titleItemText;

@property (nonatomic, strong) IBOutlet UILabel *priceText;
@property (nonatomic, strong) IBOutlet UILabel *tagsText;
@property (nonatomic, strong) IBOutlet UIImageView *titleItemImage;





@end
