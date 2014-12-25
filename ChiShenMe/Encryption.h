//
//  Encryption.h
//  ChiShenMe
//
//  Created by Nate on 25/12/2014.
//  Copyright (c) 2014 Nathan CHEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface Encryption : NSObject

+ (NSString *)md5: (NSString *) input;

@end
