//
//  ShapeCropViewController.h
//  Shape Crop
//
//  Created by Divyesh Dobariya on 22/12/14.
//  Copyright (c) 2014 Escrow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShapeView.h"
#import "UIImage+RoundedImage.h"
#import "ViewController.h"
#import "UIImage+StackBlur.h"
#import <QuartzCore/QuartzCore.h>
@protocol ShapeCrop;
@interface ShapeCropViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate>

// Create delegates for shape crop
@property (nonatomic,retain)id <ShapeCrop>shapedelegate;
@property (nonatomic,retain)IBOutlet UIView *saveview;
@property (nonatomic,retain)UIImage *galleryimage;
@property (nonatomic,retain)UIImage *gcroppedImage;
@property (nonatomic,retain)IBOutlet UIImageView *galleryimageview;
@property (nonatomic,retain)IBOutlet UIImageView *pipimageview;
@property (nonatomic,retain)IBOutlet UIImageView *originalimageview;
@property (nonatomic,retain)IBOutlet UIView *behindview;
// Create Collectionview And its Array
@property (nonatomic,retain)IBOutlet UICollectionView *collectionview;
@property (nonatomic,retain)NSArray *pipArray;
@property (nonatomic,retain)NSArray *piphiddenArray;
@end
