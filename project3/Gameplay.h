//
//  Gameplay.h
//  project3
//
//  Created by Deborah Alves and Styliani Pantela.
//  Copyright (c) 2012 Harvard University. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Gameplay;

@protocol GameplayDelegate <NSObject>

- (NSMutableArray *)decimalToBase3:(int)card;
- (int)completeSet:(int)card1 with:(int)card2;
- (BOOL)checkSet:(int)card1 with:(int)card2 and:(int)card3;
- (BOOL)setsLeft:(NSArray *)cards;

@end

@interface Gameplay : NSObject <GameplayDelegate>

@property (weak, nonatomic) id <GameplayDelegate> delegate;

@end

