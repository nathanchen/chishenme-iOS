//
//  ChishenmeFetcher.h
//  ChiShenMe
//
//  Created by Nate on 24/12/2014.
//  Copyright (c) 2014 Nathan CHEN. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CHISHENME_DOMAIN @"http://localhost:8080"

@interface ChishenmeFetcher : NSObject

+ (NSURL *)URLForQuery:(NSString *)query;

+ (NSURL *)URLForCreateUserWith: (NSString *) name And:(NSString *)password And:(NSString *)confirmPassword;

+ (NSURL *)URLForLoginWith: (NSString *)name And:(NSString *)password;

+ (NSURL *)URLForRequestToAddFriend: (int)user_id And: (int)friend_id;

@end
