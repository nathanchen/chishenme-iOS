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

+ (instancetype)insertNewTBShoppingListItemWithShoppingListItem: (ShoppingListItem *)shoppinglistItem;

- (NSString *)description;

@end
