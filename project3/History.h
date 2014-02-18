//
//  History.h
//  project3
//
//  Created by Deborah Alves and Styliani Pantela.
//  Copyright (c) 2012 Harvard University. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol History <NSObject>

/* store the score(time2complete) and the name of the user in a plist*/
- (void)store:(int)points time:(NSString*)time;

/* retrieve high scores from plist */
- (NSArray*)retrieve;

/* empties the high score plist */
- (void)reset;

@end

@interface History : NSObject <History>

@property (nonatomic, strong) NSString *location;

@end