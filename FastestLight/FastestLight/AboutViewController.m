//
//  AboutViewController.m
//  FastestLight
//
//  Created by Jordan Zucker on 12/27/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "AboutViewController.h"


@implementation AboutViewController

@synthesize emailButton, websiteButton;
@synthesize versionLabel, buildLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *versionString = [NSString stringWithFormat:@"Version %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    NSString *buildString = [NSString stringWithFormat:@"Build %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
    versionLabel.text = versionString;
    buildLabel.text = buildString;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)backAction:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Show Email Modal view

- (void) showEmailModalView
{
    MFMailComposeViewController *mailView = [[MFMailComposeViewController alloc] init];
    mailView.mailComposeDelegate = self;
    
    [mailView setSubject:@"From Fastest Flashlight"];
    
    NSString *recipient = @"jordan.zucker@gmail.com";
    NSArray *recipientArray = [[NSArray alloc] initWithObjects:recipient, nil];
    
    [mailView setToRecipients:recipientArray];
    [recipientArray release];
    
    [mailView setMessageBody:@"" isHTML:NO];
    
    [self presentModalViewController:mailView animated:YES];
    [mailView release];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultFailed:
            break;
        default:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Sending failed - Unknown error :(" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            
        }
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}


- (IBAction)visitWebsite:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://www.jordan.zucker.org"];
    if (![[UIApplication sharedApplication] openURL:url])
    {
        NSLog(@"%@%@",@"Failed to open url:",[url description]);
    }
}

- (IBAction)sendEmail:(id)sender
{
    [self showEmailModalView];
}

#pragma mark - Memory Management

- (void) dealloc
{
    [buildLabel release];
    [websiteButton release];
    [emailButton release];
    [versionLabel release];
}

@end
