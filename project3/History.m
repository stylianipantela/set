//  History.m
//  project3
//
//  Created by Deborah Alves and Styliani Pantela.
//  Copyright (c) 2012 Harvard University. All rights reserved.
//

#import "History.h"

@implementation History 

@synthesize location = _location;

/* load the highscores location */
- (id)init
{
    if (self = [super init]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *libraryDirectory = [paths objectAtIndex:0];
        self.location = [libraryDirectory stringByAppendingString:@"/history.plist"];
    }
    return self;
}


/* store the score(time2complete) and the name of the user in a plist*/
- (void)store:(int)points time:(NSString *)time
{    
    // read the existing history.plist    
    NSArray *highScores = [[NSArray alloc] initWithContentsOfFile:self.location];
    
    // save the NSArray as a mutable array
    NSMutableArray *scores = [[NSMutableArray alloc] initWithArray:highScores];
    
    // create new array to hold details of the current score (score, wrongGuesses, word)    
    NSMutableArray *myArray = [[NSMutableArray alloc] initWithObjects: [NSNumber numberWithInt:(points)], time, nil];
    
    // add new array to scores array   
    [scores addObject:myArray];
    
    // sort the dictionary by score
    NSArray *sortedArray = [[NSArray alloc] init];
    sortedArray = [scores sortedArrayUsingComparator:^(id a, id b) {
        NSNumber *first = [a objectAtIndex:0];
        NSNumber *second = [b objectAtIndex:0];
        return [first compare:second];
    }];
    
    // remove all excess high scores (if more than 10 high scores, just keep the top 10)
    NSMutableArray *finalArray = [[NSMutableArray alloc] init];
    finalArray = [(NSArray *)sortedArray mutableCopy];
    if ([finalArray count] > 10) {
        [finalArray removeObjectAtIndex:0];
    }
    
    // save the new plist by overwriting the history.plist  
    [finalArray writeToFile:self.location atomically:YES];
}

/* retrieve high scores from plist */
- (NSArray*)retrieve
{
    NSArray *highScores = [[NSArray alloc] initWithContentsOfFile:self.location];
    return highScores;    
}

/* resets high scores - written for testing purposes */
- (void)reset
{
    // read the existing history.plist    
    NSArray *highScores = [[NSArray alloc] init];
    
    // save the new plist by overwriting the history.plist   
    [highScores writeToFile:self.location atomically:YES];
}

@end
