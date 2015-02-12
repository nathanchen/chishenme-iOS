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
    float editingOffset;
    ShoppingListTableViewDragAddNew *dragAddNewView;
    ShoppingListTableViewPinchToAdd *pinchAddNew;
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // load data from DB
    appDelegate = [[AppDelegate alloc] init];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    context = appDelegate.managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:TB_SHOPPINGLISTITEM inManagedObjectContext:context];
    [fetchRequest setEntity:entityDescription];
    NSError *error;
    items = [[context executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    // config table
    self.tableView.shoppingListItemTableViewDataSource = self;
    self.tableView.backgroundColor = [UIColor blackColor];
    [self.tableView registerClassForCells:[ShoppingListItemTableViewCell class]];
    
    // config table view
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
    [cell loadData];
    
    return cell;
}

- (void)itemAdded
{
    [self itemAddedAtIndex:0];
}

// add a default model into table view array, and begin editing it
- (void)itemAddedAtIndex:(NSInteger)index
{
    ShoppingListItem *shoppinglistItem = [[ShoppingListItem alloc] initWithDefault];
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
