//
//  ViewController.h
//  FastestLight
//
//  Created by Jordan Zucker on 12/27/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController
{
    BOOL flashlightOn;
    IBOutlet UIButton *powerButton;
}

@property (nonatomic, retain) IBOutlet UIButton *powerButton;

- (IBAction)changePower:(id)sender;

- (IBAction)flipView:(id)sender;




@end
