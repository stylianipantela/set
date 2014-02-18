//
//  Gameplay.m
//  project3
//
//  Created by Deborah Alves and Styliani Pantela.
//  Copyright (c) 2012 Harvard University. All rights reserved.
//

#import "Gameplay.h"


@implementation Gameplay

@synthesize delegate = _delegate;


/* converts an int from decimal to base3 */
- (NSMutableArray *)decimalToBase3:(int)card 
{
    // remember the 4 characteristics of the card
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    
    for (int i=0; i<4; i++) {
        int remainder = card % 3 ;
        card = card / 3 ;
        [tmp addObject:[NSNumber numberWithInt:remainder]];
    }
    return tmp;
}

/* returns the 3rd card that would complete a set */
- (int)completeSet:(int)card1 with:(int)card2
{
    // array to remember the 4 characteristics of card1 and card2
    NSMutableArray *tmp1 = [[NSMutableArray alloc] init];
    NSMutableArray *tmp2 = [[NSMutableArray alloc] init];
    
    // convert from binary to base 3, so as to remember the characteristics
    tmp1 = [self decimalToBase3:card1];
    tmp2 = [self decimalToBase3:card2];
    
    int tmp = 0;
    
    // compute the third card that would comlete a set
    //we are always getting in the loop so it does not matter that we have initialized tmp to 0
    for (int i = 0; i < 4; i++) {
        int c1 = [[tmp1 objectAtIndex:i] intValue];
        int c2 = [[tmp2 objectAtIndex:i] intValue];
        if (c1 == c2)
            tmp += c1 * pow(3,i);
        else
            tmp += (3 - c1 - c2) * pow(3,i);
    }
    return tmp;
}

/* checks whether 3 cards form a set */
- (BOOL)checkSet:(int)card1 with:(int)card2 and:(int)card3
{
    int tmp = [self completeSet:card1 with:card2];
    if (tmp == card3) {
        NSLog(@"true");
        return TRUE;
    }
    else {
        NSLog(@"false");
        return FALSE;
    }
}

// setsLeft tests if there are any sets in the remaining cards and returns true if there are and false otherwise
- (BOOL)setsLeft:(NSMutableArray *)cards
{
    // count how many cards we have in the array of remaining cards
    int count = [cards count];
    
    // it's proven that if we have at least 21 cards we have a set
    if (count >= 21)
        return TRUE;
    
    for (int i = 0 ; i < count; i++) {
        // remember the base 3 characteristics of cardi
        int cardi = [[cards objectAtIndex:i] intValue];
        NSMutableArray *tmpi = [[NSMutableArray alloc] init];
        tmpi = [self decimalToBase3:cardi];
        
        // for every i, and j that comes after the i, compute the third card of that would create a set
        // if such a card exists in cards, return true
        
        for (int j = i + 1; j < count; j++) {
            // remember the base 3 characteristics of cardj
            NSMutableArray *tmpj = [[NSMutableArray alloc] init];
            int cardj = [[cards objectAtIndex:j] intValue];
            tmpj = [self decimalToBase3:cardj];
            int tmp = 0;
            
            // compute the third card that would comlete a set
            tmp = [self completeSet:cardi with:cardj];
            
            // check if that card exists in cards
            NSNumber *find = [NSNumber numberWithInt:tmp];
            for (int k = 0; k < count; k++) {
                if ([[cards objectAtIndex:k] intValue] == [find intValue] && k != i && k != j)
                    return TRUE;
            }
        }
    }
    return FALSE;
}

@end