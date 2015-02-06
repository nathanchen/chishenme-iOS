//
//  TBShoppingListItem+Extention.m
//  ChiShenMe
//
//  Created by Nate on 5/02/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "TBShoppingListItem+Extention.h"

@implementation TBShoppingListItem (Extention)

+ (instancetype)newTBShoppingListItem
{
    AppDelegate *appDelegate = [[AppDelegate alloc] init];
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    return [NSEntityDescription insertNewObjectForEntityForName:TB_SHOPPINGLISTITEM inManagedObjectContext:context];
}

+ (instancetype)insertNewTBShoppingListItemWithShoppingListItem: (ShoppingListItem *)shoppinglistItem inContext:(NSManagedObjectContext *)context
{
    TBShoppingListItem *tb_shoppinglistItem = [self newTBShoppingListItem];
    tb_shoppinglistItem.subject = shoppinglistItem.subject;
    tb_shoppinglistItem.quantity = shoppinglistItem.quantity;
    tb_shoppinglistItem.checked = shoppinglistItem.checked;
    
    NSError *error;
    if ([context save:&error])
    {
        NSLog(@"error: %@", [error localizedDescription]);
    }
    return tb_shoppinglistItem;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %ld %d", self.subject, (long)self.quantity, self.checked];
}

@end
