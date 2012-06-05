//
//  MSViewController.m
//  DynamicMask
//
//  Created by liulei on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSViewController.h"
#import <QuartzCore/QuartzCore.h>

#define  kRadiusX		50
#define  kRadiusY		30
#define  kMmaskAlpha	0.9

@implementation MSViewController

- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage
{
    CGImageRef maskRef = maskImage.CGImage; 
	
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
										CGImageGetHeight(maskRef),
										CGImageGetBitsPerComponent(maskRef),
										CGImageGetBitsPerPixel(maskRef),
										CGImageGetBytesPerRow(maskRef),
										CGImageGetDataProvider(maskRef), NULL, false);
	
    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
	CGImageRelease(mask);
    return [UIImage imageWithCGImage:masked];
}

CGContextRef newBitmapContextSuitableForSize(CGSize size)
{
	int pixelsWide = size.width;
	int pixelsHigh = size.height;
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
	
    bitmapBytesPerRow   = (pixelsWide * 4); //4
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
	
	colorSpace = CGColorSpaceCreateDeviceRGB();
	
	context = CGBitmapContextCreate ( NULL, // instead of bitmapData
									 pixelsWide,
									 pixelsHigh,
									 8,      // bits per component
									 bitmapBytesPerRow,
									 colorSpace,
									 kCGImageAlphaPremultipliedFirst);
	CGColorSpaceRelease( colorSpace );
	
    if (context== NULL)
    {
        return NULL;
    }
	
    return context;
}

- (UIImage *)creatAlphaMaskImage:(CGRect)fullRect position:(CGPoint) point
{	
	CGRect holeRect = CGRectMake(point.x-kRadiusX, point.y-kRadiusY, kRadiusX*2, kRadiusY*2);
	
	CGContextRef context = newBitmapContextSuitableForSize(fullRect.size);
	
	CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1 green:1 blue:1 alpha:kMmaskAlpha].CGColor);
	CGContextFillRect(context, fullRect);
	
	CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor );
	CGContextSetBlendMode(context, kCGBlendModeClear);
	
	CGContextFillEllipseInRect(context, holeRect);
	
	CGImageRef cgImage = CGBitmapContextCreateImage(context);
	UIImage *retImage = [UIImage imageWithCGImage:cgImage];
	CGImageRelease(cgImage);
	
	// free the context
	CGContextRelease(context);
	
	return retImage;
}

-(IBAction)sliderValueChanged:(id)sender{
	UIImage *mask = [self creatAlphaMaskImage:imageView.frame position:CGPointMake(slider1.value, slider2.value)];
	UIImage *maskedImage = [self maskImage:sourceImage withMask:mask];
	imageView.image = maskedImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	sourceImage = [UIImage imageNamed:@"corgi.png"];
	
	slider1.minimumValue = 0;
	slider1.maximumValue = 320;
	slider1.value = 160;
	
	slider2.minimumValue = 0;
	slider2.maximumValue = 320;
	slider2.value = 160;	
	
	[slider2 setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
	
	UIImage *mask = [self creatAlphaMaskImage:CGRectMake(0,0,320,320) position:CGPointMake(160, 160)];
	
	UIImage *maskedImage = [self maskImage:sourceImage withMask:mask];
	
	imageView = [[UIImageView alloc] initWithImage:maskedImage];
	
	[self.view addSubview:imageView];
}

- (void)dealloc{
	[imageView release];
	
	[slider1 release];
	[slider2 release];
	
	[super dealloc];
}

@end
