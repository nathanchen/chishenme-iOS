//
//  Times.m
//  ChiShenMe
//
//  Created by Nate on 25/12/2014.
//  Copyright (c) 2014 Nathan CHEN. All rights reserved.
//

#import "Times.h"

@implementation Times

+ (NSString *)intervalSinceNow:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *componentsPast = [calendar components:unitFlags fromDate:date];
    NSDateComponents *componentsNow = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSInteger years = [componentsNow year] - [componentsPast year];
    NSInteger months = [componentsNow  month] - [componentsPast month] + years * 12;
    NSInteger days = [componentsNow day] - [componentsPast day] + months * 30;
    NSInteger hours = [componentsNow hour] - [componentsPast hour] + days * 24;
    NSInteger minutes = [componentsNow minute] - [componentsPast minute] + hours * 60;
    
    if (minutes < 1) {
        return @"just now";
    } else if (minutes < 60) {
        return [NSString stringWithFormat:@"%d minutes ago", (int)minutes];
    } else if (hours < 24) {
        return [NSString stringWithFormat:@"%d hours ago", (int)hours];
    } else if (hours < 48 && days == 1) {
        return @"yesterday";
    } else if (days < 30) {
        return [NSString stringWithFormat:@"%d days ago", (int)days];
    } else if (days < 60) {
        return @"a month ago";
    } else if (months < 12) {
        return [NSString stringWithFormat:@"%d months ago", (int)months];
    } else {
        NSArray *arr = [dateStr componentsSeparatedByString:@"T"];
        return [arr objectAtIndex:0];
    }
    
}

@end
