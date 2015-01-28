//
//  ShoppingListItem.m
//  ChiShenMe
//
//  Created by Nate on 14/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "ShoppingListItem.h"

@implementation ShoppingListItem

+ (instancetype)shoppinglistItem
{
    return [[ShoppingListItem alloc] initWithDefault];
}

+ (instancetype)shoppinglistItem:(NSString *)subject quantity:(NSInteger)quantity check:(BOOL)checked
{
    return [[ShoppingListItem alloc] initShoppingListItemWithSubject:subject quantity:quantity check:checked];
}

- (instancetype)initShoppingListItemWithSubject:(NSString *)subject
                                       quantity:(NSInteger)quantity
                                          check:(BOOL)checked
{
    if (self = [super init])
    {
        _subject = subject;
        _quantity = quantity;
        _checked = checked;
    }
    
    return self;
}

- (instancetype)initWithDefault
{
    return [self initShoppingListItemWithSubject:@"" quantity:0 check:NO];
}

- (void)toggleChecked
{
    _checked = !_checked;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@\t%ld", _subject, (long)_quantity];
}

@end
