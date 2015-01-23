//
//  ShoppingListViewController.h
//  ChiShenMe
//
//  Created by Nate on 22/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingListTableViewController.h"
#import "ShoppingListItem.h"

@interface ShoppingListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *debugButton;
@property (weak, nonatomic) IBOutlet UIImageView *shoppinglistHeaderImageView;

- (IBAction)barButtonPressed:(id)sender;
- (IBAction)showItems:(id)sender;
@end
