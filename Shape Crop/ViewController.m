//
//  ViewController.m
//  Shape Crop
//
//  Created by Divyesh Dobariya on 22/12/14.
//  Copyright (c) 2014 Escrow. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _imageview.image=[_imageview.image imageWithImage:_imageview.image scaledToSize:CGSizeMake(320, 385)];
   // _imageview.image=[_imageview.image circleImage];
    
//    CALayer *mask = [CALayer layer];
//    mask.contents = (id)[[UIImage imageNamed:@"circle.png"] CGImage];
//    mask.frame = CGRectMake(0, 0, 100,100);
//    _imageview.layer.mask = mask;
//    _imageview.layer.masksToBounds = YES;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"lens_flares" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",jsonString);

    
}
-(IBAction)Resetbtnpress:(id)sender
{
    UIImage *newimage=[UIImage imageNamed:@"screeen_640_960.png"];
    _imageview.image=[newimage imageWithImage:newimage scaledToSize:CGSizeMake(320, 385)];
}
-(IBAction)Cropbtnpress:(id)sender
{
    ShapeCropViewController *shape=[[ShapeCropViewController alloc]initWithNibName:@"ShapeCropViewController" bundle:nil];
    shape.galleryimage=_imageview.image;
    shape.shapedelegate=self;
    [self presentViewController:shape animated:YES completion:nil];
}
-(void)didReceiveShapedimage:(UIImage *)shapeimage
{
    _imageview.image=shapeimage;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
