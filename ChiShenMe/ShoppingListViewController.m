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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ShoppingListItemTableViewCell Delegate methods
//- (void)shoppinglistItemDeleted:(ShoppingListItem *)shoppinglistItem
//{
//    NSInteger index = [items indexOfObject:shoppinglistItem];
//    [self tableView:self.tableView deleteRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//}
//
//- (void)shoppinglistItemCompleted:(ShoppingListItem *)shoppinglistItem
//{
//    NSInteger index = [items indexOfObject:shoppinglistItem];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//    [self shoppinglistItemCheckedAtIndexPath:indexPath];
//}
//
//- (void)tableView:(UITableView *)tableView deleteRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView beginUpdates];
//    [items removeObjectAtIndex:indexPath.row];
//    
//    NSMutableArray *indexPaths = [NSMutableArray arrayWithObjects:indexPath, nil];
//    [self.tableView deleteRowsAtIndexPaths:indexPaths
//                          withRowAnimation:UITableViewRowAnimationAutomatic];
//    [tableView endUpdates];
//}
//
//- (void)shoppinglistItemCheckedAtIndexPath:(NSIndexPath *)indexPath
//{
//    ShoppingListItemTableViewCell *cell = (ShoppingListItemTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
//    
//    if (cell)
//    {
//        ShoppingListItem *item = (ShoppingListItem *)items[indexPath.row];
//        [item toggleChecked];
//        [cell setStrikethrough];
//    }
//}
//
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


@end
