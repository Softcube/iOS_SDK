//
//  ViewController.h
//  ShopSample
//
//  Created by Kristi on 03.01.16.
//  Copyright © 2016 SoftCube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *emailTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) IBOutlet UIButton  *signButton;
@property (nonatomic, strong) IBOutlet UIButton  *fbButton;
@property (nonatomic, strong) IBOutlet UIButton  *guestButton;

-(IBAction)facebookAciton;
-(IBAction)loginAciton;
-(IBAction)guestAciton;


@end

