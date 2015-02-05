//
//  ShoppingListItem.h
//  ChiShenMe
//
//  Created by Nate on 5/02/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ShoppingListItem : NSManagedObject

@property (nonatomic) BOOL checked;
@property (nonatomic) int16_t quantity;
@property (nonatomic) int32_t shoppinglistitem_id;
@property (nonatomic, retain) NSString * subject;

+ (instancetype)shoppinglistItem:(NSString *)subject
                        quantity:(NSInteger)quantity
                           check:(BOOL)checked;

+ (instancetype)shoppinglistItem;

- (instancetype)initWithDefault;
- (instancetype)initShoppingListItemWithSubject:(NSString *)subject
                                       quantity:(NSInteger)quantity
                                          check:(BOOL)checked;
- (void)toggleChecked;
- (NSString *)description;


@end
