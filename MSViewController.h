//
//  MSViewController.h
//  DynamicMask
//
//  Created by liulei on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSViewController : UIViewController{
	UIImage *sourceImage;
	UIImageView *imageView;

	IBOutlet UISlider *slider1;
	IBOutlet UISlider *slider2;
}

-(IBAction)sliderValueChanged:(id)sender;

@end
