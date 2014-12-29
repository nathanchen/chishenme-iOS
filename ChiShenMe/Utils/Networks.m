//
//  Networks.m
//  ChiShenMe
//
//  Created by Nate on 25/12/2014.
//  Copyright (c) 2014 Nathan CHEN. All rights reserved.
//

#import "Networks.h"

@implementation Networks


+ (NSInteger)networkStatus
{
    Reachability *reachability = [Reachability reachabilityWithHostName:CHISHENME_HOSTNAME];
    return [reachability currentReachabilityStatus];
}

+ (BOOL)isNetworkExist
{
    return [self networkStatus] > 0;
}

@end
