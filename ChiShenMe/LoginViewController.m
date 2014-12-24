//
//  LoginViewController.m
//  ChiShenMe
//
//  Created by Nate on 24/12/2014.
//  Copyright (c) 2014 Nathan CHEN. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

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

@end
