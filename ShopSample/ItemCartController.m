//
//  ItemListController.m
//  ShopSample
//
//  Created by Kristi on 03.01.16.
//  Copyright © 2016 SoftCube. All rights reserved.
//

#import "ItemCartController.h"
#import "SoftCubeClient.h"
#import "AppDelegate.h"
#import "CartCell.h"

@interface ItemCartController ()

@end

@implementation ItemCartController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[SoftCubeClient sharedClient] pageView:@"ShoppingCartPage"];
    
    
    
 
    [self doCart];
    
 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return APP.cart.allKeys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCartCell" forIndexPath:indexPath];
    
    NSDictionary * item = APP.cart[APP.cart.allKeys[indexPath.row]];
    
    cell.titleCartText.text = item[@"content"];
    cell.priceText.text = [NSString stringWithFormat:@"%.2f $", [item[@"price"] floatValue]];
    cell.qantityText.text = [NSString stringWithFormat:@"%i", [item[@"quantity"] intValue]];
    
    return cell;
}


-(IBAction)checkoutAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
    int r = arc4random_uniform(2000);
    NSString * orderNumber = [NSString stringWithFormat:@"%i", r];
    [[SoftCubeClient sharedClient] purchasedItemsWithOrderNumber:orderNumber GUID:self.GUID];
    [APP.cart removeAllObjects];
}


-(void)doCart{
    int total = 0;
    float price = 0.;
    NSMutableArray * cartItems = [[NSMutableArray alloc] init];
    for(NSNumber * key in APP.cart.allKeys){
        NSDictionary * item = APP.cart[key];
        int quantity = [item[@"quantity"] intValue];
        float itemPrice = [item[@"price"] floatValue];
        total+=quantity;
        price+= (quantity * itemPrice);
        NSDictionary * cartItem = [SCData createCardItem:item[@"id"]
                                                   price:([item[@"price"] floatValue] *[item[@"quantity"] intValue])
                                       priceCurrencyCode:@"USD"
                                                quantity:[item[@"quantity"] intValue]
                                                discount:0
                                               unitPrice:[item[@"price"] floatValue]
                                                    tags:@[]];
        [cartItems addObject:cartItem];
    }
    self.totalPriceContentText.text = [NSString stringWithFormat:@"%0.2f $", price];
    self.totalContentText.text = [NSString stringWithFormat:@"%i", total];
   NSDictionary * cartData = [[SoftCubeClient sharedClient] statusCart:cartItems];
    self.GUID = [cartData objectForKey:@"GUID"];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end