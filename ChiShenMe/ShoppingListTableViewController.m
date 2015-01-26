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

@interface ShoppingListTableViewController () <UITextFieldDelegate>

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
    
    ShoppingListItem *item;
    for (int i = 0; i < 20; i ++) {
        item = [[ShoppingListItem alloc] initShoppingListItemWithSubject:@"shadhf" quantity:10 check:NO];
        [items addObject:item];
    }
    
    _barButtonItem.title = @"+";

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
    
    ShoppingListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingListItem" forIndexPath:indexPath];
        
    ShoppingListItem *item = (ShoppingListItem *)items[indexPath.row];
    
    if (indexPath.row == 15)
    {
        
    }
    
    [self configureTextForCell:cell
          withShoppinglistItem:item
                 withIndexPath:indexPath];
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
        NSIndexPath *indexPath = [self initialIndexPathWithTextField:textField initialTagValue:TAG_SUBJECT_TEXTFIELD];
        ShoppingListTableViewCell *cell = (ShoppingListTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        UITextField *amountTextField = cell.quantityTextField;
        [amountTextField becomeFirstResponder];
    }
    else
    {
        // save
        NSInteger index = textField.tag - TAG_QUANTITY_TEXTFIELD;
        UITextField *subjectTextField = (UITextField *)[self.view viewWithTag:index + TAG_SUBJECT_TEXTFIELD];
        ShoppingListItem *item = [[ShoppingListItem alloc] initShoppingListItemWithSubject:subjectTextField.text quantity:[textField.text intValue] check:NO];
        
        // record it in items array
        [items replaceObjectAtIndex:index withObject:item];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _barButtonItem.title = @"Done";
    [textField setSelectedTextRange:[textField textRangeFromPosition:textField.beginningOfDocument toPosition:textField.endOfDocument]];
}

#pragma mark - Configure for each cell
- (void)configureCheckmarkForButtonTag:(NSInteger)tag
                               ForCell:(ShoppingListTableViewCell *)cell
                  withShoppinglistItem:(ShoppingListItem *)item withIndexPath:(NSIndexPath *)indexPath
{
    UIButton *checkSignButton = cell.checkmarkButton;
    
    [self setButton:checkSignButton backgroundImageForShoppingListItem:item];
    [self setTagForButton:checkSignButton withIndexPath:indexPath];
    
    [checkSignButton addTarget:self action:@selector(checkButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configureTextForCell:(ShoppingListTableViewCell *)cell
        withShoppinglistItem: (ShoppingListItem *)item
               withIndexPath:(NSIndexPath *)indexPath
{
    UITextField *textField = cell.subjectTextField;
    textField.text = item.subject;
    [self setTagForSubjectTextField:textField withIndexPath:indexPath];
    textField.delegate = self;
    
    textField = cell.quantityTextField;
    textField.text = [NSString stringWithFormat:@"%ld", (long)item.quantity];
    [self setTagForAmountTextField:textField withIndexPath:indexPath];
    textField.delegate = self;
}

- (void)checkButtonClicked:(UIButton *)sender
{
    NSIndexPath *indexPath = [self initialIndexPathWithButton:sender];
    ShoppingListTableViewCell *cell = (ShoppingListTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
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
    ShoppingListTableViewCell *cell = (ShoppingListTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    UITextField *subjectTextField = cell.subjectTextField;
    [subjectTextField becomeFirstResponder];
    
    _barButtonItem.title = @"DONE";
}

- (void)didFinishEditingItem
{
    NSIndexPath *indexPath = [self initialIndexPathWithBarButtonItem:_barButtonItem];
    ShoppingListTableViewCell *cell = (ShoppingListTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    if (cell)
    {
        ShoppingListItem *shoppinglistItem = (ShoppingListItem *)items[indexPath.row];
        [self configureTextForCell:cell withShoppinglistItem:shoppinglistItem withIndexPath:indexPath];
        [items replaceObjectAtIndex:indexPath.row withObject:shoppinglistItem];
        [self.view endEditing:YES];
    }
    
    _barButtonItem.title = @"+";
    [self.view endEditing:YES];
}

- (void)setButton:(UIButton *)button
        backgroundImageForShoppingListItem:(ShoppingListItem *)shoppinglistItem
{
    [button setBackgroundImage:[UIImage imageNamed:shoppinglistItem.checked ? @"checkbox-checked" : @"checkbox-uncheck"] forState:UIControlStateNormal];
}

- (void)saveShoppinglistItem:(ShoppingListItem *)item
{
    NSInteger index = [items indexOfObject:item];
    if (index)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        ShoppingListTableViewCell *cell = (ShoppingListTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        if (cell)
        {
            [self configureTextForCell:cell
                  withShoppinglistItem:item
                         withIndexPath:indexPath];
        }
    }
}

#pragma mark - Trivial supporting methods
/*
 * use button's tag to record corresponding indexpath info
 * in case every object's default tag is 0
 * button's tag = TAG_CHECKSIGN_BUTTON + indexPath.row
 */
- (void)setTagForButton:(UIButton *)button
          withIndexPath:(NSIndexPath *)indexPath
{
    button.tag = indexPath.row + TAG_CHECKSIGN_BUTTON + 1;
}

- (void)setTagForBarButtonItem:(UIBarButtonItem *)barButtonItem
                 withIndexPath:(NSIndexPath *)indexPath
{
    barButtonItem.tag = indexPath.row + kTAG_BARBUTTONITEM_BUTTON + 1;
}

- (void)setTagForSubjectTextField:(UITextField *)textField
                    withIndexPath:(NSIndexPath *)indexPath
{
    textField.tag = [self getTagForSubjectTextFieldWithIndexPath:indexPath];
}

- (void)setTagForAmountTextField:(UITextField *)textField
                   withIndexPath:(NSIndexPath *)indexPath
{
    textField.tag = indexPath.row + TAG_QUANTITY_TEXTFIELD + 1;
}

- (NSInteger)getTagForSubjectTextFieldWithIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row + TAG_SUBJECT_TEXTFIELD + 1;
}

- (NSIndexPath *)initialIndexPathWithButton:(UIButton *)button
{
    return [NSIndexPath indexPathForRow:button.tag - TAG_CHECKSIGN_BUTTON - 1 inSection:0];
}

- (NSIndexPath *)initialIndexPathWithBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    return [NSIndexPath indexPathForRow:barButtonItem.tag - kTAG_BARBUTTONITEM_BUTTON - 1 inSection:0];
}

- (NSIndexPath *)initialIndexPathWithTextField:(UITextField *)textField initialTagValue:(NSInteger)tagValue
{
    return [NSIndexPath indexPathForRow:textField.tag - tagValue - 1  inSection:0];
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
