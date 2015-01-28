//
//  ShoppingListTableViewCell.m
//  ChiShenMe
//
//  Created by Nate on 26/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "ShoppingListTableViewCell.h"

const float LABEL_LEFT_MARGIN = 15.0F;

@interface ShoppingListTableViewCell()
{
    CGPoint originalCenter;
    BOOL deleteOnDragRelease;
    
    BOOL completeOnDragRelease;
}
@end

@implementation ShoppingListTableViewCell

+ (instancetype)shoppinglistTableViewCell:(ShoppingListItem *)shoppinglistItem andIndexPath:(NSIndexPath *)indexPath
{
    return [[ShoppingListTableViewCell alloc] initWithShoppingListItem:shoppinglistItem andIndexPath:indexPath];
}

- (instancetype)initWithShoppingListItem:(ShoppingListItem *)shoppinglistItem andIndexPath:(NSIndexPath *)indexPath
{
    if (self = [super init])
    {
        _shoppinglistItem = shoppinglistItem;
        
        [self configSubjectTextFieldWithShoppingListItem:shoppinglistItem andIndexPath:indexPath];
        [self configQuantityTextFieldWithShoppingListItem:shoppinglistItem andIndexPath:indexPath];
        [self configCheckButtonWithShoppingListItem:shoppinglistItem andIndexPath:indexPath];

        UIGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        recognizer.delegate = self;
        [self addGestureRecognizer:recognizer];
    }
    return self;
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UIButton class]] || [touch.view isKindOfClass:[UITextField class]])
    {
        return NO;
    }
    return YES;
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

#pragma mark - Cell tag logical methods
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

- (NSInteger)getTagForQuantityTextFieldWithIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row + kTAG_QUANTITY_TEXTFIELD + 1;
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

#pragma mark - Input validation


@end
