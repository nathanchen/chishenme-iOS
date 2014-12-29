//
//  Strings.m
//  ChiShenMe
//
//  Created by Nate on 25/12/2014.
//  Copyright (c) 2014 Nathan CHEN. All rights reserved.
//

#import "Strings.h"

@implementation Strings

+ (NSString *)escapeHTML: (NSString *)originalHTML
{
    NSMutableString *result = [[NSMutableString alloc] initWithString:originalHTML];
    [result replaceOccurrencesOfString:@"&"  withString:@"&amp;"  options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"<"  withString:@"&lt;"   options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@">"  withString:@"&gt;"   options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"\"" withString:@"&quot;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"'"  withString:@"&#39;"  options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    return result;
}

+ (BOOL)isEmptyString:(NSString *)string
{
    if (!string || string.length == 0) {
        return YES;
    }
    
    NSMutableString *temp = [[NSMutableString alloc] initWithString:[string stringByReplacingOccurrencesOfString:@" " withString:@""]];
    [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return [temp isEqualToString:@""];
}

@end
