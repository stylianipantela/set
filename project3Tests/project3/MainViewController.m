//
//  MainViewController.m
//  project3
//
//  Created by Deborah Alves and Styliani Pantela.
//  Copyright (c) 2012 Harvard University. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

// properties related to the cards and its buttons
@synthesize selectedButtons = _selectedButtons;
@synthesize currentCards = _currentCards;
@synthesize currentButtons = _currentButtons;
@synthesize remainingCards = _remainingCards;

// instances of the game and their labels: points and cards left
@synthesize points = _points;
@synthesize cardsLeft = _cardsLeft;
@synthesize pointsLabel = _pointsLabel;
@synthesize cardsLeftLabel = _cardsLeftLabel;

// new game and add cards buttons
@synthesize gameButton = _gameButton;
@synthesize addCardsButton = _addCardsButton;

// properties related to the time elapsed
@synthesize endGame = _endGame;
@synthesize timeDisplay = _timeDisplay;
@synthesize updateTimer = _updateTimer;
@synthesize startTime = _startTime;
@synthesize timeElapsed = _timeElapsed;

// properties related to other files
@synthesize logic = _logic;
@synthesize history = _history;

// constant that define the points to get and lose
const int setPoints = 100;
const int wrongPoints = -100;
const int addPoints = -50;

- (void)viewDidLoad
{
       
    [self newGame];
    self.logic = [[Gameplay alloc] init];  
    self.history = [[History alloc] init];
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo:(id)sender
{    
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
}

- (void)newGame
{
    // remove old buttons from view
    int total = [self.currentButtons count];
    for (int i=0; i<total; i++) {
        UIButton *b = [self.currentButtons objectAtIndex:i];
        [b removeFromSuperview];
    }
    
    // initialize remainingCards
    NSMutableArray *remaining = [[NSMutableArray alloc] init];
    for (int i=0; i<81; i++) {
        [remaining addObject:[NSNumber numberWithInt:i]];
    }
    self.remainingCards = remaining;
    self.cardsLeft = 81;
    
    // initialize currentButtons
    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    for (int i=0; i<12; i++) {
        UIButton *b = [[UIButton alloc] init];
        [b setTag:i];
        [b addTarget:self action:@selector(selectCard:) forControlEvents:UIControlEventTouchUpInside];
        [buttons addObject:b];
        [self.view addSubview:b];
    }
    self.currentButtons = buttons;
    
    // initialize currentCards
    NSMutableArray *current = [[NSMutableArray alloc] init];
    for (int i=0; i<12; i++) {
        [current addObject:[self getRandom]];
    }
    self.currentCards = current;
    
    self.selectedButtons = [[NSMutableArray alloc] init];
    self.points = 0;
    
    [self updateCards];
    [self updateLabels];
        
    
    // start timer
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimeDisplay) userInfo:nil repeats:YES];
    self.startTime = [NSDate date];
    self.endGame = FALSE;
    
    return;
}


- (IBAction)selectCard:(id)sender
{
    UIButton *b = (UIButton *)sender;
    int selected = [self.selectedButtons count];
    
    // if 2 cards were already selected, check the sets and update the game
    if (selected == 2) {
        UIButton *b1 = [self.selectedButtons objectAtIndex:0];
        UIButton *b2 = [self.selectedButtons objectAtIndex:1];
        
        // checks if the cards selected was selected before. if so, deselects the card
        if (b1.tag == b.tag) {
            [b1 setHighlighted:NO];
            [b1 setImage:nil forState:UIControlStateNormal];
            [self.selectedButtons removeObjectAtIndex:0];
        }
        else if (b2.tag == b.tag) {
            [b2 setHighlighted:NO];
            [b2 setImage:nil forState:UIControlStateNormal];
            [self.selectedButtons removeObjectAtIndex:1];
            
        }
        // checks if the new card forms a set with the other two
        else {
            int card1 = [[self.currentCards objectAtIndex:b1.tag] intValue];
            int card2 = [[self.currentCards objectAtIndex:b2.tag] intValue];
            int card3 = [[self.currentCards objectAtIndex:b.tag] intValue];
            
            // if the 3 cards form a set, get the points and replace/remove the old cards
            if ([self.logic checkSet:card1 with:card2 and:card3] == YES) {
                self.points += setPoints;
                
                // remove cards from the table if there are more than 12 or 
                // there are no cards left
                if ((self.cardsLeft == 0)||([self.currentButtons count]> 12)) {
                    int total = [self.currentButtons count];
                    for (int i = 0; i < total; i++) {
                        UIButton *b = [self.currentButtons objectAtIndex:i];
                        [b removeFromSuperview];
                    }
                    
                    // set indexes for cards and buttons to be removed
                    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndex:b.tag];
                    [indexes addIndex:b1.tag];
                    [indexes addIndex:b2.tag];
                    [self.currentCards removeObjectsAtIndexes:indexes];
                    [self.currentButtons removeObjectsAtIndexes:indexes];
                    
                    // set new tags for buttons in their new positions
                    int newtotal = [self.currentButtons count];
                    for (int i = 0; i < newtotal; i++) {
                        UIButton *b = [self.currentButtons objectAtIndex:i];
                        [b setTag:i];
                    }
                    
                }
                // else, replaces the set by 3 other cards
                else {
                    NSNumber *c1 = [self getRandom];
                    NSNumber *c2 = [self getRandom];
                    NSNumber *c3 = [self getRandom];
                    [self.currentCards replaceObjectAtIndex:b1.tag withObject:c1];
                    [self.currentCards replaceObjectAtIndex:b2.tag withObject:c2];
                    [self.currentCards replaceObjectAtIndex:b.tag withObject:c3];
                }
                [self updateCards];
            }
            // if 3 cards do not form a set, decrease points
            else {
                self.points += wrongPoints;
            }
            
            // deselects all buttons
            [self.selectedButtons removeAllObjects];
            [b1 setImage:nil forState:UIControlStateNormal];
            [b2 setImage:nil forState:UIControlStateNormal];
            [b1 setHighlighted:NO];
            [b2 setHighlighted:NO];
            [self updateLabels];
            
        }
        
        
    }
    // if <= 1 cards already selected, just select the new one
    else {
        if (selected == 1) {
            UIButton *b1 = [self.selectedButtons objectAtIndex:0];
            // tests if the card was already selected 
            if (b1.tag == b.tag) {
                [b1 setHighlighted:NO];
                [b1 setImage:nil forState:UIControlStateNormal];
                [self.selectedButtons removeObjectAtIndex:0];
            }
            // if not, selects it
            else {
                [self.selectedButtons addObject:b];
                NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"shadow"]
                                                                 ofType:@"png"];
                UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
                [b setImage:image forState:UIControlStateNormal];
                [b setHighlighted:YES];
            }
        }
        else { 
            [self.selectedButtons addObject:b];
            NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"shadow"]
                                                             ofType:@"png"];
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
            [b setImage:image forState:UIControlStateNormal];
            [b setHighlighted:YES];
        }
    }
    
    // if there are no more cards left, checks if the game is over (no sets left)
    // if so, records the result in the history and stops the clock
    if (self.cardsLeft == 0) {
        if(![self.logic setsLeft:self.currentCards]) {
            int total = [self.currentButtons count];
            for (int i = 0; i < total; i++) {
                UIButton *b = [self.currentButtons objectAtIndex:i];
                [b setEnabled:NO];
            }
            // stop clock
            self.endGame = TRUE;
            
            // save points and stuff
            self.history = [[History alloc] init];
            [self.history store:self.points time:self.timeDisplay.text];
        }
    }
    

}


/* adds 3 cards to the current game */
- (IBAction)addCards:(id)sender {
    int current = [self.currentCards count];
    // checks if there are 3 cards to add
    if (self.cardsLeft >= 3) {
        // adds only there is less than 21 cards
        if (current < 21) {
            // take points off if there was a set before
            if ([self.logic setsLeft:self.currentCards]) {
                self.points += addPoints;
                [self updateLabels];
            }
            // adds the cards and update their positions
            for (int i=0; i<3; i++) {
                UIButton *b = [[UIButton alloc] init];
                [b setTag:(current+i)];
                [b addTarget:self action:@selector(selectCard:) forControlEvents:UIControlEventTouchUpInside];
                [self.currentCards addObject:[self getRandom]];
                [self.currentButtons addObject:b];
                [self.view addSubview:b];
            }  
            [self updateCards];
            [self updateLabels];
        }
    }
    return;
}

/* updates the display of the cards, based on buttonsCurrent and cardsCurrent */
- (void)updateCards {
    
    [self placeButtons];
    
    int buttonsCurrent = [self.currentButtons count];
    int cardsCurrent = [self.currentCards count];
    
    for (int i = 0; i < buttonsCurrent; i++) {
        if (i < cardsCurrent) {
            UIButton *b = [self.currentButtons objectAtIndex:i];
            int card = [[self.currentCards objectAtIndex:i] intValue];
            NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d", card] ofType:@"png"];
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
            [b setBackgroundImage:image forState:UIControlStateNormal];
            [self.view addSubview:b];
        }
        else {
            [self.currentButtons removeObjectAtIndex:cardsCurrent];
        }
    }
    
    return;
}


/* places the buttons in their place in the view, given the number of buttons */
- (void)placeButtons {
    
    int buttons = [self.currentButtons count];
    int firstx = 0;
    int firsty = 0;
    int dx = 0;
    int dy = 0;
    int w = 0;
    int h = 0;
    
    if (buttons <= 12) {
        firstx = 20;
        firsty = 110;
        dx = 95;
        dy = 70;
        w = 90;
        h = 60;
    }
    else if (buttons <= 15) {
        firstx = 20;
        firsty = 95;
        dx = 95;
        dy = 62;
        w = 90;
        h = 60;
    }
    else if (buttons <= 18) {
        firstx = 44;
        firsty = 90;
        dx = 80;
        dy = 52;
        w = 72;
        h = 48;
    }
    else {
        firstx = 15;
        firsty = 90;
        dx = 73;
        dy = 52;
        w = 72;
        h = 48;
    }
    
    if (buttons <= 18) {
        for (int i = 0; i < buttons; i++) {
            UIButton *b = [self.currentButtons objectAtIndex:i];
            b.frame = CGRectMake((firstx+(dx*(i%3))), (firsty+(dy*(i/3))), w, h);
        }
    }
    else {
        for (int i = 0; i < 18; i++) {
            UIButton *b = [self.currentButtons objectAtIndex:i];
            b.frame = CGRectMake((firstx+(dx*(i%3))), (firsty+(dy*(i/3))), w, h);
        }
        for (int j = 0; j < 3; j++) {
            UIButton *b = [self.currentButtons objectAtIndex:(18+j)];
            b.frame = CGRectMake(firstx+(dx*3), (firsty+(dy*j)), w, h);
        }
    }
}



/* update the display of the labels of cardsLeft and points */
- (void)updateLabels {
    
    [self.cardsLeftLabel setText:[NSString stringWithFormat:@"%d", self.cardsLeft]];
    [self.pointsLabel setText:[NSString stringWithFormat:@"%d", self.points]];
    return;
}

/* IBAction for new game button */
- (IBAction)newGameIB:(id)sender {
    [self newGame];
}



/* gets a random card from remainingCards, updating the remainingCards and cardsLeft.
   will raise an error if remainingCards is empty, so it should not be called in this case. */
- (NSNumber *)getRandom
{
    unsigned int random = arc4random();
    int arrIndex = random%(self.cardsLeft);
    NSNumber *card = [self.remainingCards objectAtIndex:arrIndex];
    [self.remainingCards removeObjectAtIndex:arrIndex];
    self.cardsLeft -= 1;
    return card;
}


/* constantly updates the time elapsed on the screen*/
- (void)updateTimeDisplay
{
    if (!self.endGame) {
        self.timeElapsed = -[self.startTime timeIntervalSinceNow];
        int seconds = floor (self.timeElapsed);
        int minutes = seconds/60;
        int hours = minutes/60;
        if (hours <= 99) {
            seconds = seconds % 60;
            minutes = minutes % 60;
            self.timeDisplay.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
            [self.timeDisplay setNeedsDisplay];
        }
        else {
            [self newGame];
        }
    }
}

#pragma mark - History View

/* returns from history view */
- (void)historyViewControllerDidFinish:(HistoryViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)updateCardsButt:(id)sender {
    [self updateCards];
}

/* shows the high score - history view */
- (IBAction)showHistory:(id)sender
{
    HistoryViewController *controller = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
       
    // creates a flipside, view with a navigation bar
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    // the navigation bar has a function done, just like any othe flipside view
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:controller action:@selector(done:)];
    
    controller.navigationItem.leftBarButtonItem = doneButton;
    
    [self presentModalViewController:navigationController animated:YES];
    
    
}

@end
