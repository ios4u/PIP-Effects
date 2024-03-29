//
//  UIImage+RoundedImage.h
//  GreenPaw
//
//  Created by Nikolay Dyankov on 7/10/13.
//  Copyright (c) 2013 Nikolay Dyankov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RoundedImage)

- (UIImage *)roundedImageWithImage:(UIImage *)image;
- (UIImage *)roundedImageWithImage:(UIImageView *)image inRect:(CGRect)newrect;
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
