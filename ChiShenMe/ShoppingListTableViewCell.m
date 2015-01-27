//
//  ShoppingListTableViewCell.m
//  ChiShenMe
//
//  Created by Nate on 26/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "ShoppingListTableViewCell.h"

@interface ShoppingListTableViewCell()

@end

@implementation ShoppingListTableViewCell

- (instancetype)initWithShoppingListItem:(ShoppingListItem *)shoppinglistItem andIndexPath:(NSIndexPath *)indexPath
{
    [self configSubjectTextFieldWithShoppingListItem:shoppinglistItem andIndexPath:indexPath];
    [self configQuantityTextFieldWithShoppingListItem:shoppinglistItem andIndexPath:indexPath];
    [self configCheckButtonWithShoppingListItem:shoppinglistItem andIndexPath:indexPath];
    
    return self;
}

#pragma mark - Cell layout configuration
- (void)configSubjectTextFieldWithShoppingListItem:(ShoppingListItem *)shoppinglistItem andIndexPath:(NSIndexPath *)indexPath
{
    // set up subject text field
    _subjectTextField.text = shoppinglistItem.subject;
    [self setTagForSubjectTextField:_subjectTextField withIndexPath:indexPath];
}

- (void)configQuantityTextFieldWithShoppingListItem:(ShoppingListItem *)shoppinglistItem andIndexPath:(NSIndexPath *)indexPath
{
    // set up quantity text field
    _quantityTextField.text = [NSString stringWithFormat:@"%ld", (long)shoppinglistItem.quantity];
    [self setTagForAmountTextField:_quantityTextField withIndexPath:indexPath];
}

- (void)configCheckButtonWithShoppingListItem:(ShoppingListItem *)shoppinglistItem andIndexPath:(NSIndexPath *)indexPath
{
    // set up check button
    [self setButton:_checkmarkButton backgroundImageForShoppingListItem:shoppinglistItem];
    [self setTagForButton:_checkmarkButton withIndexPath:indexPath];
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
    button.tag = indexPath.row + kTAG_CHECKSIGN_BUTTON + 1;
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
    textField.tag = indexPath.row + kTAG_QUANTITY_TEXTFIELD + 1;
}

- (NSInteger)getTagForSubjectTextFieldWithIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row + kTAG_SUBJECT_TEXTFIELD + 1;
}

- (NSIndexPath *)initialIndexPathWithButton:(UIButton *)button
{
    return [NSIndexPath indexPathForRow:button.tag - kTAG_CHECKSIGN_BUTTON - 1 inSection:0];
}

- (NSIndexPath *)initialIndexPathWithBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    return [NSIndexPath indexPathForRow:barButtonItem.tag - kTAG_BARBUTTONITEM_BUTTON - 1 inSection:0];
}

- (NSIndexPath *)initialIndexPathWithTextField:(UITextField *)textField initialTagValue:(NSInteger)tagValue
{
    return [NSIndexPath indexPathForRow:textField.tag - tagValue - 1  inSection:0];
}

@end
