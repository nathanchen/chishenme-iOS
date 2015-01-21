//
//  AddItemViewController.h
//  ChiShenMe
//
//  Created by Nate on 15/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingListItem.h"

@protocol ItemDetailViewControllerDelegate

- (void)addItemViewControllerDidCancel;

- (void)addItemViewControllerDidFinishAddingItem: (ShoppingListItem *) item;

- (void)addItemViewControllerDidFinishEditingItem: (ShoppingListItem *) item;

@end


@interface ItemDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *subjectTextField;

@property (weak, nonatomic) IBOutlet UITextField *amountTextField;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;

@property (nonatomic, strong) ShoppingListItem *itemToEdit;

@property (nonatomic, weak) id<ItemDetailViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;

- (IBAction)done:(id)sender;

@end

