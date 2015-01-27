//
//  Numbers.m
//  ChiShenMe
//
//  Created by Nate on 27/01/2015.
//  Copyright (c) 2015 Nathan CHEN. All rights reserved.
//

#import "Numbers.h"

@implementation Numbers

- (BOOL)inputIsOnlyNumbers: (NSString *)inputString
{
    NSRegularExpression *numbersOnly = [NSRegularExpression regularExpressionWithPattern:@"[0-9]{1,4}" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSInteger numberOfMatches = [numbersOnly numberOfMatchesInString:inputString options:0 range:NSMakeRange(0, [inputString length])];
    
    if (numberOfMatches != 1 && [inputString length] != 0)
    {
        return NO;
    }
    return YES;
}

@end
