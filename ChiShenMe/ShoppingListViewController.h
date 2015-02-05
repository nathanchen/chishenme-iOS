//
//  ShoppingListViewController.h
//  ChiShenMe
//
//  Created by Nate on 30/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ShoppingListItem.h"
#import "ShoppingListItemTableViewCell.h"
#import "ShoppingListTableViewDragAddNew.h"
#import "ShoppingListTableViewPinchToAdd.h"

@interface ShoppingListViewController : UIViewController <ShoppingListItemTableViewDataSource, ShoppingListItemTableViewCellDelegate>

@property (strong, nonatomic) IBOutlet ShoppingListTableView *tableView;

@end
