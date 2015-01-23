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
#import "ShoppingListViewController.h"

@interface ShoppingListTableViewController : UITableViewController

- (void)didFinishAddingItem;

- (void)didFinishEditingItem;



// For debugging use only
- (void)showItems;

@end
