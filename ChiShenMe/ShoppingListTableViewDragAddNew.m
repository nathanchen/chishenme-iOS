//
//  ShoppingListTableViewDragAddNew.m
//  ChiShenMe
//
//  Created by Nate on 2/02/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "ShoppingListTableViewDragAddNew.h"

@implementation ShoppingListTableViewDragAddNew
{
    ShoppingListTableView *tableView;
    ShoppingListItemTableViewCell *placeholderCell;
    BOOL pullDownInProgress;
}

- (id)initWithTableView:(ShoppingListTableView *)shoppinglistTableView
{
    self = [super init];
    if (self)
    {
        placeholderCell = [[ShoppingListItemTableViewCell alloc] init];
        placeholderCell.backgroundColor = [UIColor redColor];
        tableView = shoppinglistTableView;
        tableView.scrollViewDelegate = self;
    }
    return self;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pullDownInProgress = (scrollView.contentOffset.y <= 0.0f);
    if (pullDownInProgress)
    {
        [tableView insertSubview:placeholderCell atIndex:0];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{    
    if (pullDownInProgress && tableView.scrollView.contentOffset.y <= 0.0f)
    {
        placeholderCell.frame = CGRectMake(0, -tableView.scrollView.contentOffset.y - SHOPPINGLIST_ROW_HEIGHT, tableView.frame.size.width, SHOPPINGLIST_ROW_HEIGHT);
        placeholderCell.subjectTextField.text = (-tableView.scrollView.contentOffset.y > SHOPPINGLIST_ROW_HEIGHT ? @"Release to Add Item" : @"Pull to Add Item");
        placeholderCell.alpha = MIN(1.0f, -tableView.scrollView.contentOffset.y / SHOPPINGLIST_ROW_HEIGHT);
    }
    else
    {
        pullDownInProgress = NO;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (pullDownInProgress && -tableView.scrollView.contentOffset.y > SHOPPINGLIST_ROW_HEIGHT)
    {
        [tableView.shoppingListItemTableViewDataSource itemAdded];
    }
    pullDownInProgress = NO;
    [placeholderCell removeFromSuperview];
}

@end
