//
//  ShoppingListItemTableViewCell.m
//  ChiShenMe
//
//  Created by Nate on 30/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "ShoppingListItemTableViewCell.h"

const float LABEL_LEFT_MARGIN = 15.0F;
const float UI_CUES_MARGIN = 10.0F;
const float UI_CUES_WIDTH = 50.0F;

@implementation ShoppingListItemTableViewCell
{
    CAGradientLayer *gradientLayer;
    
    CGPoint originalCenter;
    BOOL deleteOnDragRelease;
    BOOL completeOnDragRelease;
    UILabel *tickLabel;
    UILabel *crossLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // add gradient layer
        gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = self.bounds;
        gradientLayer.colors = @[(id)[[UIColor colorWithWhite:1.0f alpha:0.2f] CGColor],
                                 (id)[[UIColor colorWithWhite:1.0f alpha:0.1f] CGColor],
                                 (id)[[UIColor clearColor] CGColor],
                                 (id)[[UIColor colorWithWhite:0.0f alpha:0.1f] CGColor]];
        gradientLayer.locations = @[@0.00f, @0.01f, @0.95f, @1.00f];
        [self.layer insertSublayer:gradientLayer atIndex:0];
        
        // add pan gesture
        UIGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        recognizer.delegate = self;
        [self addGestureRecognizer:recognizer];
        
        // config layout
        [self configSubjectTextField];
        [self configQuantityTextField];
        [self configXLabel];
        
        // add cue label
        tickLabel = [self createCueLabel];
        tickLabel.text = @"Done";
        tickLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:tickLabel];
        
        crossLabel = [self createCueLabel];
        crossLabel.text = @"Delete";
        crossLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:crossLabel];
        
        tickLabel.frame = CGRectMake(-UI_CUES_WIDTH - UI_CUES_MARGIN, 0, UI_CUES_WIDTH, self.bounds.size.height);
        crossLabel.frame = CGRectMake(self.bounds.size.width + UI_CUES_MARGIN, 0, UI_CUES_WIDTH, self.bounds.size.height);
    }
    return self;
}

- (void)loadData
{
    _subjectTextField.text = _shoppinglistItem.subject;
//    [self setTagForSubjectTextField:_subjectTextField withIndexPath:_indexPath];
    
    _quantityTextField.text = [NSString stringWithFormat:@"%ld", (long)_shoppinglistItem.quantity];
//    [self setTagForAmountTextField:_quantityTextField withIndexPath:_indexPath];
    
    [self setStrikethrough];
}

#pragma mark - Cell layout configuration
- (void)configXLabel
{
    CGSize size = self.frame.size;
    
    _xLabel = [[UILabel alloc] initWithFrame:CGRectMake(245, 8, 10, size.height - 16)];
    [_xLabel setTextColor:[UIColor orangeColor]];
    [_xLabel setTextAlignment:NSTextAlignmentCenter];
    [_xLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
    [_xLabel setText:@"X"];
    [_xLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [self addSubview:_xLabel];
}

- (void)configSubjectTextField
{
    CGSize size = self.frame.size;
    // set up subject text field
    _subjectTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 8, size.width - 100, size.height - 16)];
    [_subjectTextField setFont:[UIFont boldSystemFontOfSize:17.0]];
    [_subjectTextField setTextAlignment:NSTextAlignmentLeft];
    [_subjectTextField setTextColor:[UIColor orangeColor]];
    [_subjectTextField setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [self addSubview:_subjectTextField];
    
    _subjectTextField.delegate = self;
}

- (void)configQuantityTextField
{
    CGSize size = self.frame.size;
    // set up quantity text field
    _quantityTextField = [[UITextField alloc] initWithFrame:CGRectMake(260, 8, 40, size.height - 16)];
    [_quantityTextField setFont:[UIFont boldSystemFontOfSize:17.0]];
    [_quantityTextField setTextAlignment:NSTextAlignmentCenter];
    [_quantityTextField setTextColor:[UIColor orangeColor]];
    [_quantityTextField setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [self addSubview:_quantityTextField];
    
    _quantityTextField.delegate = self;
}

- (void)setStrikethrough
{
    if (_shoppinglistItem.checked)
    {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_subjectTextField.text];
        [attributedString addAttribute:NSStrikethroughStyleAttributeName
                                 value:@2
                                 range:NSMakeRange(0, [_subjectTextField.text length])];
        [attributedString addAttribute:NSStrikethroughColorAttributeName
                                 value:[UIColor blackColor]
                                 range:NSMakeRange(0, [_subjectTextField.text length])];
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor grayColor] range:NSMakeRange(0, [_subjectTextField.text length])];
        _subjectTextField.attributedText = attributedString;
    }
    else
    {
        _subjectTextField.text = _subjectTextField.text;
    }
}

- (UILabel *)createCueLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectNull];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:15.0];
    label.backgroundColor = [UIColor clearColor];
    return label;
}

#pragma mark - Horizontal pan gesture methods
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint translation = [gestureRecognizer translationInView:[self superview]];
    if (fabsf(translation.x) > fabsf(translation.y))
    {
        return YES;
    }
    return NO;
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        originalCenter = self.center;
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [recognizer translationInView:self];
        self.center = CGPointMake(originalCenter.x + translation.x, originalCenter.y);
        deleteOnDragRelease = (self.frame.origin.x < -self.frame.size.width / 2);
        completeOnDragRelease = (self.frame.origin.x > self.frame.size.width / 2);
        float cueAlpha = fabsf(self.frame.origin.x) / (self.frame.size.width / 2);
        tickLabel.alpha = cueAlpha;
        crossLabel.alpha = cueAlpha;
        
        tickLabel.textColor = completeOnDragRelease ? [UIColor greenColor] : [UIColor whiteColor];
        crossLabel.textColor = deleteOnDragRelease ? [UIColor redColor] : [UIColor whiteColor];
    }
    
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        CGRect originalFrame = CGRectMake(0, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
        
        if (!deleteOnDragRelease)
        {
            [UIView animateWithDuration:0.2 animations:^{
                self.frame = originalFrame;
            }];
        }
        else if (deleteOnDragRelease)
        {
            [self.delegate shoppinglistItemDeleted:_shoppinglistItem];
        }
        if (completeOnDragRelease)
        {
            [self.delegate shoppinglistItemCompleted:_shoppinglistItem];
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    gradientLayer.frame = self.bounds;
}

#pragma mark - TextFieldsDelegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([Strings isEmptyString:textField.text])
    {
        return NO;
    }
    
    [textField resignFirstResponder];
    
    if (textField == _subjectTextField)
    {
        [_quantityTextField becomeFirstResponder];
    }
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_shoppinglistItem.checked)
    {
        return NO;
    }
    else if (textField == _quantityTextField && [Strings isEmptyString:_shoppinglistItem.subject])
    {
        return NO;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.delegate cellDidEndEditing:self];
    if (textField == _subjectTextField)
    {
        _shoppinglistItem.subject = _subjectTextField.text;
    }
    else
    {
        _shoppinglistItem.quantity = (int)[_quantityTextField.text integerValue];
    }
    
    if (![Strings isEmptyString:_shoppinglistItem.subject] && _shoppinglistItem.quantity > 0)
    {
        // save it to DB or update
        if (_shoppinglistItem.shoppinglistitem_id != nil)
        {
            // update
            NSLog(@"%@", _shoppinglistItem.shoppinglistitem_id);
        }
        else
        {
            // insert
            TBShoppingListItem *tbShoppingListItem = [TBShoppingListItem insertNewTBShoppingListItemWithShoppingListItem:_shoppinglistItem];
            _shoppinglistItem.shoppinglistitem_id = [tbShoppingListItem objectID];
            [self.delegate tbItemAdded:tbShoppingListItem];
        }
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.delegate cellDidBeginEditing:self];
}

- (BOOL)isSubjectTextField:(UITextField *)textField
{
    if (textField.tag < kTAG_QUANTITY_TEXTFIELD)
    {
        return YES;
    }
    return NO;
}

#pragma mark - Cell tag logical methods
/*
 * use button's tag to record corresponding indexpath info
 * in case every object's default tag is 0
 * button's tag = TAG_CHECKSIGN_BUTTON + indexPath.row
 */
//- (void)setTagForButton:(UIButton *)button
//          withIndexPath:(NSIndexPath *)indexPath
//{
//    button.tag = indexPath.row + kTAG_CHECKSIGN_BUTTON + 1;
//}
//
//- (void)setTagForBarButtonItem:(UIBarButtonItem *)barButtonItem
//                 withIndexPath:(NSIndexPath *)indexPath
//{
//    barButtonItem.tag = indexPath.row + kTAG_BARBUTTONITEM_BUTTON + 1;
//}
//
//- (void)setTagForSubjectTextField:(UITextField *)textField
//                    withIndexPath:(NSIndexPath *)indexPath
//{
//    textField.tag = [self getTagForSubjectTextFieldWithIndexPath:indexPath];
//}
//
//- (void)setTagForAmountTextField:(UITextField *)textField
//                   withIndexPath:(NSIndexPath *)indexPath
//{
//    textField.tag = indexPath.row + kTAG_QUANTITY_TEXTFIELD + 1;
//}
//
//- (NSInteger)getTagForSubjectTextFieldWithIndexPath:(NSIndexPath *)indexPath
//{
//    return indexPath.row + kTAG_SUBJECT_TEXTFIELD + 1;
//}
//
//- (NSInteger)getTagForQuantityTextFieldWithIndexPath:(NSIndexPath *)indexPath
//{
//    return indexPath.row + kTAG_QUANTITY_TEXTFIELD + 1;
//}
//
//- (NSIndexPath *)initialIndexPathWithButton:(UIButton *)button
//{
//    return [NSIndexPath indexPathForRow:button.tag - kTAG_CHECKSIGN_BUTTON - 1 inSection:0];
//}
//
//- (NSIndexPath *)initialIndexPathWithBarButtonItem:(UIBarButtonItem *)barButtonItem
//{
//    return [NSIndexPath indexPathForRow:barButtonItem.tag - kTAG_BARBUTTONITEM_BUTTON - 1 inSection:0];
//}
//
//- (NSIndexPath *)initialIndexPathWithTextField:(UITextField *)textField initialTagValue:(NSInteger)tagValue
//{
//    return [NSIndexPath indexPathForRow:textField.tag - tagValue - 1  inSection:0];
//}

#pragma mark - For Debugging
- (void)showBoudary
{
    [_subjectTextField setBorderStyle:UITextBorderStyleLine];
    [_quantityTextField setBorderStyle:UITextBorderStyleLine];
    [_xLabel setBackgroundColor:[UIColor blackColor]];
}

@end
