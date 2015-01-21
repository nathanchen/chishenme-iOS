//
//  AddItemViewController.m
//  ChiShenMe
//
//  Created by Nate on 15/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "ItemDetailViewController.h"


#define kSubjectTextField 1
#define kAmountTextField 2

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _amountTextField.text = @"1";
    
    ShoppingListItem *item = _itemToEdit;
    if (item)
    {
        self.navigationController.title = @"Edit Item";
        _subjectTextField.text = item.subject;
        _amountTextField.text = [NSString stringWithFormat:@"%ld", (long)item.quantity];
        
        _doneBarButton.enabled = YES;
    }
    [self.subjectTextField becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender
{
    ShoppingListItem *item = _itemToEdit;
    if (item)
    {
        item.subject = _subjectTextField.text;
        item.quantity = [_amountTextField.text integerValue];
        [_delegate addItemViewControllerDidFinishEditingItem:item];
    }
    else
    {
        item = [[ShoppingListItem alloc] init];
        item.subject = _subjectTextField.text;
        item.quantity = [_amountTextField.text integerValue];
        item.checked = NO;
        [_delegate addItemViewControllerDidFinishAddingItem: item];
    }
    
}

- (IBAction)cancel:(id)sender
{
    [_delegate addItemViewControllerDidCancel];
}

- (IBAction)editDidChanged:(id)sender;
{
    UITextField *textField = (UITextField *)sender;
    
    if ([textField.text length] > 0)
    {
        if (textField.tag == kAmountTextField)
        {
            // should only by integer in AmountTextField
            if (! [self inputIsOnlyNumbers:textField])
            {
                [textField becomeFirstResponder];
                return;
            }
        }
        
        if ([_subjectTextField.text length] > 0 && [_amountTextField.text length] > 0)
        {
            _doneBarButton.enabled = YES;
        }
    }
    else
    {
        _doneBarButton.enabled = NO;
    }
}

- (BOOL)inputIsOnlyNumbers: (UITextField *)textField
{
    NSRegularExpression *numbersOnly = [NSRegularExpression regularExpressionWithPattern:@"[0-9]+" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSInteger numberOfMatches = [numbersOnly numberOfMatchesInString:textField.text options:0 range:NSMakeRange(0, [textField.text length])];
    
    if (numberOfMatches != 1 && [textField.text length] != 0)
    {
        return NO;
    }
    return YES;
}

@end
