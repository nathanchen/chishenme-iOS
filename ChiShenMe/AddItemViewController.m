//
//  AddItemViewController.m
//  ChiShenMe
//
//  Created by Nate on 15/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "AddItemViewController.h"


#define kSubjectTextField 1
#define kAmountTextField 2

@interface AddItemViewController ()

@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.subjectTextField becomeFirstResponder];
    
    _amountTextField.text = @"1";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender
{
    ShoppingListItem *item = [[ShoppingListItem alloc] init];
    item.subject = _subjectTextField.text;
    item.quantity = [_amountTextField.text integerValue];
    item.checked = NO;
    
    [_delegate addItemViewControllerDidFinishAddingItem: item];
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
