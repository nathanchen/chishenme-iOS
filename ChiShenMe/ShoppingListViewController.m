//
//  ShoppingListViewController.m
//  ChiShenMe
//
//  Created by Nate on 30/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "ShoppingListViewController.h"

static NSString *CELL_IDENTIFIER = @"ShoppingListItem";

@interface ShoppingListViewController ()

@end

@implementation ShoppingListViewController
{
    NSMutableArray *items;
    ShoppingListItem *row0item, *row1item, *row2item, *row3item, *row4item;
    float editingOffset;
    ShoppingListTableViewDragAddNew *dragAddNewView;
    ShoppingListTableViewPinchToAdd *pinchAddNew;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    items = [[NSMutableArray alloc] init];
    
    row0item = [[ShoppingListItem alloc] init];
    row1item = [[ShoppingListItem alloc] init];
    row2item = [[ShoppingListItem alloc] init];
    row3item = [[ShoppingListItem alloc] init];
    row4item = [[ShoppingListItem alloc] init];
    
    row0item.subject = @"Walk the dog";
    row0item.quantity = 2;
    row0item.checked = NO;
    [items addObject:row0item];
    
    row1item.subject = @"Brush my teeth";
    row1item.quantity = 1;
    row1item.checked = YES;
    [items addObject:row1item];
    
    row2item.subject = @"Soccer practice";
    row2item.quantity = 3;
    row2item.checked = NO;
    [items addObject:row2item];
    
    row3item.subject = @"Learn iOS development";
    row3item.quantity = 9;
    row3item.checked = YES;
    [items addObject:row3item];
    
    row4item.subject = @"Eat ice cream";
    row4item.quantity = 5;
    row4item.checked = NO;
    [items addObject:row4item];
    
    ShoppingListItem *item;
    for (int i = 0; i < 20; i ++) {
        item = [ShoppingListItem shoppinglistItem:@"shadhf" quantity:10 check:NO];
        [items addObject:item];
    }
    
    self.tableView.shoppingListItemTableViewDataSource = self;
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.tableView registerClassForCells:[ShoppingListItemTableViewCell class]];
    
    dragAddNewView = [[ShoppingListTableViewDragAddNew alloc] initWithTableView:_tableView];
    pinchAddNew = [[ShoppingListTableViewPinchToAdd alloc] initWithTableView:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ShoppingListItemTableViewCell Delegate methods
- (void)shoppinglistItemDeleted:(ShoppingListItem *)shoppinglistItem
{
    float delay = 0.0;
    
    [items removeObject:shoppinglistItem];
    NSArray *visibleCells = [_tableView visibleCells];
    UIView *lastView = [visibleCells lastObject];
    BOOL startAnimating = false;
    
    for (ShoppingListItemTableViewCell *cell in visibleCells)
    {
        if (startAnimating)
        {
            [UIView animateWithDuration:0.5
                                  delay:delay
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 cell.frame = CGRectOffset(cell.frame, 0.0f, -cell.frame.size.height);
                             }
                             completion:^(BOOL finished) {
                                 if (cell == lastView) {
                                     [self.tableView reloadData];
                                 }
            }];
            delay += 0.1;
        }
        
        if (cell.shoppinglistItem == shoppinglistItem)
        {
            startAnimating = true;
            cell.hidden = YES;
        }
    }
}

- (void)cellDidBeginEditing:(ShoppingListItemTableViewCell *)editingCell
{
    editingOffset = _tableView.scrollView.contentOffset.y - editingCell.frame.origin.y;
    for (ShoppingListItemTableViewCell *cell in [_tableView visibleCells])
    {
        [UIView animateWithDuration:0.3
                         animations:^{
                             cell.frame = CGRectOffset(cell.frame, 0, editingOffset);
                             if (cell != editingCell)
                             {
                                 cell.alpha = 0.3;
                             }
                         }];
    }
}

- (void)cellDidEndEditing:(ShoppingListItemTableViewCell *)editingCell
{
    for (ShoppingListItemTableViewCell *cell in [_tableView visibleCells])
    {
        [UIView animateWithDuration:0.3
                         animations:^{
                             cell.frame = CGRectOffset(cell.frame, 0, -editingOffset);
                             if (cell != editingCell)
                             {
                                 cell.alpha = 1;
                             }
        
        }];
    }
}

- (void)shoppinglistItemCompleted:(ShoppingListItem *)shoppinglistItem
{
    shoppinglistItem.checked = !shoppinglistItem.checked;
    for (ShoppingListItemTableViewCell *cell in _tableView.visibleCells)
    {
        if (cell.shoppinglistItem == shoppinglistItem)
        {
            [cell setStrikethrough];
        }
    }
}

#pragma mark - ShoppingListTableViewDataSource methods
- (NSInteger)numberOfRows
{
    return items.count;
}

- (UITableViewCell *)cellForRow:(NSInteger)row
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    ShoppingListItemTableViewCell *cell = (ShoppingListItemTableViewCell *)[self.tableView dequeueReusableCell];
    ShoppingListItem *item = items[indexPath.row];
    cell.shoppinglistItem = item;
    cell.indexPath = indexPath;
    cell.delegate = self;
    [cell lodeData];
    
    return cell;
}

- (void)itemAdded
{
    [self itemAddedAtIndex:0];
}

- (void)itemAddedAtIndex:(NSInteger)index
{
    ShoppingListItem *shoppinglistItem = [[ShoppingListItem alloc] init];
    [items insertObject:shoppinglistItem atIndex:index];
    [_tableView reloadData];
    ShoppingListItemTableViewCell *editingCell;
    for (ShoppingListItemTableViewCell *cell in _tableView.visibleCells)
    {
        if (cell.shoppinglistItem == shoppinglistItem)
        {
            editingCell = cell;
            break;
        }
    }
    [editingCell.subjectTextField becomeFirstResponder];

}


@end
