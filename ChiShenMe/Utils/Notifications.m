//
//  Notifications.m
//  ChiShenMe
//
//  Created by Nate on 25/12/2014.
//  Copyright (c) 2014 Nathan CHEN. All rights reserved.
//

#import "Notifications.h"

@implementation Notifications

+ (void)toastNotification:(NSString *)text inView:(UIView *)view
{
    [view makeToast:text duration:2.0 position:@"center"];
}

@end
