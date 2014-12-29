//
//  SignUpViewController.m
//  ChiShenMe
//
//  Created by Nate on 29/12/2014.
//  Copyright (c) 2014 Nathan CHEN. All rights reserved.
//

#import "SignUpViewController.h"

#define LOGIN_PAGE_SEGUE_IDENTIFIER @"login"

#define NETWORK_CONNECTION_FAIL_ALERTVIEW_MESSAGE @"Please check your network connection"
#define NETWORK_CONNECTION_FAIL_ALERTVIEW_TITILE @"Timeout"
#define NETWORK_CONNECTION_FAIL_ALTERVIEW_CANCELBUTTON @"OK"

#define SIGNUP_FAILED_DUPLICATE_USER_ALERTVIEW_MAEEAGE @"This email address has been signed up"
#define SIGNUP_FAILED_WRONG_EMAIL_FORMAT_ALERTVIEW_MAEEAGE @"Wrong email address format"
#define SIGNUP_FAILED_WRONG_PASSWORD_FORMAT_ALERTVIEW_MAEEAGE @"Wrong password format"
#define SIGNUP_FAILED_ALERTVIEW_TITILE @"Sign up Failed"
#define SIGNUP_FAILED_ALERTVIEW_CANCELBUTTON @"OK"

#define SIGNUP_FAILED_NETWORK_FAIL_ALERTVIEW_MESSAGE @"Timeout"
#define SIGNUP_FAILED_NETWORK_FAIL_ALERTVIEW_TITLE @""
#define SIGNUP_FAILED_NETWORK_FAIL_ALTERVIEW_CANCELBUTTON @"OK"

#define SIGNUP_SUCCESSFULLY_SEGUE_IDENTIFIER @"signupSuccessfully"

@interface SignUpViewController () <UITextFieldDelegate>

- (void)showSignupFailedAlertWithTitle: (NSString *)title message: (NSString *)message cancelButtonTitle: (NSString *)cancelButtonTitle;

@end

@implementation SignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _emailTextField.delegate = self;
    _passwordTextField.delegate = self;
}

- (IBAction)signup:(id)sender
{
    // block any interaction
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    // get inputs
    NSString *email = _emailTextField.text;
    NSString *password = _passwordTextField.text;
    
    // check if _emailTextField is empty
    if ([Strings isEmptyString:email])
    {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [_emailTextField becomeFirstResponder];
        return;
    }
    
    // check if _passwordTextField is empty
    if ([Strings isEmptyString:password])
    {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [_passwordTextField becomeFirstResponder];
        return;
    }
    
    // check network connection
    /* start processing request */
    
    // check network connection
    if (! [Networks isNetworkExist])
    {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NETWORK_CONNECTION_FAIL_ALERTVIEW_TITILE message:NETWORK_CONNECTION_FAIL_ALERTVIEW_MESSAGE delegate:self cancelButtonTitle:NETWORK_CONNECTION_FAIL_ALTERVIEW_CANCELBUTTON otherButtonTitles: nil];
        [alertView show];
        NSLog(@"Network connection failed");
        return;
    }
    else
    {
        // form proper url
        NSString *checksum = [Encryption md5:[email stringByAppendingString:password]];
        
        // send url request
        NSURL *url = [ChishenmeFetcher URLForCreateUserWith:email password:password confirmpassword:password checksum:checksum];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            
            if (data.length > 0 && connectionError == nil)
            {
                NSDictionary *signupResponseJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                NSString *code = [NSString stringWithFormat:@"%@", [signupResponseJson objectForKey:@"code"]];
                
                NSLog(@"Response code: %@", code);
                
                if ([code isEqualToString:@"0"])
                {
                    NSLog(@"Sign up successfully");
                    [self performSegueWithIdentifier:SIGNUP_SUCCESSFULLY_SEGUE_IDENTIFIER sender:nil];
                }
                else if ([code isEqualToString:@"2"])
                {
                    NSLog(@"Signup failed");
                    
                    [self showSignupFailedAlertWithTitle:SIGNUP_FAILED_ALERTVIEW_TITILE message:SIGNUP_FAILED_WRONG_EMAIL_FORMAT_ALERTVIEW_MAEEAGE cancelButtonTitle:SIGNUP_FAILED_ALERTVIEW_CANCELBUTTON];
                    return;
                }
                else if ([code isEqualToString:@"3"])
                {
                    NSLog(@"Signup failed");
                    
                    [self showSignupFailedAlertWithTitle:SIGNUP_FAILED_ALERTVIEW_TITILE message:SIGNUP_FAILED_WRONG_PASSWORD_FORMAT_ALERTVIEW_MAEEAGE cancelButtonTitle:SIGNUP_FAILED_ALERTVIEW_CANCELBUTTON];
                    return;
                }
                else if ([code isEqualToString:@"4"])
                {
                    NSLog(@"Signup failed");
                    
                    [self showSignupFailedAlertWithTitle:SIGNUP_FAILED_ALERTVIEW_TITILE message:SIGNUP_FAILED_DUPLICATE_USER_ALERTVIEW_MAEEAGE cancelButtonTitle:SIGNUP_FAILED_ALERTVIEW_CANCELBUTTON];
                    return;
                }
                else
                {
                    NSLog(@"Signup failed");
                    
                    [self showSignupFailedAlertWithTitle:SIGNUP_FAILED_ALERTVIEW_TITILE message:@"" cancelButtonTitle:SIGNUP_FAILED_ALERTVIEW_CANCELBUTTON];
                    return;
                }
            }
            else
            {
                // something went wrong, connection error most likely
                NSLog(@"Something went wrong");
                
                [self showSignupFailedAlertWithTitle:SIGNUP_FAILED_NETWORK_FAIL_ALERTVIEW_TITLE
                                             message:SIGNUP_FAILED_NETWORK_FAIL_ALERTVIEW_MESSAGE
                                   cancelButtonTitle:SIGNUP_FAILED_NETWORK_FAIL_ALTERVIEW_CANCELBUTTON];
                return;
            }
        }];
    }
}

// Already have an account?
- (IBAction)gotoLoginPage:(id)sender
{
    [self performSegueWithIdentifier:LOGIN_PAGE_SEGUE_IDENTIFIER sender:self];
}

// click anywhere on the screen to hide the keyboard
- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([_emailTextField isFirstResponder] && ([touch view] != _emailTextField))
    {
        [_emailTextField resignFirstResponder];
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
    
    if (textField == _emailTextField)
    {
        [_passwordTextField becomeFirstResponder];
    }
    return YES;
}

- (void)showSignupFailedAlertWithTitle: (NSString *)title
                               message: (NSString *)message
                     cancelButtonTitle: (NSString *)cancelButtonTitle
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message  delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles: nil];
    [alertView show];
    
    [_emailTextField becomeFirstResponder];
    _passwordTextField.text = @"";
}


@end
