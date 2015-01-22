//
//  ShoppingListItem.m
//  ChiShenMe
//
//  Created by Nate on 14/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "ShoppingListItem.h"

@implementation ShoppingListItem

- (instancetype)initShoppingListItemWithSubject:(NSString *)subject
                                       quantity:(NSInteger)quantity
                                          check:(BOOL)checked
{
    _subject = subject;
    _quantity = quantity;
    _checked = checked;
    
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

@end
