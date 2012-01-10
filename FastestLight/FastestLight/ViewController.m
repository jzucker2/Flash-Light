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
    
    /*
    flashlightOn = YES;
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch])
    {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];  // use AVCaptureTorchModeOff to turn off
        [device unlockForConfiguration];
    }
     */
    
    [self turnOn];
    
    // prevent screen from turning off
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    // set up observers to refresh screen
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewWillAppear:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidDisappear:) name:UIApplicationWillResignActiveNotification object:nil];
    
    NSLog(@"set up background");
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (flashlightOn == NO) {
        [self turnOn];
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
    [self turnOff];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Actions

- (IBAction)changePower:(id)sender
{
    if (flashlightOn == YES) {
        [self turnOff];
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
        [self turnOn];
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
    flashlightOn = YES;
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
    flashlightOn = NO;
}

#pragma mark - Memory Management

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [powerButton release];
    [super dealloc];
}

@end
