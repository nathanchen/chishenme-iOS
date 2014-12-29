//
//  Notifications.h
//  ChiShenMe
//
//  Created by Nate on 25/12/2014.
//  Copyright (c) 2014 Nathan CHEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+Toast.h"

@interface Notifications : NSObject

+ (void)toastNotification: (NSString *)text inView: (UIView *)view;

@end
