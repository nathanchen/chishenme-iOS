//
//  ShoppingListTableView.m
//  ChiShenMe
//
//  Created by Nate on 30/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "ShoppingListTableView.h"

const float SHOPPINGLIST_ROW_HEIGHT = 50.0F;

@implementation ShoppingListTableView
{
    UIScrollView *scrollView;
    NSMutableSet *reuseCells;
    Class _cellClass;
}

- (void)registerClassForCells:(Class)cellClass
{
    _cellClass = cellClass;
}

- (UIView *)dequeueReusableCell
{
    UIView *cell = [reuseCells anyObject];
    if (cell)
    {
        NSLog(@"Returning a cell from the pool");
        [reuseCells removeObject:cell];
    }
    else
    {
        NSLog(@"Creating a new cell");
        cell = [[_cellClass alloc] init];
    }
    return cell;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectNull];
        [self addSubview:scrollView];
        scrollView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        reuseCells = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)layoutSubviews
{
    scrollView.frame = self.frame;
    [self refreshView];
}

- (void)refreshView
{
    if (CGRectIsNull(scrollView.frame))
    {
        return;
    }
    
    scrollView.contentSize = CGSizeMake(scrollView.bounds.size.width, [_shoppingListItemTableViewDataSource numberOfRows] * SHOPPINGLIST_ROW_HEIGHT);
    
    for (UIView *cell in [self cellSubviews])
    {
        // is the cell off the top of the scrollview?
        if (cell.frame.origin.y + cell.frame.size.height < scrollView.contentOffset.y)
        {
            [self recycleCell:cell];
        }
        // is the cell off the bottom of the subview?
        if (cell.frame.origin.y > scrollView.contentOffset.y + scrollView.frame.size.height)
        {
            [self recycleCell:cell];
        }
    }

    int firstVisibleIndex = MAX(0, floor(scrollView.contentOffset.y / SHOPPINGLIST_ROW_HEIGHT));
    int lastVisibleIndex = MIN([_shoppingListItemTableViewDataSource numberOfRows], firstVisibleIndex + 1 + ceil(scrollView.frame.size.height / SHOPPINGLIST_ROW_HEIGHT));
    
    for (int row = firstVisibleIndex; row < lastVisibleIndex; row ++)
    {
        UIView *cell = [self cellForRow:row];
        if (!cell)
        {
            UIView *cell = [_shoppingListItemTableViewDataSource cellForRow:row];
            float topEdgeForRow = row * SHOPPINGLIST_ROW_HEIGHT;
            CGRect frame = CGRectMake(0, topEdgeForRow, scrollView.frame.size.width, SHOPPINGLIST_ROW_HEIGHT);
            cell.frame = frame;
            [scrollView insertSubview:cell atIndex:0];            
        }
    }
}

- (void)recycleCell:(UIView *)cell
{
    [reuseCells addObject:cell];
    [cell removeFromSuperview];
}

- (UIView *)cellForRow:(NSInteger)row
{
    float topEdgeForRow = row * SHOPPINGLIST_ROW_HEIGHT;
    for (UIView *cell in [self cellSubviews])
    {
        if (cell.frame.origin.y == topEdgeForRow)
        {
            return cell;
        }
    }
    return nil;
}

- (NSArray *)cellSubviews
{
    NSMutableArray *cells = [[NSMutableArray alloc] init];
    for (UIView *subView in scrollView.subviews)
    {
        if ([subView isKindOfClass:[ShoppingListItemTableViewCell class]])
        {
            [cells addObject:subView];
        }
    }
    return cells;
}

#pragma mark - property setters
- (void)setDataSource:(id<ShoppingListItemTableViewDataSource>)shoppingListItemTableViewDataSource
{
    _shoppingListItemTableViewDataSource = shoppingListItemTableViewDataSource;
    [self refreshView];
}
@end
