//
//  ShoppingListTableViewCell.h
//  ChiShenMe
//
//  Created by Nate on 26/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *subjectTextField;
@property (weak, nonatomic) IBOutlet UITextField *quantityTextField;
@property (weak, nonatomic) IBOutlet UIButton *checkmarkButton;

@end
