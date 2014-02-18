//
//  HistoryViewController.h
//  project3
//
//  Created by Deborah Alves and Styliani Pantela.
//  Copyright (c) 2012 Harvard University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "History.h"

@class HistoryViewController;

@protocol HistoryViewControllerDelegate
- (void)historyViewControllerDidFinish:(HistoryViewController *)controller;
@end


@interface HistoryViewController : UITableViewController {}

@property (weak, nonatomic) IBOutlet UITableViewCell *customCell;

@property (weak, nonatomic) id <HistoryViewControllerDelegate> delegate;
@property (strong, nonatomic) id<History> history;


- (IBAction)done:(id)sender;

@end
