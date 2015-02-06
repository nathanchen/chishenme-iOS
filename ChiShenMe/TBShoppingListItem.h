//
//  TBShoppingListItem.h
//  ChiShenMe
//
//  Created by Nate on 5/02/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TBShoppingListItem : NSManagedObject

@property (nonatomic) BOOL checked;
@property (nonatomic) int16_t quantity;
@property (nonatomic) int32_t shoppinglistitem_id;
@property (nonatomic, retain) NSString * subject;

@end
