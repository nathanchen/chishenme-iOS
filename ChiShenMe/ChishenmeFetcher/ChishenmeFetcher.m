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

+ (NSURL *)URLForCreateUserWith: (NSString *) name And:(NSString *)password And:(NSString *)confirmPassword
{
    return [self URLForQuery:[NSString stringWithFormat:@"%@/user/add?name=%@&pwd=%@&confirm_pwd=%@", CHISHENME_DOMAIN, name, password, confirmPassword]];
}

+ (NSURL *)URLForLoginWith: (NSString *)name And:(NSString *)password
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/user/login?name=%@&pwd=%@", CHISHENME_DOMAIN, name, password];
    NSLog(requestURL);
    return [self URLForQuery:requestURL];
}

+ (NSURL *)URLForRequestToAddFriend: (int)user_id And: (int)friend_id
{
    return [self URLForQuery:[NSString stringWithFormat:@"%@/friend/add?userid=%d&friendid=%d", CHISHENME_DOMAIN, user_id, friend_id]];
}

@end
