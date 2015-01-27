//
//  ShoppingListTableViewController.m
//  ChiShenMe
//
//  Created by Nate on 14/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "ShoppingListTableViewController.h"

#define TAG_CHECKSIGN_BUTTON 2000
#define TAG_SUBJECT_TEXTFIELD 1000
#define TAG_QUANTITY_TEXTFIELD 3000
#define kTAG_BARBUTTONITEM_BUTTON 4000

static NSString *CELL_IDENTIFIER = @"ShoppingListItem";

@interface ShoppingListTableViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDelegate>

@end

@implementation ShoppingListTableViewController
{
    ShoppingListItem *row0item, *row1item, *row2item, *row3item, *row4item;
    
    ShoppingListTableViewCell *shoppinglistTableViewCell;
    
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
    
    ShoppingListItem *item;
    for (int i = 0; i < 20; i ++) {
        item = [[ShoppingListItem alloc] initShoppingListItemWithSubject:@"shadhf" quantity:10 check:NO];
        [items addObject:item];
    }
    
    
    _barButtonItem.title = @"+";
    shoppinglistTableViewCell = [[ShoppingListTableViewCell alloc] init];
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
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingListItem *item = (ShoppingListItem *)items[indexPath.row];
    return [self tableViewCellFor:tableView withShoppingListItem:item atIndexPath:indexPath];
}

- (ShoppingListTableViewCell *)tableViewCellFor:(UITableView *)tableView
                     withShoppingListItem:(ShoppingListItem *)shoppinglistItem
                              atIndexPath:(NSIndexPath *)indexPath
{
    ShoppingListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    
    cell = [cell initWithShoppingListItem:shoppinglistItem andIndexPath:indexPath];
    cell.subjectTextField.delegate = self;
    cell.quantityTextField.delegate = self;
    [cell.checkmarkButton addTarget:self action:@selector(checkButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;

}

#pragma mark - Table view delegate
// TODO: should be edit rather than select/check
- (void)tableView:(UITableView *)tableView
        didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _barButtonItem.title = @"+";
    [self.view endEditing:YES];
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

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn: (UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (textField.tag < TAG_QUANTITY_TEXTFIELD)
    {
        NSIndexPath *indexPath = [shoppinglistTableViewCell initialIndexPathWithTextField:textField initialTagValue:TAG_SUBJECT_TEXTFIELD];
        ShoppingListTableViewCell *cell = (ShoppingListTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.subjectTextField.text = textField.text;
        cell.quantityTextField.text = @"2";
        [cell.quantityTextField becomeFirstResponder];
    }
    else
    {
        // save
        NSInteger index = textField.tag - TAG_QUANTITY_TEXTFIELD;
        UITextField *subjectTextField = (UITextField *)[self.view viewWithTag:index + TAG_SUBJECT_TEXTFIELD];
        ShoppingListItem *item = [[ShoppingListItem alloc] initShoppingListItemWithSubject:subjectTextField.text quantity:[textField.text intValue] check:NO];
        
        // record it in items array
        [items replaceObjectAtIndex:index - 1 withObject:item];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _barButtonItem.title = @"Done";
    [textField setSelectedTextRange:[textField textRangeFromPosition:textField.beginningOfDocument toPosition:textField.endOfDocument]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _barButtonItem.title = @"+";
    [self.view endEditing:YES];
}

#pragma mark - Configure for each cell
- (void)checkButtonClicked:(UIButton *)sender
{
    NSIndexPath *indexPath = [shoppinglistTableViewCell initialIndexPathWithButton:sender];
    ShoppingListTableViewCell *cell = (ShoppingListTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    if (cell)
    {
        ShoppingListItem *item = (ShoppingListItem *)items[indexPath.row];
        [item toggleChecked];
        [cell configCheckButtonWithShoppingListItem:item andIndexPath:indexPath];
    }
}

#pragma mark - Logical supporting methods
- (IBAction)barButtonPressed
{
    if ([_barButtonItem.title isEqualToString:@"+"])
    {
        [self didFinishAddingItem];
        _barButtonItem.title = @"Done";
    }
    else
    {
        [self didFinishEditingItem];
        _barButtonItem.title = @"+";
    }
}

- (void)didFinishAddingItem
{
    // add empty item into items array
    NSInteger newRowIndex = [items count];
    ShoppingListItem *shoppinglistItem = [[ShoppingListItem alloc] initWithDefault];
    [items addObject:shoppinglistItem];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSMutableArray *indexPaths = [NSMutableArray arrayWithObjects:indexPath, nil];
    
    // update tableview ui
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];

    // set first responder
    ShoppingListTableViewCell *cell = [self tableViewCellFor:self.tableView withShoppingListItem:shoppinglistItem atIndexPath:indexPath];
    [cell.subjectTextField becomeFirstResponder];
    
    _barButtonItem.title = @"Done";
}

- (void)didFinishEditingItem
{
    NSIndexPath *indexPath = [shoppinglistTableViewCell initialIndexPathWithBarButtonItem:_barButtonItem];
    ShoppingListTableViewCell *cell = (ShoppingListTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    if (cell)
    {
        // update item in items array
        ShoppingListItem *shoppinglistItem = (ShoppingListItem *)items[indexPath.row];
        [items replaceObjectAtIndex:indexPath.row withObject:shoppinglistItem];
        
        // update tableview ui
        [cell configSubjectTextFieldWithShoppingListItem:shoppinglistItem andIndexPath:indexPath];
        [cell configQuantityTextFieldWithShoppingListItem:shoppinglistItem andIndexPath:indexPath];
    }
    
    _barButtonItem.title = @"+";
    [self.view endEditing:YES];
}

# pragma mark - For debugging use only
- (IBAction)debugShowItems
{
    for (ShoppingListItem *item in items)
    {
        NSLog(@"%@", [item description]);
    }
}
@end
