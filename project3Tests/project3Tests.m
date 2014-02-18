//
//  project3Tests.m
//  project3Tests
//
//  Created by Styliani Pantela.
//  Copyright (c) 2012 Harvard University. All rights reserved.
//

#import "project3Tests.h"
#import "Gameplay.h"
#import "History.h"

@interface project3Tests ()

// private properties
@property (strong, nonatomic) id<GameplayDelegate> gameplay;
@property (strong, nonatomic) id<History> history;

@end


@implementation project3Tests

@synthesize gameplay = _gameplay;
@synthesize history = _history;

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    self.gameplay = [[Gameplay alloc] init];
    STAssertNotNil(self.gameplay, @"Cannot create Gameplay instance");
    self.history = [[History alloc] init];
    STAssertNotNil(self.history, @"Cannot create History instance");
    
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testDecimalToBase3
{
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    tmp = [self.gameplay decimalToBase3:34];
    NSMutableArray *correct = [[NSMutableArray alloc] init];
    [correct addObject:[NSNumber numberWithInt:1]];
    [correct addObject:[NSNumber numberWithInt:2]];
    [correct addObject:[NSNumber numberWithInt:0]];
    [correct addObject:[NSNumber numberWithInt:1]];
    
    STAssertTrue([tmp count] != 3, @"Count is not 3 in Decimal");
    
    for (int i = 0; i < 4; i++)
        STAssertTrue([[tmp objectAtIndex:i] isEqualToNumber:[correct objectAtIndex:i]], @"Decimal transformation not equal");
}

- (void)testCompleteSet
{
    //1,2 completed by 0
    int card3 = [self.gameplay completeSet:1 with:2];
    STAssertTrue(card3 == 0, @"Complement of 1 and 2 should be 0");
    //51 and 15 complement 60
    card3 = [self.gameplay completeSet:28 with:58];
    STAssertTrue(card3 == 7, @"Complement of 28 and 58 is 7"); 
}

- (void)testCheckSet
{
    STAssertTrue([self.gameplay checkSet:28 with:58 and:7], @"28, 58 and 7 form a complete set");
    STAssertTrue(![self.gameplay checkSet:28 with:58 and:6],@"28, 58 and 6 do not form a complete set");
}

- (void)testSetsLeft
{
    //NSArray [- (BOOL)setsLeft:(NSArray *)cards
    NSMutableArray *remaining = [[NSMutableArray alloc] init];
    [remaining addObject:[NSNumber numberWithInt:28]];
    [remaining addObject:[NSNumber numberWithInt:58]];
    [remaining addObject:[NSNumber numberWithInt:6]];
    NSArray *cards1 = [remaining copy];
    STAssertTrue(![self.gameplay setsLeft:cards1], @"28,58,6 does not have a set");
    [remaining addObject:[NSNumber numberWithInt:7]];
    NSArray *cards2 = [remaining copy];
    STAssertTrue([self.gameplay setsLeft:cards2], @"28,58,6,7 has a set");
}

/* tests the storage function */
- (void)testStoreAndRetrieve
{
    [self.history reset];
    [self.history store:9000 time:@"99:99:99"];
    [self.history store:1100 time:@"00:00:00"];
    [self.history store:1000 time:@"12:12:12"];
    [self.history store:1200 time:@"11:11:11"];
    [self.history store:1300 time:@"22:22:22"];
    [self.history store:1400 time:@"33:33:33"];
    [self.history store:1500 time:@"44:44:44"];
    [self.history store:1600 time:@"55:55:55"];
    [self.history store:1700 time:@"66:66:66"];
    [self.history store:1800 time:@"77:77:77"];
    [self.history store:1900 time:@"88:88:88"];
    
    NSArray *highScores = [self.history retrieve];
    
    // iterate over values in the scores array
    int count = [highScores count];
    // count is still 10, although we added 11 objects
    if (count == 10) {
        NSArray *tmp1 = [highScores objectAtIndex:9];
        STAssertTrue([tmp1 count] == 2, @"tmp1 does not contain 2 elements");
        NSString *str1 = [tmp1 objectAtIndex:1];
        
        NSArray *tmp2 = [highScores objectAtIndex:8];
        STAssertTrue([tmp2 count] == 2, @"tmp2 does not contain 2 elements");
        NSString *str2 = [tmp2 objectAtIndex:1];
        
        STAssertTrue([str1 isEqualToString:@"99:99:99"], @"str1 correct time");
        STAssertTrue([str2 isEqualToString:@"88:88:88"], @"str2 correct time");
    }
    for (int i = (count - 1) ; i >= 0; i--) {    
        NSArray *tmp = [highScores objectAtIndex:i];
        STAssertTrue([tmp count] == 2, @"tmp does not contain 2 elements");
        NSString *tmpStr = [tmp objectAtIndex:1];
        STAssertTrue(![tmpStr isEqualToString:@"12:12:12"], @"tmpStr is 12:12:12");
    }
    STAssertTrue(count == 10, @"Count was not 10");
}

@end