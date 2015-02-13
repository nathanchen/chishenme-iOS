//
//  TBShoppingListItem+Extention.h
//  ChiShenMe
//
//  Created by Nate on 5/02/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "TBShoppingListItem.h"
#import "ShoppingListItem.h"
#import "AppDelegate.h"
#import "Strings.h"

@interface TBShoppingListItem (Extention)

+ (instancetype)initTBShoppingListItemWithDefault;

+ (instancetype)insertNewTBShoppingListItemWithShoppingListItem: (ShoppingListItem *)shoppinglistItem;

+ (instancetype)initTBShoppingListItem: (TBShoppingListItem *) tb_shoppinglistItem withShoppingListItem: (ShoppingListItem *)shoppinglistItem;

+ (instancetype)updateTBShoppingListItemWithShoppingListItem: (ShoppingListItem *)shoppinglistItem;

- (NSString *)description;

@end
