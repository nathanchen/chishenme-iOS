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

@property (nonatomic) int shoppinglistitem_id;
@property (nonatomic, weak) NSString *subject;
@property (nonatomic) int quantity;
@property (nonatomic) BOOL checked;

- (instancetype)initShoppingListItemWithSubject:(NSString *)subject quantity:(int)quantity checked:(BOOL)checked;

- (instancetype)initShoppingListItemWithTBShoppingListItem:(TBShoppingListItem *)tb_shoppinglistItem;

- (BOOL)isValidShoppingListItemWithSubject:(NSString *)subject
                                  quantity:(NSInteger)quantity
                                     check:(BOOL)checked;

- (void)toggleChecked;

- (NSString *)description;

- (instancetype)initWithDefault;

@end
