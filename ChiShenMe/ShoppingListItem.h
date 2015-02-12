//
//  ShoppingListItem.h
//  ChiShenMe
//
//  Created by Nate on 5/02/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBShoppingListItem.h"
#import "Strings.h"

@interface ShoppingListItem : NSObject

@property (nonatomic, weak) NSManagedObjectID *shoppinglistitem_id;
@property (nonatomic, weak) NSString *subject;
@property (nonatomic) int quantity;
@property (nonatomic) BOOL checked;

- (instancetype)initShoppingListItemWithId:(NSManagedObjectID *)shoppinglistitem_id
                                   subject:(NSString *)subject
                                  quantity:(int)quantity
                                   checked:(BOOL)checked;

- (instancetype)initShoppingListItemWithTBShoppingListItem:(TBShoppingListItem *)tb_shoppinglistItem;

- (BOOL)isValidShoppingListItemWithId:(NSManagedObjectID *)shoppinglistitem_id
                              subject:(NSString *)subject
                             quantity:(NSInteger)quantity
                                checked:(BOOL)checked;

- (void)toggleChecked;

- (NSString *)description;

- (instancetype)initWithDefault;

@end
