//
//  ShoppingListItem.m
//  ChiShenMe
//
//  Created by Nate on 5/02/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "ShoppingListItem.h"

@implementation ShoppingListItem

- (instancetype)initShoppingListItemWithId:(NSManagedObjectID *)shoppinglistitem_id
                                   subject:(NSString *)subject
                                  quantity:(int)quantity
                                   checked:(BOOL)checked
{
    self = [super init];
    if (self)
    {
        _shoppinglistitem_id = shoppinglistitem_id;
        _subject = subject;
        _quantity = quantity;
        _checked = checked;
    }
    return self;
}

- (instancetype)initShoppingListItemWithTBShoppingListItem:(TBShoppingListItem *)tb_shoppinglistItem
{
    return [self initShoppingListItemWithId:[tb_shoppinglistItem objectID]
                                    subject:tb_shoppinglistItem.subject
                                   quantity:tb_shoppinglistItem.quantity
                                    checked:tb_shoppinglistItem.checked];
}

- (instancetype)initWithDefault
{
    return [self initShoppingListItemWithId:nil subject:@"" quantity:0 checked:NO];
}

- (BOOL)isValidShoppingListItemWithId:(NSManagedObjectID *)shoppinglistitem_id
                              subject:(NSString *)subject
                             quantity:(NSInteger)quantity
                                checked:(BOOL)checked
{
    if (shoppinglistitem_id.temporaryID)
    {
        return NO;
    }
    else if ([Strings isEmptyString:subject])
    {
        return NO;
    }
    else if (quantity <= 0)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)toggleChecked
{
    _checked = !_checked;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ %ld %d", _subject, (long)_quantity, _checked];
}

@end
