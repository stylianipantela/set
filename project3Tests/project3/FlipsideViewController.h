//
//  FlipsideViewController.h
//  project3
//
//  Created by Deborah Alves and Styliani Pantela.
//  Copyright (c) 2012 Harvard University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

- (IBAction)done:(id)sender;

@end
