//
//  ShoppingListStrikeThroughLabel.h
//  ChiShenMe
//
//  Created by Nate on 28/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingListStrikeThroughLabel : UILabel

@property (nonatomic) BOOL strikethrough;

@property (nonatomic, weak) CALayer *strikethroughLayer;

@end
