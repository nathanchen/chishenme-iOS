//
//  Networks.h
//  ChiShenMe
//
//  Created by Nate on 25/12/2014.
//  Copyright (c) 2014 Nathan CHEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "Config.h"

@interface Networks : NSObject

+ (NSInteger)networkStatus;

+ (BOOL)isNetworkExist;

@end
