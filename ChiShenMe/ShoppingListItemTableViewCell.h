//
//  ShoppingListItemTableViewCell.h
//  ChiShenMe
//
//  Created by Nate on 30/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingListItemTableViewCellDelegate.h"
#import "Strings.h"
#import "TBShoppingListItem+Extention.h"

#define kTAG_CHECKSIGN_BUTTON 2000
#define kTAG_SUBJECT_TEXTFIELD 1000
#define kTAG_QUANTITY_TEXTFIELD 3000
#define kTAG_BARBUTTONITEM_BUTTON 4000

@interface ShoppingListItemTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *subjectTextField;
@property (strong, nonatomic) IBOutlet UITextField *quantityTextField;

@property (strong, nonatomic) IBOutlet UILabel *xLabel;
@property (strong, nonatomic) NSManagedObjectID *managedObjectId;

@property (nonatomic) ShoppingListItem *shoppinglistItem;
@property (nonatomic) NSIndexPath *indexPath;

@property (weak, nonatomic) id<ShoppingListItemTableViewCellDelegate> delegate;

- (void)setStrikethrough;

- (void)loadData;


@end
