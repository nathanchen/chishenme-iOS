//
//  SignUpViewController.h
//  ChiShenMe
//
//  Created by Nate on 29/12/2014.
//  Copyright (c) 2014 Nathan CHEN. All rights reserved.
//

#import "ViewController.h"
#import "Strings.h"
#import "Networks.h"
#import "Encryption.h"
#import "ChishenmeFetcher.h"
#import "Notifications.h"

@interface SignUpViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

- (IBAction)signup:(id)sender;
- (IBAction)gotoLoginPage:(id)sender;

@end
