//
//  ShoppingListItemTableViewDataSource.h
//  ChiShenMe
//
//  Created by Nate on 30/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ShoppingListItemTableViewDataSource <NSObject>

- (NSInteger)numberOfRows;

- (UIView *)cellForRow:(NSInteger)row;

- (void)itemAdded;

- (void)itemAddedAtIndex:(NSInteger)index;

@end
