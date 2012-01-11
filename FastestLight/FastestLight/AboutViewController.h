//
//  AboutViewController.h
//  FastestLight
//
//  Created by Jordan Zucker on 12/27/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageUI/MessageUI.h"

@interface AboutViewController : UIViewController <MFMailComposeViewControllerDelegate>
{
    IBOutlet UIButton *emailButton;
    IBOutlet UIButton *websiteButton;
}

@property (nonatomic, retain) IBOutlet UIButton *emailButton;
@property (nonatomic, retain) IBOutlet UIButton *websiteButton;

- (IBAction)backAction:(id)sender;

- (IBAction)sendEmail:(id)sender;
- (void) showEmailModalView;
- (IBAction)visitWebsite:(id)sender;

@end
