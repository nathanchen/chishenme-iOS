//
//  ShoppingListViewController.m
//  ChiShenMe
//
//  Created by Nate on 22/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "ShoppingListViewController.h"

@interface ShoppingListViewController ()

@end

@implementation ShoppingListViewController
{
    ShoppingListTableViewController *shoppinglistTableViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_shoppinglistHeaderImageView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"shoppinglist"]]];
}

- (void)barButtonPressed:(id)sender
{
    
    if ([_barButtonItem.title isEqualToString:@"+"])
    {
        // perform +
        [shoppinglistTableViewController didFinishAddingItem];
        _barButtonItem.title = @"Done";
    }
    else
    {
        // perform save
        [shoppinglistTableViewController didFinishEditingItem];
        _barButtonItem.title = @"+";
    }
}

- (IBAction)showItems:(id)sender
{
    [shoppinglistTableViewController showItems];
}

@end
