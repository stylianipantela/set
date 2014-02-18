//
//  uitest.m
//  project3
//
//  Created by Deborah Alves on 5/3/12.
//  Copyright (c) 2012 Harvard University. All rights reserved.
//

#import "uitest.h"
#import "MainViewController.h"

@implementation uitest

- (void) setUp {
    app_delegate = [[UIApplication sharedApplication] delegate];
    main_view_controller = app_delegate.mainViewController;
    main_view            = main_view_controller.view;
}

- (void) testSelect {
    // tests if selects cards
    [main_view_controller selectCard:[main_view viewWithTag:3]];
    [main_view_controller selectCard:[main_view viewWithTag:5]];
    STAssertTrue([main_view_controller.selectedButtons count] == 2, @"Part 1 failed.");
    
}

- (void) testDeselect {
    // tests if deselects a card
    [main_view_controller selectCard:[main_view viewWithTag:3]];
    [main_view_controller selectCard:[main_view viewWithTag:8]];
    [main_view_controller selectCard:[main_view viewWithTag:8]];
    STAssertTrue([main_view_controller.selectedButtons count] == 1, @"Part 2 failed.");
    
}

- (void) testAddCards {
    // tests if adds cards to the table
    [main_view_controller addCards:main_view_controller.addCardsButton];
    [main_view_controller addCards:main_view_controller.addCardsButton];
    STAssertTrue([main_view_controller.currentButtons count] == 18, @"Part 3 failed.");
    
    // tests if it does not pass 21
    [main_view_controller addCards:main_view_controller.addCardsButton];
    [main_view_controller addCards:main_view_controller.addCardsButton];
    [main_view_controller addCards:main_view_controller.addCardsButton];
    [main_view_controller addCards:main_view_controller.addCardsButton];

    STAssertTrue([main_view_controller.currentButtons count] == 21, @"Part 4 failed.");
    
    
}
@end
