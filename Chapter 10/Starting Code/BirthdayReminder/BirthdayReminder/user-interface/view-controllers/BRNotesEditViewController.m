//
//  BRNotesEditViewController.m
//  BirthdayReminder
//
//  Created by Nick Kuh on 05/07/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import "BRNotesEditViewController.h"
#import "BRDModel.h"
#import "BRDBirthday.h"
#import "BRStyleSheet.h"

@interface BRNotesEditViewController ()

@end

@implementation BRNotesEditViewController
@synthesize saveButton;
@synthesize textView;

-(void) viewDidLoad
{
    [super viewDidLoad];
    [BRStyleSheet styleTextView:self.textView];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.textView.text = self.birthday.notes;
    [self.textView becomeFirstResponder];
}

- (IBAction)cancelAndDismiss:(id)sender {
    [[BRDModel sharedInstance] cancelChanges];
    [super cancelAndDismiss:sender];
}

- (IBAction)saveAndDismiss:(id)sender
{
    [[BRDModel sharedInstance] saveChanges];
    [super saveAndDismiss:sender];
}

#pragma mark UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    self.birthday.notes = self.textView.text;
}



@end
