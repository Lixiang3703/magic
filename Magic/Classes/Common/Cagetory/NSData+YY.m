//
//  NSData+YY.m
//  Wuya
//
//  Created by Tong on 21/05/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//
//  helioswuya
//

#import "NSData+YY.h"
#import "XRSA.h"

@implementation NSData (YY)

+ (NSData *)encryptWithData:(NSData *)content {
    
    XRSA *rsa = [[XRSA alloc] initWithPublicKey:[[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"]];
    
    if (nil == rsa || [content length] == 0) {
        return nil;
    }
    
    NSMutableData *resData = [NSMutableData data];
    
    NSUInteger length = [content length];
    NSUInteger chunkSize = 116;
    NSUInteger offset = 0;
    char *contentBytes = (char *)[content bytes];
    do {
        NSUInteger thisChunkSize = length - offset > chunkSize ? chunkSize : length - offset;
        NSData* chunk = [NSData dataWithBytesNoCopy:contentBytes + offset
                                             length:thisChunkSize
                                       freeWhenDone:NO];
        
        NSData *encryptData = [rsa encryptWithData:chunk];
        
        if (nil == encryptData) {
            return nil;
        } else  {
            [resData appendData:encryptData];
        }
        
        offset += thisChunkSize;
        // do something with chunk
    } while (offset < length);
    
    
    return resData;
}

@end
