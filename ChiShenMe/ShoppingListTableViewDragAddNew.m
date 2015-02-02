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
    ShoppingListItemTableViewCell *placeholderCell;
    BOOL pullDownInProgress;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        placeholderCell = [[ShoppingListItemTableViewCell alloc] init];
        placeholderCell.backgroundColor = [UIColor redColor];
    }
    return self;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pullDownInProgress = (scrollView.contentOffset.y <= 0.0f);
    if (pullDownInProgress)
    {
        [self insertSubview:placeholderCell atIndex:0];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];
    
    if (pullDownInProgress && self.scrollView.contentOffset.y <= 0.0f)
    {
        placeholderCell.frame = CGRectMake(0, -self.scrollView.contentOffset.y - SHOPPINGLIST_ROW_HEIGHT, self.frame.size.width, SHOPPINGLIST_ROW_HEIGHT);
        placeholderCell.subjectTextField.text = (-self.scrollView.contentOffset.y > SHOPPINGLIST_ROW_HEIGHT ? @"Release to Add Item" : @"Pull to Add Item");
        placeholderCell.alpha = MIN(1.0f, -self.scrollView.contentOffset.y / SHOPPINGLIST_ROW_HEIGHT);
    }
    else
    {
        pullDownInProgress = NO;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (pullDownInProgress && -self.scrollView.contentOffset.y > SHOPPINGLIST_ROW_HEIGHT)
    {
        [self.shoppingListItemTableViewDataSource itemAdded];
    }
    pullDownInProgress = NO;
    [placeholderCell removeFromSuperview];
}

@end
