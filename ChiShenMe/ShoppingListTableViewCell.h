//
//  ShoppingListTableViewCell.h
//  ChiShenMe
//
//  Created by Nate on 26/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingListItem.h"
#import "ShoppingListTableViewController.h"
#import "ShoppingListStrikeThroughLabel.h"

#define kTAG_CHECKSIGN_BUTTON 2000
#define kTAG_SUBJECT_TEXTFIELD 1000
#define kTAG_QUANTITY_TEXTFIELD 3000
#define kTAG_BARBUTTONITEM_BUTTON 4000

@protocol ShoppingListTableViewCellDelegate <NSObject>

- (void)shoppinglistItemDeleted:(ShoppingListItem *)shoppinglistItem;

@end

@interface ShoppingListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *subjectTextField;
@property (weak, nonatomic) IBOutlet UITextField *quantityTextField;
@property (weak, nonatomic) IBOutlet UIButton *checkmarkButton;
@property (weak, nonatomic) id<ShoppingListTableViewCellDelegate> delegate;
@property (weak, nonatomic) ShoppingListItem *shoppinglistItem;

+ (instancetype)shoppinglistTableViewCell:(ShoppingListItem *)shoppinglistItem andIndexPath:(NSIndexPath *)indexPath;

- (instancetype)initWithShoppingListItem:(ShoppingListItem *)shoppinglistItem andIndexPath:(NSIndexPath *)indexPath;

- (void)configSubjectTextFieldWithShoppingListItem:(ShoppingListItem *)shoppinglistItem andIndexPath:(NSIndexPath *)indexPath;

- (void)configQuantityTextFieldWithShoppingListItem:(ShoppingListItem *)shoppinglistItem andIndexPath:(NSIndexPath *)indexPath;

- (void)configCheckButtonWithShoppingListItem:(ShoppingListItem *)shoppinglistItem andIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)getTagForQuantityTextFieldWithIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)initialIndexPathWithButton:(UIButton *)button;

- (NSIndexPath *)initialIndexPathWithBarButtonItem:(UIBarButtonItem *)barButtonItem;

- (NSIndexPath *)initialIndexPathWithTextField:(UITextField *)textField initialTagValue:(NSInteger)tagValue;

@end
