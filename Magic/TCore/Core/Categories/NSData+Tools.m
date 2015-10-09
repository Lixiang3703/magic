//
//  NSData+Tools.m
//  PMP
//
//  Created by Tong on 21/03/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "NSData+Tools.h"
#import "zlib.h"

@implementation NSData (Tools)

-(NSData *)dataByEncrypting {
    NSUInteger length = self.length;
    if (length == 0) {
        return self;
    }
    UInt8 *bytes = (UInt8 *)malloc(length);

    for (int i = 0; i < length; i++) {
        bytes[i] = ((UInt8 *)self.bytes)[i] ^ 200;
    }
    NSData *result = [NSData dataWithBytes:bytes length:length];
    free(bytes);
    return result;
}

-(NSData *)dataByDecrypting {
    return [self dataByEncrypting];
}


@end


@implementation NSData (APNS)

- (NSString *)apnsToken {
    NSString *token = [NSString stringWithFormat:@"%@",self];
	token = [token substringWithRange:NSMakeRange(1, [token length] - 2)];
	token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return token;
}

@end


////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NSData(TGZIP)

- (NSData *)gzipUnpack
{
    if ([self length] == 0) return self;
    
    NSUInteger full_length = [self length];
    NSUInteger half_length = [self length] / 2;
    
    NSMutableData *decompressed = [NSMutableData dataWithLength: full_length + half_length];
    BOOL done = NO;
    int status;
    
    z_stream strm;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = (uInt)[self length];
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    
    if (inflateInit2(&strm, (15+32)) != Z_OK) return nil;
    while (!done)
    {
        // Make sure we have enough room and reset the lengths.
        if (strm.total_out >= [decompressed length])
            [decompressed increaseLengthBy: half_length];
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([decompressed length] - strm.total_out);
        
        // Inflate another chunk.
        status = inflate (&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END) done = YES;
        else if (status != Z_OK) break;
    }
    if (inflateEnd (&strm) != Z_OK) return nil;
    
    // Set real length.
    if (done)
    {
        [decompressed setLength: strm.total_out];
        return [NSData dataWithData: decompressed];
    }
    else return nil;
}

- (NSData *)gzipPack
{
    if ([self length] == 0) return self;
    
    z_stream strm;
    
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    strm.total_out = 0;
    strm.next_in=(Bytef *)[self bytes];
    strm.avail_in = (uInt)[self length];
    
    // Compresssion Levels:
    //   Z_NO_COMPRESSION
    //   Z_BEST_SPEED
    //   Z_BEST_COMPRESSION
    //   Z_DEFAULT_COMPRESSION
    
    if (deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15+16), 8, Z_DEFAULT_STRATEGY) != Z_OK) return nil;
    
    NSMutableData *compressed = [NSMutableData dataWithLength:16384];  // 16K chunks for expansion
    
    do {
        
        if (strm.total_out >= [compressed length])
            [compressed increaseLengthBy: 16384];
        
        strm.next_out = [compressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([compressed length] - strm.total_out);
        
        deflate(&strm, Z_FINISH);
        
    } while (strm.avail_out == 0);
    
    deflateEnd(&strm);
    
    [compressed setLength: strm.total_out];
    return [NSData dataWithData:compressed];
}


- (double)sizeKB {
    return (double)[self length] * 1.0 / 1024;
}

@end