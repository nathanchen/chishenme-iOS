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

+ (NSURL *)URLForCreateUserWith: (NSString *) name password:(NSString *)password confirmpassword:(NSString *)confirmPassword checksum: (NSString *)checksum;

+ (NSURL *)URLForLoginWithName: (NSString *)name password:(NSString *)password checksum:(NSString *)checksum;

+ (NSURL *)URLForRequestToAddFriendWithUserId: (int)user_id friendId: (int)friend_id;

@end
