//
//  ShoppingListTableViewController.m
//  ChiShenMe
//
//  Created by Nate on 14/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "ShoppingListTableViewController.h"

@interface ShoppingListTableViewController ()

- (void)configureCheckmarkForCell:(UITableViewCell *)cell
             withShoppinglistItem:(ShoppingListItem *)item;

- (void)configureTextForCell:(UITableViewCell *)cell
        withShoppinglistItem: (ShoppingListItem *)item;

- (AddItemViewController *)setAddItemViewControllerDelegate:(UIStoryboardSegue *)segue;

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
    
    [self configureCheckmarkForCell:cell withShoppinglistItem:item];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView
        didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell)
    {
        ShoppingListItem *item = (ShoppingListItem *)items[indexPath.row];
        
        [item toggleChecked];
        
        [self configureCheckmarkForCell:cell withShoppinglistItem:item];
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

- (void)configureCheckmarkForCell:(UITableViewCell *)cell
             withShoppinglistItem:(ShoppingListItem *)item
{
    UILabel *checkSignLabel = (UILabel *)[cell viewWithTag:1001];
    if (item.checked)
    {
        checkSignLabel.text = @"☑️";
    }
    else
    {
        checkSignLabel.text = @"";
    }
}

- (void)configureTextForCell:(UITableViewCell *)cell
        withShoppinglistItem: (ShoppingListItem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    
    label.text = item.subject;
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

- (void)addItemViewControllerDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    if ([identifier isEqualToString: @"AddItem"])
    {
        [self setAddItemViewControllerDelegate:segue];
    }
    else if ([identifier isEqualToString:@"EditItem"])
    {
        AddItemViewController *controller = [self setAddItemViewControllerDelegate:segue];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.itemToEdit = items[indexPath.row];
    }
}

- (AddItemViewController *)setAddItemViewControllerDelegate:(UIStoryboardSegue *)segue
{
    UINavigationController *navigationController = segue.destinationViewController;
    AddItemViewController *controller = (AddItemViewController *)navigationController.topViewController;
    controller.delegate = self;
    return controller;
}

@end
