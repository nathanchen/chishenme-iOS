//
//  ShoppingListTableView.h
//  ChiShenMe
//
//  Created by Nate on 30/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingListItemTableViewDataSource.h"
#import "ShoppingListItemTableViewCell.h"

@interface ShoppingListTableView : UIView

@property (weak, nonatomic) id<ShoppingListItemTableViewDataSource> shoppingListItemTableViewDataSource;

- (UIView *)dequeueReusableCell;

//- (UIView *)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

- (void)registerClassForCells:(Class)cellClass;



@end
