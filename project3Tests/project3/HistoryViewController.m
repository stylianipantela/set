//
//  HistoryViewController.m
//  project3
//
//  Created by Deborah Alves and Styliani Pantela.
//  Copyright (c) 2012 Harvard University. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

// HighScore container
@property (strong, nonatomic) NSArray *highScores;

@end

@implementation HistoryViewController

@synthesize customCell = _customCell;
@synthesize delegate = _delegate;
@synthesize history = _history;
@synthesize highScores = _highScores;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {    
        self.title = @"Custom Cells";
        // load plist file into dictionary
        self.history = [[History alloc] init];
        self.highScores = [self.history retrieve];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];   
    self.navigationItem.title = @"High Scores";
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;   
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// we only have one section, the high scores
- (int)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.highScores count];
}

- (UITableViewCell  *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        // load cell from nib into self.customCell
        [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        
        // current cell should use newly loaded cell
        cell = self.customCell;
        
        // clear cell so it can be loaded again
        self.customCell = nil;
        
    }
    
    // main cell text is fruit name
    UILabel *leftLabel = (UILabel *)[cell viewWithTag:10];
    leftLabel.text = [[[self.highScores objectAtIndex:indexPath.row] objectAtIndex:0] stringValue];
    
    // detail text is description of fruit
    UILabel *rightLabel = (UILabel *)[cell viewWithTag:11];
    rightLabel.text = [[self.highScores objectAtIndex:indexPath.row] objectAtIndex:1];
    
    return cell;
}


#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate historyViewControllerDidFinish:self];
}


@end