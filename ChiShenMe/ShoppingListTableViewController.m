//
//  ShoppingListTableViewController.m
//  ChiShenMe
//
//  Created by Nate on 14/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "ShoppingListTableViewController.h"

@interface ShoppingListTableViewController ()

- (void)configureCheckmarkForButtonTag:(NSInteger)tag
                               ForCell:(UITableViewCell *)cell
                  withShoppinglistItem:(ShoppingListItem *)item
                         withIndexPath:(NSIndexPath *)indexPath;

- (void)configureTextForCell:(UITableViewCell *)cell
        withShoppinglistItem: (ShoppingListItem *)item;

- (void)checkButtonClicked:(NSIndexPath *)indexPath;

- (void)setButton: (UIButton *)button backgroundImageForShoppingListItem:(ShoppingListItem *)shoppinglistItem;

- (ItemDetailViewController *)setItemDetailViewControllerDelegate:(UIStoryboardSegue *)segue;

@end

@implementation ShoppingListTableViewController
{
    ShoppingListItem *row0item, *row1item, *row2item, *row3item, *row4item;
    
    NSMutableArray *items;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
        numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingListItem" forIndexPath:indexPath];
    
    ShoppingListItem *item = (ShoppingListItem *)items[indexPath.row];
    
    [self configureTextForCell:cell withShoppinglistItem:item];
    [self configureCheckmarkForButtonTag:TAG_CHECKSIGN_BUTTON
                                 ForCell:cell
                    withShoppinglistItem:item
                           withIndexPath:indexPath];
    return cell;
}

#pragma mark - Table view delegate
// TODO: should be edit rather than select/check
- (void)tableView:(UITableView *)tableView
        didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell)
    {
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (void)tableView:(UITableView *)tableView
        commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
        forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [items removeObjectAtIndex:indexPath.row];
    
    NSMutableArray *indexPaths = [NSMutableArray arrayWithObjects:indexPath, nil];
    [self.tableView deleteRowsAtIndexPaths:indexPaths
                          withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - configure for each cell
- (void)configureCheckmarkForButtonTag:(NSInteger)tag
                               ForCell:(UITableViewCell *)cell
                  withShoppinglistItem:(ShoppingListItem *)item
                         withIndexPath:(NSIndexPath *)indexPath
{
    UIButton *checkSignButton = (UIButton *)[cell viewWithTag:tag];
    
    [self setButton:checkSignButton backgroundImageForShoppingListItem:item];
    [self setTagForButton:checkSignButton withIndexPath:indexPath];
    
    [checkSignButton addTarget:self action:@selector(checkButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configureTextForCell:(UITableViewCell *)cell
        withShoppinglistItem: (ShoppingListItem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:TAG_SUBJECT_LABEL];
    label.text = item.subject;
    
    label = (UILabel *)[cell viewWithTag:TAG_QUANTITY_LABEL];
    label.text = [NSString stringWithFormat:@"%ld", (long)item.quantity];
}

#pragma mark - AddItemViewControllerDelegate
- (void)addItemViewControllerDidFinishAddingItem:(ShoppingListItem *)item
{
    NSInteger newRowIndex = [items count];
    [items addObject:item];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSMutableArray *indexPaths = [NSMutableArray arrayWithObjects:indexPath, nil];
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addItemViewControllerDidFinishEditingItem:(ShoppingListItem *)item
{
    NSInteger index = [items indexOfObject:item];
    if (index)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (cell)
        {
            [self configureTextForCell:cell withShoppinglistItem:item];
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (ItemDetailViewController *)setItemDetailViewControllerDelegate:(UIStoryboardSegue *)segue
{
    UINavigationController *navigationController = segue.destinationViewController;
    ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
    controller.delegate = self;
    return controller;
}

- (void)addItemViewControllerDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    if ([identifier isEqualToString: @"AddItem"])
    {
        [self setItemDetailViewControllerDelegate:segue];
    }
    else if ([identifier isEqualToString:@"EditItem"])
    {
        ItemDetailViewController *controller = [self setItemDetailViewControllerDelegate:segue];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.itemToEdit = items[indexPath.row];
    }
}

- (void)checkButtonClicked:(UIButton *)sender
{
    NSIndexPath *indexPath = [self initialIndexPathWithButton:sender];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if (cell)
    {
        ShoppingListItem *item = (ShoppingListItem *)items[indexPath.row];
        [item toggleChecked];
        [self configureCheckmarkForButtonTag:sender.tag
                                     ForCell:cell
                        withShoppinglistItem:item
                               withIndexPath:indexPath];
    }
}

- (void)setButton:(UIButton *)button
        backgroundImageForShoppingListItem:(ShoppingListItem *)shoppinglistItem
{
    [button setBackgroundImage:[UIImage imageNamed:shoppinglistItem.checked ? @"checkbox-checked" : @"checkbox-uncheck"] forState:UIControlStateNormal];
}

/*
 * use button's tag to record corresponding indexpath info
 * in case every object's default tag is 0
 * button's tag = TAG_CHECKSIGN_BUTTON + indexPath.row
 */
- (void)setTagForButton:(UIButton *)button
          withIndexPath:(NSIndexPath *)indexPath
{
    button.tag = indexPath.row + TAG_CHECKSIGN_BUTTON;
}

- (NSIndexPath *)initialIndexPathWithButton:(UIButton *)button
{
    return [NSIndexPath indexPathForRow:button.tag - TAG_CHECKSIGN_BUTTON inSection:0];
}
@end
