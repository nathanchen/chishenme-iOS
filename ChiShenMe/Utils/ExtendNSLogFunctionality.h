//
//  ExtendNSLogFunctionality.h
//  ChiShenMe
//
//  Created by Nate on 24/12/2014.
//  Copyright (c) 2014 Nathan CHEN. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define NSLog(args...) ExtendNSLog(__FILE__,__LINE__,__PRETTY_FUNCTION__,args);
#else
#define NSLog(x...)
#endif

void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...);
