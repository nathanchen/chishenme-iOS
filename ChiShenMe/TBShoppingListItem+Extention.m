//
//  TBShoppingListItem+Extention.m
//  ChiShenMe
//
//  Created by Nate on 5/02/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "TBShoppingListItem+Extention.h"

@implementation TBShoppingListItem (Extention)

+ (instancetype)insertNewTBShoppingListItemWithShoppingListItem: (ShoppingListItem *)shoppinglistItem
{
    AppDelegate *appDelegate = [[AppDelegate alloc] init];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    TBShoppingListItem *tb_shoppinglistItem = [NSEntityDescription insertNewObjectForEntityForName:TB_SHOPPINGLISTITEM inManagedObjectContext:context];

    [self initTBShoppingListItem:tb_shoppinglistItem withShoppingListItem:shoppinglistItem];
    
    NSError *error;
    if ([context save:&error])
    {
        NSLog(@"error: %@", [error localizedDescription]);
    }
    return tb_shoppinglistItem;
}

+ (instancetype)initTBShoppingListItemWithDefault
{
    AppDelegate *appDelegate = [[AppDelegate alloc] init];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    TBShoppingListItem *tb_shoppinglistItem = [NSEntityDescription insertNewObjectForEntityForName:TB_SHOPPINGLISTITEM inManagedObjectContext:context];
    
    ShoppingListItem *shoppinglistItem = [[ShoppingListItem alloc] initWithDefault];
    [self initTBShoppingListItem:tb_shoppinglistItem withShoppingListItem:shoppinglistItem];
    return tb_shoppinglistItem;
}

+ (instancetype)updateTBShoppingListItemWithShoppingListItem: (ShoppingListItem *)shoppinglistItem
{
    AppDelegate *appDelegate = [[AppDelegate alloc] init];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSError *error;
    TBShoppingListItem *tb_shoppinglistItem = (TBShoppingListItem *)[context existingObjectWithID:shoppinglistItem.shoppinglistitem_id error:&error];
    tb_shoppinglistItem = [self initTBShoppingListItem:tb_shoppinglistItem withShoppingListItem:shoppinglistItem];

    if ([context save:&error])
    {
        NSLog(@"error: %@", [error localizedDescription]);
    }
    
    return tb_shoppinglistItem;
}

+ (instancetype)initTBShoppingListItem: (TBShoppingListItem *) tb_shoppinglistItem withShoppingListItem: (ShoppingListItem *)shoppinglistItem
{
    tb_shoppinglistItem.subject = shoppinglistItem.subject;
    tb_shoppinglistItem.quantity = shoppinglistItem.quantity;
    tb_shoppinglistItem.checked = shoppinglistItem.checked;
    return tb_shoppinglistItem;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %ld %d", self.subject, (long)self.quantity, self.checked];
}

@end
