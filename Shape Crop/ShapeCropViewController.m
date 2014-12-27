//
//  ShapeCropViewController.m
//  Shape Crop
//
//  Created by Divyesh Dobariya on 22/12/14.
//  Copyright (c) 2014 Escrow. All rights reserved.
//

#import "ShapeCropViewController.h"

@interface ShapeCropViewController ()

@end
static CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};

@implementation ShapeCropViewController
@synthesize shapedelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _gcroppedImage=[_galleryimage imageWithImage:_galleryimage scaledToSize:CGSizeMake(320, 385)];
    _galleryimageview.image=[_gcroppedImage stackBlur:10.0];
   // _originalimageview.image=cropedImage;
    _pipArray=[[NSArray alloc]initWithObjects:@"ph1.png",@"ph2.png",@"ph3.png", nil];
    _piphiddenArray=[[NSArray alloc]initWithObjects:@"ph1_m.png",@"ph2_m.png",@"ph3_m.png", nil];
//    _shapeHiddenArray=[[NSArray alloc]initWithObjects:@"circle_filled.png",@"dai_filled.png",@"diam_filled.png",@"heart_filled.png",@"hex_filled.png",@"oval_filled.png",@"pent_filled.png",@"polygon_filled.png",@"rstar_filled.png",@"square_filled.png",@"star_filled.png",@"triangel_filled.png", nil];

  //  _shapeHiddenArray=[[NSArray alloc]initWithObjects:@"circle_2_filled.png",@"dai_2_filled.png",@"diam_2_filled.png",@"heart_2_filled.png",@"hex_2_filled.png",@"oval_2_filled.png",@"pent_2_filled.png",@"polygon_2_filled.png",@"rstar_2_filled.png",@"square_2_filled.png",@"star_2_filled.png",@"triangel_2_filled.png", nil];

    
    
    
    self.collectionview.delegate=self;
    self.collectionview.dataSource=self;
    
    [self.collectionview registerNib:[UINib nibWithNibName:@"ShapeView" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    

    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerPinch:)];
    [pinchGestureRecognizer setDelegate:self];
    [self.originalimageview addGestureRecognizer:pinchGestureRecognizer];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureDetected:)];
    [panGestureRecognizer setDelegate:self];
    [self.originalimageview addGestureRecognizer:panGestureRecognizer];
    
    _originalimageview.image=_gcroppedImage;
    _behindview.frame=CGRectMake(120, 80, 172, 323);
    UIImage *_maskingImage = [UIImage imageNamed:@"ph1_m.png"];
    CALayer *_maskingLayer = [CALayer layer];
    _maskingLayer.frame =_behindview.bounds;
    [_maskingLayer setContents:(id)[_maskingImage CGImage]];
    [_behindview.layer setMask:_maskingLayer];
    _pipimageview.image=[UIImage imageNamed:@"ph1.png"];

    // Do any additional setup after loading the view from its nib.
}
- (UIImage *) screenshot {
    UIGraphicsBeginImageContextWithOptions(self.saveview.bounds.size, NO, 1.0f);
    
    [self.saveview drawViewHierarchyInRect:self.saveview.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_pipArray count];
}
-(ShapeView *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShapeView *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.shapeimageview.image=[UIImage imageNamed:[_pipArray objectAtIndex:indexPath.row]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _pipimageview.image=[UIImage imageNamed:[_pipArray objectAtIndex:indexPath.row]];
    _originalimageview.image=_gcroppedImage;

    if(indexPath.row==0){
        _behindview.frame=CGRectMake(120, 80, 172, 323);
        UIImage *_maskingImage = [UIImage imageNamed:@"ph1_m.png"];
        CALayer *_maskingLayer = [CALayer layer];
        _maskingLayer.frame =_behindview.bounds;
        [_maskingLayer setContents:(id)[_maskingImage CGImage]];
        [_behindview.layer setMask:_maskingLayer];

    }else if (indexPath.row==1){
        _behindview.frame=CGRectMake(52, 70, 118, 98);
        UIImage *_maskingImage = [UIImage imageNamed:@"ph2_m.png"];
        CALayer *_maskingLayer = [CALayer layer];
        _maskingLayer.frame =_behindview.bounds;
        [_maskingLayer setContents:(id)[_maskingImage CGImage]];
        [_behindview.layer setMask:_maskingLayer];

    }else if (indexPath.row==2){
        _behindview.frame=CGRectMake(40, 106, 200, 155);
        UIImage *_maskingImage = [UIImage imageNamed:@"ph3_m.png"];
        CALayer *_maskingLayer = [CALayer layer];
        _maskingLayer.frame =_behindview.bounds;
        [_maskingLayer setContents:(id)[_maskingImage CGImage]];
        [_behindview.layer setMask:_maskingLayer];
    }
    
    
}
- (void)twoFingerPinch:(UIPinchGestureRecognizer *)recognizer
{
    //    NSLog(@"Pinch scale: %f", recognizer.scale);
    if (recognizer.scale >1.0f && recognizer.scale < 2.5f) {
        CGAffineTransform transform = CGAffineTransformMakeScale(recognizer.scale, recognizer.scale);
        _originalimageview.transform = transform;
    }
}
-(IBAction)ApplybtnPress:(id)sender
{
    
    [shapedelegate didReceiveShapedimage:[self screenshot]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    
    CGImageRef maskRef = maskImage.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef),NULL, TRUE);
    
   // CGImageCreateWithImageInRect(mask, CGRectMake(0, 0, 50, 50));
    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
    return [UIImage imageWithCGImage:masked];
    
}
- (UIImage*) mymaskImage:(UIImage *)image withMask:(UIImage *)maskImage inRect:(CGRect)rect {
    
    CGImageRef maskRef = maskImage.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGRectGetWidth(rect),
                                        CGRectGetHeight(rect),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef),NULL, TRUE);
    
//    CGImageMaskCreate(<#size_t width#>, <#size_t height#>, <#size_t bitsPerComponent#>, <#size_t bitsPerPixel#>, <#size_t bytesPerRow#>, <#CGDataProviderRef provider#>, <#const CGFloat *decode#>, <#bool shouldInterpolate#>)
    
    // CGImageCreateWithImageInRect(mask, CGRectMake(0, 0, 50, 50));
    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
    return [UIImage imageWithCGImage:masked];
    
}

- (UIImage*)newmaskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGImageRef maskImageRef = [maskImage CGImage];
    
    // create a bitmap graphics context the size of the image
    CGContextRef mainViewContentContext = CGBitmapContextCreate (NULL, maskImage.size.width, maskImage.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    
    if (mainViewContentContext==NULL)
        return NULL;
    
    CGFloat ratio = 0;
    
    ratio = maskImage.size.width/ image.size.width;
    
    if(ratio * image.size.height < maskImage.size.height) {
        ratio = maskImage.size.height/ image.size.height;
    }
    
    CGRect rect1  = {{0, 0}, {maskImage.size.width, maskImage.size.height}};
    CGRect rect2  = {{-((image.size.width*ratio)-maskImage.size.width)/2 , -((image.size.height*ratio)-maskImage.size.height)/2}, {image.size.width*ratio, image.size.height*ratio}};
    
    
    CGContextClipToMask(mainViewContentContext, rect1, maskImageRef);
    CGContextDrawImage(mainViewContentContext, rect2, image.CGImage);
    
    
    // Create CGImageRef of the main view bitmap content, and then
    // release that bitmap context
    CGImageRef newImage = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);
    
    UIImage *theImage = [UIImage imageWithCGImage:newImage];
    
    CGImageRelease(newImage);
    
    // return the image
    return theImage;
}
-(IBAction)Backbtnpress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)pinchGestureDetected:(UIPinchGestureRecognizer *)recognizer
{
    
    UIGestureRecognizerState state = [recognizer state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGFloat scale = [recognizer scale];
        [recognizer.view setTransform:CGAffineTransformScale(recognizer.view.transform, scale,scale)];
        [recognizer setScale:1.0];
    }
}
-(void)panGestureDetected:(UIPanGestureRecognizer *)recognizer
{
    
    
    UIGestureRecognizerState state = [recognizer state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [recognizer translationInView:recognizer.view];
        [recognizer.view setTransform:CGAffineTransformTranslate(recognizer.view.transform, translation.x, translation.y)];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
