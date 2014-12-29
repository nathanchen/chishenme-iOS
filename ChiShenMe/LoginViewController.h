//
//  LoginViewController.h
//  ChiShenMe
//
//  Created by Nate on 24/12/2014.
//  Copyright (c) 2014 Nathan CHEN. All rights reserved.
//

#import "ViewController.h"
#import "ChishenmeFetcher.h"
#import "Encryption.h"
#import "Strings.h"
#import "Networks.h"
#import "Notifications.h"

@interface LoginViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

- (IBAction)login;
- (IBAction)gotoSignupPage;


@end
