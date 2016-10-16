//
//  BRBirthdayDetailViewController.m
//  BirthdayReminder
//
//  Created by Nick Kuh on 04/07/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import "BRBirthdayDetailViewController.h"
#import "BRBirthdayEditViewController.h"
#import "BRNotesEditViewController.h"
#import "BRDBirthday.h"

@interface BRBirthdayDetailViewController ()

@end

@implementation BRBirthdayDetailViewController
@synthesize photoView;

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
    self.title = self.birthday.name;
    UIImage *image = [UIImage imageWithData:self.birthday.imageData];
    if (image == nil) {
        //default to the birthday cake pic if there's no birthday image
        self.photoView.image = [UIImage imageNamed:@"icon-birthday-cake.png"];
    }
    else {
        self.photoView.image = image;
    }
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

#pragma mark Segues

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    
    if ([identifier isEqualToString:@"EditBirthday"]) {
        //Edit this birthday
        UINavigationController *navigationController = segue.destinationViewController;
        
        BRBirthdayEditViewController *birthdayEditViewController = (BRBirthdayEditViewController *) navigationController.topViewController;
        birthdayEditViewController.birthday = self.birthday;
    }
    else if ([identifier isEqualToString:@"EditNotes"]) {
        //Edit this birthday
        UINavigationController *navigationController = segue.destinationViewController;
        
        BRNotesEditViewController *birthdayNotesEditViewController = (BRNotesEditViewController *) navigationController.topViewController;
        birthdayNotesEditViewController.birthday = self.birthday;
    }
}

@end
