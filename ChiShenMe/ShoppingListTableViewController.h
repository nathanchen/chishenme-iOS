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

- (IBAction)barButtonPressed:(id)sender;

@end
