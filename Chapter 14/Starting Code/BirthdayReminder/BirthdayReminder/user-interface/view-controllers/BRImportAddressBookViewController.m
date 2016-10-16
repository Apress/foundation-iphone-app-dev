//
//  BRImportAddressBookViewController.m
//  BirthdayReminder
//
//  Created by Nick Kuh on 09/08/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import "BRImportAddressBookViewController.h"
#import "BRDModel.h"

@interface BRImportAddressBookViewController ()

@end

@implementation BRImportAddressBookViewController

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAddressBookBirthdaysDidUpdate:) name:BRNotificationAddressBookBirthdaysDidUpdate object:[BRDModel sharedInstance]];
    [[BRDModel sharedInstance] fetchAddressBookBirthdays];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BRNotificationAddressBookBirthdaysDidUpdate object:[BRDModel sharedInstance]];
}

-(void)handleAddressBookBirthdaysDidUpdate:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    self.birthdays = [userInfo objectForKey:@"birthdays"];
    [self.tableView reloadData];
    
    if ([self.birthdays count] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Sorry, No birthdays found in your address book" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

@end
