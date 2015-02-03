//
//  ShoppingListTableViewPinchToAdd.m
//  ChiShenMe
//
//  Created by Nate on 3/02/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "ShoppingListTableViewPinchToAdd.h"

struct ShoppingListTouchPoints {
    CGPoint upper;
    CGPoint lower;
};
typedef struct ShoppingListTouchPoints ShoppingListTouchPoints;

@implementation ShoppingListTableViewPinchToAdd
{
    ShoppingListTableView *tableView;
    ShoppingListItemTableViewCell *placeholderCell;
    
    int pointOneCellIndex;
    int pointTwoCellIndex;
    ShoppingListTouchPoints initialTouchPoints;
    BOOL pinchInProgress;
    BOOL pinchExceededRequiredDistance;
}

- (id)initWithTableView:(ShoppingListTableView *)shoppingListTableView
{
    self = [super init];
    if (self) {
        placeholderCell = [[ShoppingListItemTableViewCell alloc] init];
        placeholderCell.backgroundColor = [UIColor redColor];
        tableView = shoppingListTableView;
        
        UIGestureRecognizer *recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
        [tableView addGestureRecognizer:recognizer];
    }
    return self;
}

- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        [self pinchStarted:recognizer];
    }
    if (recognizer.state == UIGestureRecognizerStateChanged && pinchInProgress && recognizer.numberOfTouches == 2)
    {
        [self pinchChanged:recognizer];
    }
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        [self pinchEnded:recognizer];
    }
}

- (void)pinchEnded:(UIPinchGestureRecognizer *)recognizer
{
    pinchInProgress = false;
    
    placeholderCell.transform = CGAffineTransformIdentity;
    [placeholderCell removeFromSuperview];
    
    if (pinchExceededRequiredDistance)
    {
        int indexOffset = floor(tableView.scrollView.contentOffset.y / SHOPPINGLIST_ROW_HEIGHT);
        [tableView.shoppingListItemTableViewDataSource itemAddedAtIndex:pointTwoCellIndex + indexOffset];
    }
    else
    {
        [UIView animateWithDuration:0.2f
                              delay:0.0f
             options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             NSArray *visibleCells = tableView.visibleCells;
                             for (ShoppingListItemTableViewCell *cell in visibleCells)
                             {
                                 cell.transform = CGAffineTransformIdentity;
                             }
                         }
                         completion:nil];
    }
}

- (void)pinchChanged:(UIPinchGestureRecognizer *)recognizer
{
    ShoppingListTouchPoints currentTouchPoints = [self getNormalisedTouchPoints:recognizer];
    
    float upperDelta =  currentTouchPoints.upper.y - initialTouchPoints.upper.y;
    float lowerDelta = initialTouchPoints.lower.y - currentTouchPoints.lower.y;
    float delta = -MIN(0, MIN(upperDelta, lowerDelta));
    
    NSArray *visibleCells = tableView.visibleCells;
    for (int i = 0; i < visibleCells.count; i ++)
    {
        UIView *cell = (UIView *)visibleCells[i];
        if (i <= pointOneCellIndex)
        {
            cell.transform = CGAffineTransformMakeTranslation(0, -delta);
        }
        if (i >= pointTwoCellIndex)
        {
            cell.transform = CGAffineTransformMakeTranslation(0, delta);
        }
    }
    
    float gapSize = delta * 2;
    float cappedGapSize = MIN(gapSize, SHOPPINGLIST_ROW_HEIGHT);
    placeholderCell.transform = CGAffineTransformMakeScale(1.0f, cappedGapSize / SHOPPINGLIST_ROW_HEIGHT);
    placeholderCell.subjectTextField.text = gapSize > SHOPPINGLIST_ROW_HEIGHT ? @"Release to Add Item" : @"Pull to Add Item";
    placeholderCell.alpha = MIN(1.0f, gapSize / SHOPPINGLIST_ROW_HEIGHT);
    pinchExceededRequiredDistance = gapSize > SHOPPINGLIST_ROW_HEIGHT;
}

- (void)pinchStarted:(UIPinchGestureRecognizer *)recognizer
{
    initialTouchPoints = [self getNormalisedTouchPoints:recognizer];
    
    pointOneCellIndex = -100;
    pointTwoCellIndex = -100;
    
    NSArray *visibelCells = tableView.visibleCells;
    for (int i = 0; i < visibelCells.count; i ++)
    {
        UIView *cell = (UIView *)visibelCells[i];
        if ([self viewContainsPoint:cell withPoint:initialTouchPoints.upper])
        {
            pointOneCellIndex = i;
            cell.backgroundColor = [UIColor purpleColor];
        }
        if ([self viewContainsPoint:cell withPoint:initialTouchPoints.lower])
        {
            pointTwoCellIndex = i;
            cell.backgroundColor = [UIColor purpleColor];
        }
    }
    
    if (abs(pointOneCellIndex - pointTwoCellIndex) == 1)
    {
        pinchInProgress = YES;
        pinchExceededRequiredDistance = NO;
        
        ShoppingListItemTableViewCell *precedingCell = (ShoppingListItemTableViewCell *)(tableView.visibleCells)[pointOneCellIndex];
        placeholderCell.frame = CGRectOffset(precedingCell.frame, 0.0f, SHOPPINGLIST_ROW_HEIGHT / 2.0f);
        [tableView.scrollView insertSubview:placeholderCell atIndex:0];
    }
}

- (BOOL)viewContainsPoint:(UIView *)view withPoint:(CGPoint)point
{
    CGRect frame = view.frame;
    return (frame.origin.y < point.y) && (frame.origin.y + frame.size.height) > point.y;
}

// returns the two touch points, ordering them to ensure that upper and lower are correctly identified
- (ShoppingListTouchPoints)getNormalisedTouchPoints:(UIGestureRecognizer *)recognizer
{
    CGPoint pointOne = [recognizer locationOfTouch:0 inView:tableView];
    CGPoint pointTwo = [recognizer locationOfTouch:1 inView:tableView];
    
    pointOne.y += tableView.scrollView.contentOffset.y;
    pointTwo.y += tableView.scrollView.contentOffset.y;
    
    if (pointOne.y > pointTwo.y)
    {
        CGPoint temp = pointOne;
        pointOne = pointTwo;
        pointTwo = temp;
    }
    ShoppingListTouchPoints shoppingListTouchPoints = {pointOne, pointTwo};
    return shoppingListTouchPoints;
}



@end

