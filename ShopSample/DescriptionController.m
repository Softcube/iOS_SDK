//
//  DescriptionController.m
//  ShopSample
//
//  Created by Kristi on 03.01.16.
//  Copyright © 2016 SoftCube. All rights reserved.
//

#import "DescriptionController.h"
#import "SoftCubeClient.h"
#import "AppDelegate.h"
@interface DescriptionController ()

@end

@implementation DescriptionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[SoftCubeClient sharedClient] pageView:@"ItemDetailsPage"];
    
    if(self.item){
        
        self.titleText.text = [self.item objectForKey:@"content"];
        self.priceText.text = [NSString stringWithFormat:@"%.2f $", [[self.item objectForKey:@"price"] floatValue]];
        self.descriptionText.text = [self.item objectForKey:@"details"];
        
        [[SoftCubeClient sharedClient] productPage:[self.item objectForKey:@"id"]
                                         isInStock:YES
                                             price:[[self.item objectForKey:@"price"] floatValue]
                                              tags:@[]];

    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)addToCart{
    int quantity = [[self.item objectForKey:@"quantity"] intValue];
    quantity++;
    [self.item setValue:[NSNumber numberWithInt:quantity] forKey:@"quantity"];
    [APP.cart setObject:self.item forKey:[self.item objectForKey:@"id"]];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
