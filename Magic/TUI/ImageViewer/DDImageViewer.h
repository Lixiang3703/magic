//
//  DDImageViewer.h
//  Wuya
//
//  Created by Tong on 18/06/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDSingletonObject.h"

@interface DDImageViewer : DDSingletonObject

+ (DDImageViewer *)getInstance;

- (void)viewFullScreenImageWithImageUrl:(NSString *)imageUrl placeHolderImage:(UIImage *)image startFrame:(CGRect)startFrame endFrame:(CGRect)endFrame animated:(BOOL)animated;
- (void)dismissWithAnimated:(BOOL)animated;

@end
