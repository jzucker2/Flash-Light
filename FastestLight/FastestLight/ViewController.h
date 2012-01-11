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
    BOOL strobeOn;
    BOOL powerOn;
    IBOutlet UIButton *powerButton;
    IBOutlet UISlider *strobeSlider;
    NSTimer *strobeTimer;
    double strobeLength;
}

@property (nonatomic, retain) NSTimer *strobeTimer;
@property (nonatomic, retain) IBOutlet UISlider *strobeSlider;
@property (nonatomic, retain) IBOutlet UIButton *powerButton;

- (IBAction)changePower:(id)sender;

- (IBAction)flipView:(id)sender;

- (void) turnOn;

- (void) turnOff;

- (IBAction)sliderChanged:(id)sender;

- (void) setStrobe;

- (void) stopStrobe;

- (void) flashStrobe;




@end
