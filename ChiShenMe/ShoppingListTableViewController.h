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

#define TAG_CHECKSIGN_BUTTON 2000
#define TAG_SUBJECT_LABEL 1000
#define TAG_QUANTITY_LABEL 1001

@interface ShoppingListTableViewController : UITableViewController <ItemDetailViewControllerDelegate>

@end
