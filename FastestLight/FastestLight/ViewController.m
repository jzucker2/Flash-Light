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
    NSLog(@"viewDidLoad");
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
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
    
    flashlightOn = YES;
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch])
    {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];  // use AVCaptureTorchModeOff to turn off
        [device unlockForConfiguration];
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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Actions

- (IBAction)changePower:(id)sender
{
    NSLog(@"change power");
    if (flashlightOn == YES) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch])
        {
            [device lockForConfiguration:nil];
            [device setTorchMode:AVCaptureTorchModeOff];  // use AVCaptureTorchModeOff to turn off
            [device unlockForConfiguration];
        }
        flashlightOn = NO;
    }
    else
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
}

- (IBAction)flipView:(id)sender
{
    AboutViewController *aboutView = [[AboutViewController alloc] initWithNibName:@"AboutView" bundle:nil];
    [aboutView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentModalViewController:aboutView animated:YES];
    [aboutView release];
}

#pragma mark - Memory Management

- (void) dealloc
{
    [powerButton release];
    [super dealloc];
}

@end
