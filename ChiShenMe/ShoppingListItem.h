//
//  ShoppingListItem.h
//  ChiShenMe
//
//  Created by Nate on 14/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingListItem : NSObject

@property (nonatomic, strong) NSString *subject;
@property (nonatomic) NSInteger quantity;
@property (nonatomic) BOOL checked;

- (instancetype)initWithDefault;
- (instancetype)initShoppingListItemWithSubject:(NSString *)subject
                                       quantity:(NSInteger)quantity
                                          check:(BOOL)checked;
- (void)toggleChecked;
- (NSString *)description;

@end
