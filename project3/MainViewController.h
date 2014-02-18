//
//  MainViewController.h
//  project3
//
//  Created by Deborah Alves and Styliani Pantela.
//  Copyright (c) 2012 Harvard University. All rights reserved.
//

#import "FlipsideViewController.h"
#import "HistoryViewController.h"
#import "Gameplay.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, HistoryViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *selectedButtons;
@property (nonatomic, strong) NSMutableArray *currentCards;
@property (nonatomic, strong) NSMutableArray *currentButtons;
@property (nonatomic, strong) NSMutableArray *remainingCards;

@property (nonatomic, assign) int points;
@property (nonatomic, assign) int cardsLeft;

@property (nonatomic, weak) IBOutlet UILabel *pointsLabel;
@property (nonatomic, weak) IBOutlet UILabel *cardsLeftLabel;
@property (nonatomic, weak) IBOutlet UIButton *gameButton;
@property (nonatomic, weak) IBOutlet UIButton *addCardsButton;

// time display properties
@property (nonatomic, assign) BOOL endGame;
@property (nonatomic, weak) IBOutlet UILabel *timeDisplay;
@property (nonatomic, strong) NSTimer *updateTimer;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, assign) NSTimeInterval timeElapsed;

@property (strong, nonatomic) id<GameplayDelegate> logic;
@property (nonatomic, strong) History *history;


- (IBAction)showInfo:(id)sender;
- (IBAction)showHistory:(id)sender;
- (IBAction)addCards:(id)sender;
- (IBAction)newGameIB:(id)sender;


- (IBAction)updateCardsButt:(id)sender;


- (IBAction)selectCard:(id)sender;

- (void)newGame;

- (void)updateTimeDisplay;

@end
