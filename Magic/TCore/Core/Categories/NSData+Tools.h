//
//  NSData+Tools.h
//  PMP
//
//  Created by Tong on 21/03/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Tools)

- (NSData *)dataByEncrypting;
- (NSData *)dataByDecrypting;

@end


@interface NSData (APNS)

- (NSString *)apnsToken;

@end

@interface NSData(TGZIP)
// GZIP
- (NSData *)gzipUnpack;
- (NSData *)gzipPack;
- (double)sizeKB;

@end
