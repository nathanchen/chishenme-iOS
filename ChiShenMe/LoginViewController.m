//
//  LoginViewController.m
//  ChiShenMe
//
//  Created by Nate on 24/12/2014.
//  Copyright (c) 2014 Nathan CHEN. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController () <UITextFieldDelegate>

@end

@implementation LoginViewController

- (IBAction)login
{
    NSString *name = _nameTextField.text;
    NSString *password = _passwordTextField.text;
    
    NSURL *url = [ChishenmeFetcher URLForLoginWith:name And:password];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data.length > 0 && connectionError == nil) {
            NSDictionary *loginResponseJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"%@", [[loginResponseJson objectForKey:@"code"] stringValue]);
        }
    }];
}

// click anywhere on the screen to hide the keyboard
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([_nameTextField isFirstResponder] && ([touch view] != _nameTextField)) {
        [_nameTextField resignFirstResponder];
    } else if ([_passwordTextField isFirstResponder] && ([touch view] != _passwordTextField)) {
        [_passwordTextField resignFirstResponder];
    }
    [super touchesEnded:touches withEvent:event];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (textField == _nameTextField) {
        [_passwordTextField becomeFirstResponder];
    } else {
        [self login];
    }
    
    return YES;
}

- (void)viewDidLoad
{
    _nameTextField.delegate = self;
    _passwordTextField.delegate = self;
}

@end
