//
//  AddItemViewController.h
//  ChiShenMe
//
//  Created by Nate on 15/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingListItem.h"

@protocol AddItemViewControllerDelegate

- (void)addItemViewControllerDidCancel;

- (void)addItemViewControllerDidFinishAddingItem: (ShoppingListItem *) item;

@end


@interface AddItemViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *subjectTextField;

@property (weak, nonatomic) IBOutlet UITextField *amountTextField;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;

@property (nonatomic, weak) id<AddItemViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;

- (IBAction)done:(id)sender;

@end

