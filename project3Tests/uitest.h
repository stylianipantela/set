//
//  uitest.h
//  project3
//
//  Created by Deborah Alves on 5/3/12.
//  Copyright (c) 2012 Harvard University. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "AppDelegate.h"
#import "MainViewController.h"

@interface uitest : SenTestCase {
@private
    AppDelegate        *app_delegate;
    MainViewController *main_view_controller;
    UIView             *main_view;

}


@end
