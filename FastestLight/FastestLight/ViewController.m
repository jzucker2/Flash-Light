//
//  ViewController.m
//  FastestLight
//
//  Created by Jordan Zucker on 12/27/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "ViewController.h"
#import "AboutViewController.h"

@implementation ViewController

@synthesize powerButton;
@synthesize strobeSlider;
@synthesize strobeTimer;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    [self turnOn];
    
    // set BOOL values
    powerOn = YES;
    strobeOn = NO;
    
    // prevent screen from turning off
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    // set up observers to refresh screen
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewWillAppear:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidDisappear:) name:UIApplicationWillResignActiveNotification object:nil];
    
    NSLog(@"set up background");
    
    [powerButton setBackgroundColor:[UIColor greenColor]];
    //[powerButton setBackgroundImage:[UIImage imageNamed:@"on.png"] forState:UIControlStateNormal];
}

- (void)viewDiUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ((strobeSlider.value==0) && (powerOn == YES))
    {
        [self turnOn];
    }
    if ((strobeSlider.value>0) && (powerOn == YES)) {
        NSLog(@"set strobe");
        [self setStrobe];
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
    if (strobeOn == YES) {
        //[self stopStrobe];
        [strobeTimer invalidate];
        strobeTimer = nil;
    }
    //[self turnOff];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Actions

- (IBAction)changePower:(id)sender
{
    if (powerOn == YES) {
        if (strobeOn == YES) {
            [self stopStrobe];
        }
        else
        {
            [self turnOff];
        }
        //[self turnOff];
        powerOn = NO;
        //[powerButton setBackgroundImage:[UIImage imageNamed:@"off.png"] forState:UIControlStateNormal];
        [powerButton setBackgroundColor:[UIColor redColor]];
        /*
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch])
        {
            [device lockForConfiguration:nil];
            [device setTorchMode:AVCaptureTorchModeOff];  // use AVCaptureTorchModeOff to turn off
            [device unlockForConfiguration];
        }
        flashlightOn = NO;
         */
    }
    else
    {
        if (strobeOn == YES) {
            [self setStrobe];
        }
        else
        {
            [self turnOn];
        }
        //[self turnOn];
        powerOn = YES;
        [powerButton setBackgroundColor:[UIColor greenColor]];
        //[powerButton setBackgroundImage:[UIImage imageNamed:@"on.png"] forState:UIControlStateNormal];
        /*
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch])
        {
            [device lockForConfiguration:nil];
            [device setTorchMode:AVCaptureTorchModeOn];  // use AVCaptureTorchModeOff to turn off
            [device unlockForConfiguration];
        }
        flashlightOn = YES;
         */
    }
}

- (IBAction)sliderChanged:(id)sender
{
    NSLog(@"sliderChanged: %f", strobeSlider.value);
    [self stopStrobe];
    if (strobeSlider.value > 0) {
        NSLog(@"turn on strobe");
        //strobeOn = YES;
        if (powerOn == YES) {
            [self setStrobe];
        }
        //[self setStrobe];
    }
    if (strobeSlider.value == 0) {
        NSLog(@"just turn on light");
        if (powerOn == YES) {
            [self turnOn];
        }
        //[self turnOn];
        //[self stopStrobe];
    }
}

- (IBAction)flipView:(id)sender
{
    AboutViewController *aboutView = [[AboutViewController alloc] initWithNibName:@"AboutView" bundle:nil];
    [aboutView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentModalViewController:aboutView animated:YES];
    [aboutView release];
}

#pragma mark - Flash Light Methods

- (void) turnOn
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch])
    {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];  // use AVCaptureTorchModeOff to turn off
        [device unlockForConfiguration];
    }
    //flashlightOn = YES;
    //powerOn = YES;
}

- (void) turnOff
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch])
    {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOff];  // use AVCaptureTorchModeOff to turn off
        [device unlockForConfiguration];
    }
    //flashlightOn = NO;
    //powerOn = NO;
}

- (void) setStrobe
{
    if (strobeSlider.value<1) {
        strobeLength = fabs(1-strobeSlider.value);
    }
    else
    {
        strobeLength = .001;
    }
    strobeTimer = [NSTimer scheduledTimerWithTimeInterval:strobeLength target:self selector:@selector(flashStrobe) userInfo:nil repeats:YES];
    strobeOn = YES;
}

- (void) flashStrobe
{
    [self turnOn];
    double offTime = strobeLength/2;
    [NSThread sleepForTimeInterval:offTime];
    [self turnOff];
}

- (void) stopStrobe
{
    NSLog(@"stop strobe");
    [strobeTimer invalidate];
    strobeTimer = nil;
    strobeOn = NO;
    
    //[self turnOff];
}

#pragma mark - Memory Management

- (void) dealloc
{
    [strobeTimer release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [strobeSlider release];
    [powerButton release];
    [super dealloc];
}

@end
