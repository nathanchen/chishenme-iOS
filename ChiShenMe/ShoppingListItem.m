//
//  ShoppingListItem.m
//  ChiShenMe
//
//  Created by Nate on 5/02/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "ShoppingListItem.h"

@implementation ShoppingListItem

- (instancetype)initShoppingListItemWithSubject:(NSString *)subject quantity:(int)quantity checked:(BOOL)checked
{
    self = [super init];
    if (self)
    {
        _subject = subject;
        _quantity = quantity;
        _checked = checked;
    }
    return self;
}

- (instancetype)initShoppingListItemWithTBShoppingListItem:(TBShoppingListItem *)tb_shoppinglistItem
{
    return [self initShoppingListItemWithSubject:tb_shoppinglistItem.subject quantity:tb_shoppinglistItem.quantity checked:tb_shoppinglistItem.checked];
}

- (BOOL)isValidShoppingListItemWithSubject:(NSString *)subject
                                  quantity:(NSInteger)quantity
                                     check:(BOOL)checked
{
    if ([Strings isEmptyString:subject])
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

- (instancetype)initWithDefault
{
    return [self initShoppingListItemWithSubject:@"" quantity:0 checked:NO];
}

@end
