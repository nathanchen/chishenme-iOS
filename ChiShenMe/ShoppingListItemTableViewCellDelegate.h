//
//  ShoppingListItemTableViewCellDelegate.h
//  ChiShenMe
//
//  Created by Nate on 30/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShoppingListItem.h"

@class ShoppingListItemTableViewCell;

@protocol ShoppingListItemTableViewCellDelegate <NSObject>

- (void)shoppinglistItemDeleted:(ShoppingListItem *)shoppinglistItem;

- (void)shoppinglistItemCompleted:(ShoppingListItem *)shoppinglistItem;

- (void)cellDidBeginEditing:(ShoppingListItemTableViewCell *)editingCell;

- (void)cellDidEndEditing:(ShoppingListItemTableViewCell *)editingCell;

@end
