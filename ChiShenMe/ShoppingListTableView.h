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

#define SHOPPINGLIST_ROW_HEIGHT 50.0F

@interface ShoppingListTableView : UIView <UIScrollViewDelegate>

@property (weak, nonatomic) id<ShoppingListItemTableViewDataSource> shoppingListItemTableViewDataSource;

@property (strong, nonatomic) UIScrollView *scrollView;

- (UIView *)dequeueReusableCell;

//- (UIView *)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

- (void)registerClassForCells:(Class)cellClass;

- (NSArray *)visibleCells;

- (void)reloadData;

@end
