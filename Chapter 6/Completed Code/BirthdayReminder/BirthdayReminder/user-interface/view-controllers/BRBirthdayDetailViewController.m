//
//  BRBirthdayDetailViewController.m
//  BirthdayReminder
//
//  Created by Nick Kuh on 04/07/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import "BRBirthdayDetailViewController.h"

@interface BRBirthdayDetailViewController ()

@end

@implementation BRBirthdayDetailViewController

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"initWithCoder");
    }
    return self;
}

-(void) dealloc
{
    NSLog(@"dealloc");
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}

@end
