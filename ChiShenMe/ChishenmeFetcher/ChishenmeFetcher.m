//
//  ChishenmeFetcher.m
//  ChiShenMe
//
//  Created by Nate on 24/12/2014.
//  Copyright (c) 2014 Nathan CHEN. All rights reserved.
//

#import "ChishenmeFetcher.h"

@implementation ChishenmeFetcher

+ (NSURL *)URLForQuery:(NSString *)query
{
    query = [NSString stringWithFormat:@"%@", query];
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:query];
}

+ (NSURL *)URLForCreateUserWith: (NSString *) name password:(NSString *)password confirmpassword:(NSString *)confirmPassword checksum: (NSString *)checksum
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/user/add?name=%@&pwd=%@&confirm_pwd=%@&checksum=%@", CHISHENME_DOMAIN, name, password, confirmPassword, checksum];
    NSLog(requestURL);
    return [self URLForQuery:requestURL];
}

+ (NSURL *)URLForLoginWithName: (NSString *)name password:(NSString *)password checksum:(NSString *)checksum
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/user/login?name=%@&pwd=%@&checksum=%@", CHISHENME_DOMAIN, name, password, checksum];
    NSLog(requestURL);
    return [self URLForQuery:requestURL];
}

+ (NSURL *)URLForRequestToAddFriendWithUserId: (int)user_id friendId: (int)friend_id
{
    return [self URLForQuery:[NSString stringWithFormat:@"%@/friend/add?userid=%d&friendid=%d", CHISHENME_DOMAIN, user_id, friend_id]];
}

@end
