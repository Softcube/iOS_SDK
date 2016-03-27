//
//  ViewController.m
//  ShopSample
//
//  Created by Kristi on 03.01.16.
//  Copyright © 2016 SoftCube. All rights reserved.
//

#import "LoginViewController.h"
#import "SoftCubeClient.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController () <UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[SoftCubeClient sharedClient] pageView:@"LoginPage"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)facebookAciton{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"email"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             
             if ([result.grantedPermissions containsObject:@"email"]) {
                 if ([FBSDKAccessToken currentAccessToken]) {
                     [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
                      startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                          if (!error) {
                              NSString * userName = [result objectForKey:@"name"];
                              if(userName)
                              [SoftCubeClient sharedClient].userName = userName;
                              NSString * email = [result objectForKey:@"email"];
                              if(email)
                                  [SoftCubeClient sharedClient].userEmail = email;
                              NSLog(@"fetched user:%@", result);
                          }
                          [self performSegueWithIdentifier:@"gotoItems" sender:self];
                      }];
                 }
             }
             

         
         }
     }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignFirstResponder];
    [self loginAciton];
    return YES;
}

-(IBAction)loginAciton{
    if(self.emailTextField.text.length == 0){
        [self showAlert:@"Email field is required"];
        return;
    }
    if(![self NSStringIsValidEmail:self.emailTextField.text]){
        [self showAlert:@"This email address is invalid"];
        return;
    }
    if(self.passwordTextField.text.length == 0){
        [self showAlert:@"Password field is required"];
        return;
    }
    if(self.passwordTextField.text.length < 4){
        [self showAlert:@"This password is too short"];
        return;
    }

    [SoftCubeClient sharedClient].userEmail = self.emailTextField.text;
    [self performSegueWithIdentifier:@"gotoItems" sender:self];

}
-(IBAction)guestAciton{
    [self performSegueWithIdentifier:@"gotoItems" sender:self];
}

-(void)showAlert:(NSString *)message{
    if (NSClassFromString(@"UIAlertController")) {
        //show alertcontroller
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message:message
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Ok"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           
                                       }];

        [alert addAction:cancelAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        //show alertview
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
  
}
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
@end
