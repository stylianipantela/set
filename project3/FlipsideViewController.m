//
//  FlipsideViewController.m
//  project3
//
//  Created by Deborah Alves and Styliani Pantela.
//  Copyright (c) 2012 Harvard University. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIFont *rulesFont = [UIFont fontWithName:@"Verdana" size:14];
    
    UILabel *rules1 = [[UILabel alloc] init];
    [rules1 setText:@"  The goal of the game is to find \"sets\" of 3 cards that follow a certain rule. Each card has a variation of the following four features:\n\n 1) Color: red, green or purple. \n 2) Shape: ovals, squiggles or diamonds. \n 3) Number: one, two or three. \n 4) Shading: solid, open or striped. \n\n   A SET consists of three cards in which, for EACH feature, all cards are either the same or all different regarding this feature.\n\n For instance:"];
    rules1.lineBreakMode = UILineBreakModeWordWrap;
    rules1.numberOfLines = 0;
    rules1.font = rulesFont;
    rules1.textAlignment = UITextAlignmentCenter;
    rules1.frame = CGRectMake(10, 10, 300, 300);
    [rules1 setBackgroundColor:[UIColor clearColor]];
    
	UIImageView *image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"0.png"]];
    UIImageView *image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"5.png"]];
    UIImageView *image3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"7.png"]];
    image1.frame = CGRectMake(20, 310, 90, 60);
    image2.frame = CGRectMake(115, 310, 90, 60);
    image3.frame = CGRectMake(210, 310, 90, 60);
    
    UILabel *rules2 = [[UILabel alloc] init];
    [rules2 setText:@"is a set because: 1) colors all the different; 2) shapes all different; 3) numbers all the same (one); 4) shadings all the same (solid).\n\n Another example:"];
    rules2.lineBreakMode = UILineBreakModeWordWrap;
    rules2.numberOfLines = 0;
    rules2.font = rulesFont;
    rules2.textAlignment = UITextAlignmentCenter;
    rules2.frame = CGRectMake(10, 370, 300, 120);
    [rules2 setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *image4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.png"]];
    UIImageView *image5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"41.png"]];
    UIImageView *image6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"78.png"]];
    image4.frame = CGRectMake(20, 490, 90, 60);
    image5.frame = CGRectMake(115, 490, 90, 60);
    image6.frame = CGRectMake(210, 490, 90, 60);
    
    UILabel *rules3 = [[UILabel alloc] init];
    [rules3 setText:@"is a set because everything is different, for each feature.\n\n The following is not a set:"];
    rules3.lineBreakMode = UILineBreakModeWordWrap;
    rules3.numberOfLines = 0;
    rules3.font = rulesFont;
    rules3.textAlignment = UITextAlignmentCenter;
    rules3.frame = CGRectMake(10, 550, 300, 80);
    [rules3 setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *image7 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"5.png"]];
    UIImageView *image8 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"31.png"]];
    UIImageView *image9 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"30.png"]];
    image7.frame = CGRectMake(20, 630, 90, 60);
    image8.frame = CGRectMake(115, 630, 90, 60);
    image9.frame = CGRectMake(210, 630, 90, 60);
    
    UILabel *rules4 = [[UILabel alloc] init];
    [rules4 setText:@"because, although the rule works for shape, color and number, we have 2 cards of the same shading, and one of different shading. \n\n THE MAGIC RULE IS: IF TWO ARE, AND ONE IS NOT, THEN IT IS NOT A SET!\n\n The general goal of the game is to find the most number of SETs as fast as you can, and without making mistakes, until the cards are over. Enjoy!"];
    rules4.lineBreakMode = UILineBreakModeWordWrap;
    rules4.numberOfLines = 0;
    rules4.font = rulesFont;
    rules4.textAlignment = UITextAlignmentCenter;
    rules4.frame = CGRectMake(10, 690, 300, 230);
    [rules4 setBackgroundColor:[UIColor clearColor]];
    
    
    [self.scroll addSubview:rules1];
	[self.scroll addSubview:image1];
    [self.scroll addSubview:image2];
    [self.scroll addSubview:image3];
    [self.scroll addSubview:rules2];
    [self.scroll addSubview:image4];
    [self.scroll addSubview:image5];
    [self.scroll addSubview:image6];
    [self.scroll addSubview:rules3];
    [self.scroll addSubview:image7];
    [self.scroll addSubview:image8];
    [self.scroll addSubview:image9];
    [self.scroll addSubview:rules4];
    
    
    [self.scroll setContentSize:CGSizeMake(320, 930)];
	[self.scroll setScrollEnabled:YES];
    [self.scroll setCanCancelContentTouches:NO];
	self.scroll.clipsToBounds = YES;
	self.scroll.indicatorStyle = UIScrollViewIndicatorStyleWhite;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
