//
//  ShoppingListTableViewController.h
//  ChiShenMe
//
//  Created by Nate on 14/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"
#import "ShoppingListItem.h"

@interface ShoppingListTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *debugButton;

- (IBAction)barButtonPressed;

- (void)didFinishAddingItem;

- (void)didFinishEditingItem;



// For debugging use only
- (IBAction)debugShowItems;

@end
