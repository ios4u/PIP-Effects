//
//  ViewController.h
//  Shape Crop
//
//  Created by Divyesh Dobariya on 22/12/14.
//  Copyright (c) 2014 Escrow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShapeCropViewController.h"
#import "UIImage+Mask.h"
#import "UIImage+RoundedImage.h"
@protocol ShapeCrop

-(void)didReceiveShapedimage:(UIImage *)shapeimage;

@end

@interface ViewController : UIViewController <ShapeCrop>

@property (nonatomic,retain)IBOutlet UIImageView *imageview;
@end
