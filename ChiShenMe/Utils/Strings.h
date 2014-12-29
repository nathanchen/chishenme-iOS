//
//  Strings.h
//  ChiShenMe
//
//  Created by Nate on 25/12/2014.
//  Copyright (c) 2014 Nathan CHEN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Strings : NSObject

+ (NSString *)escapeHTML: (NSString *)originalHTML;

+ (BOOL)isEmptyString: (NSString *)string;

@end
