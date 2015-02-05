//
//  ShoppingListItem.m
//  ChiShenMe
//
//  Created by Nate on 5/02/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "ShoppingListItem.h"


@implementation ShoppingListItem

@dynamic checked;
@dynamic quantity;
@dynamic shoppinglistitem_id;
@dynamic subject;

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
        self.subject = subject;
        self.quantity = quantity;
        self.checked = checked;
    }
    
    return self;
}

- (instancetype)initWithDefault
{
    return [self initShoppingListItemWithSubject:@"" quantity:0 check:NO];
}

- (void)toggleChecked
{
    self.checked = !self.checked;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@\t%ld", self.subject, (long)self.quantity];
}

@end
