//
//  LoginViewController.m
//  ChiShenMe
//
//  Created by Nate on 24/12/2014.
//  Copyright (c) 2014 Nathan CHEN. All rights reserved.
//

#import "LoginViewController.h"
#import "Utils/Networks.h"
#import "Utils/Notifications.h"

#define NETWORK_CONNECTION_FAIL_ALERTVIEW_MESSAGE @"Please check your network connection"
#define NETWORK_CONNECTION_FAIL_ALERTVIEW_TITILE @"Timeout"
#define NETWORK_CONNECTION_FAIL_ALTERVIEW_CANCELBUTTON @"OK"

#define LOGIN_FAILED_WRONG_PWD_ALERTVIEW_MESSAGE @"Incorrect username and password"
#define LOGIN_FAILED_WRONG_PWD_ALERTVIEW_TITLE @"Login Failed"
#define LOGIN_FAILED_WRONG_PWD_ALERTVIEW_CANCELBUTTON @"OK"

#define LOGIN_FAILED_NETWORK_FAIL_ALERTVIEW_MESSAGE @"Timeout"
#define LOGIN_FAILED_NETWORK_FAIL_ALERTVIEW_TITLE @""
#define LOGIN_FAILED_NETWORK_FAIL_ALTERVIEW_CANCELBUTTON @"OK"



@interface LoginViewController () <UITextFieldDelegate>

- (void)saveUserNameAndPwd: (NSString *)username
                    andPwd: (NSString *)pwd;

- (void)showLoginFailedAlertWithTitle: (NSString *)title message: (NSString *)message cancelButtonTitle: (NSString *)cancelButtonTitle;

@end

@implementation LoginViewController

- (IBAction)login
{
    // block any interaction
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    // get inputs
    NSString *name = _nameTextField.text;
    NSString *password = _passwordTextField.text;
//    NSString *name = @"John@g";
//    NSString *password = @"123456";
    
    // check if _nameTextField is empty
    if ([Strings isEmptyString:name])
    {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [_nameTextField becomeFirstResponder];
        return;
    }
    // check if _passwordTextField is empty
    else if ([Strings isEmptyString:password])
    {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [_passwordTextField becomeFirstResponder];
        return;
    }
    
    /* start processing request */
    
    // check network connection
    if (! [Networks isNetworkExist])
    {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NETWORK_CONNECTION_FAIL_ALERTVIEW_TITILE message:NETWORK_CONNECTION_FAIL_ALERTVIEW_MESSAGE delegate:self cancelButtonTitle:NETWORK_CONNECTION_FAIL_ALTERVIEW_CANCELBUTTON otherButtonTitles: nil];
        [alertView show];
        NSLog(@"Network connection failed");
    }
    else
    {
        // form proper url
        NSString *encryptedPassword = [Encryption md5:password];
        NSString *checksum = [Encryption md5:[name stringByAppendingString:encryptedPassword]];
        
        // send url request
        NSURL *url = [ChishenmeFetcher URLForLoginWith:name And:encryptedPassword And:checksum];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            
            if (data.length > 0 && connectionError == nil)
            {
                NSDictionary *loginResponseJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                
                NSString *code = [NSString stringWithFormat:@"%@", [loginResponseJson objectForKey:@"code"]];
                
                NSLog(@"Response code: %@" ,code);
                
                if ([code isEqualToString:@"0"])
                {
                    // login successfully
                    NSLog(@"Login successfully")
                    [self performSegueWithIdentifier:@"success" sender:nil];
                }
                else
                {
                    // login failed
                    NSLog(@"Login failed");
                    
                    [self showLoginFailedAlertWithTitle:LOGIN_FAILED_WRONG_PWD_ALERTVIEW_TITLE message:LOGIN_FAILED_WRONG_PWD_ALERTVIEW_MESSAGE cancelButtonTitle:LOGIN_FAILED_WRONG_PWD_ALERTVIEW_CANCELBUTTON];
                    return;
                }
            }
            else
            {
                // something went wrong, connection error most likely
                NSLog(@"Something went wrong");

                [self showLoginFailedAlertWithTitle:LOGIN_FAILED_NETWORK_FAIL_ALERTVIEW_TITLE message:LOGIN_FAILED_NETWORK_FAIL_ALERTVIEW_MESSAGE cancelButtonTitle:LOGIN_FAILED_NETWORK_FAIL_ALTERVIEW_CANCELBUTTON];
                return;
            }
        }];
    }
}

// click anywhere on the screen to hide the keyboard
- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([_nameTextField isFirstResponder] && ([touch view] != _nameTextField))
    {
        [_nameTextField resignFirstResponder];
    }
    else if ([_passwordTextField isFirstResponder] && ([touch view] != _passwordTextField))
    {
        [_passwordTextField resignFirstResponder];
    }
    [super touchesEnded:touches withEvent:event];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (textField == _nameTextField)
    {
        [_passwordTextField becomeFirstResponder];
    }
    
    if (_passwordTextField.isFirstResponder)
    {
        NSLog(@"123");
    }
    
    return YES;
}

- (void)viewDidLoad
{
    _nameTextField.delegate = self;
    _passwordTextField.delegate = self;
}

- (void)saveUserNameAndPwd: (NSString *)username
                    andPwd: (NSString *)pwd
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"username"];
    [settings removeObjectForKey:@"password"];
    
    [settings setObject:username forKey:@"username"];
    
    pwd = [Encryption md5:pwd];
    
    [settings setObject:pwd forKey:@"password"];
    [settings synchronize];
}

- (void)showLoginFailedAlertWithTitle: (NSString *)title message: (NSString *)message cancelButtonTitle: (NSString *)cancelButtonTitle
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles: nil];
    [alertView show];
    
    [_nameTextField becomeFirstResponder];
    _passwordTextField.text = @"";
}


@end
