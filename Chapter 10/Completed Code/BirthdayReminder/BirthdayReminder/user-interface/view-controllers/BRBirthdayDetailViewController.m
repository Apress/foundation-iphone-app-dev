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
#import "BRStyleSheet.h"
#import "BRDModel.h"
#import <AddressBook/AddressBook.h>

@interface BRBirthdayDetailViewController ()

@end

@implementation BRBirthdayDetailViewController
@synthesize photoView;
@synthesize scrollView;
@synthesize birthdayLabel;
@synthesize remainingDaysLabel;
@synthesize remainingDaysSubTextLabel;
@synthesize notesTitleLabel;
@synthesize notesTextLabel;
@synthesize remainingDaysImageView;
@synthesize facebookButton;
@synthesize callButton;
@synthesize smsButton;
@synthesize emailButton;
@synthesize deleteButton;

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
    
    [BRStyleSheet styleRoundCorneredView:self.photoView];
    
    [BRStyleSheet styleLabel:self.birthdayLabel withType:BRLabelTypeLarge];
    [BRStyleSheet styleLabel:self.notesTitleLabel withType:BRLabelTypeLarge];
    [BRStyleSheet styleLabel:self.notesTextLabel withType:BRLabelTypeLarge];
    [BRStyleSheet styleLabel:self.remainingDaysLabel withType:BRLabelTypeDaysUntilBirthday];
    [BRStyleSheet styleLabel:self.remainingDaysSubTextLabel withType:BRLabelTypeDaysUntilBirthdaySubText];
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
    
    
    
    int days = self.birthday.remainingDaysUntilNextBirthday;
    
    if (days == 0) {
        //Birthday is today!
        self.remainingDaysLabel.text = self.remainingDaysSubTextLabel.text = @"";
        self.remainingDaysImageView.image = [UIImage imageNamed:@"icon-birthday-cake.png"];
    }
    else {
        self.remainingDaysLabel.text = [NSString stringWithFormat:@"%d",days];
        self.remainingDaysSubTextLabel.text = (days == 1) ? @"more day" : @"more days";
        self.remainingDaysImageView.image = [UIImage imageNamed:@"icon-days-remaining.png"];
    }
    
    self.birthdayLabel.text = self.birthday.birthdayTextToDisplay;
    
    NSString *notes = (self.birthday.notes && self.birthday.notes.length > 0) ? self.birthday.notes : @"";
    
    CGFloat cY = self.notesTextLabel.frame.origin.y;
    
    CGSize notesLabelSize = [notes sizeWithFont:self.notesTextLabel.font constrainedToSize:CGSizeMake(300.f, 300.f) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect frame = self.notesTextLabel.frame;
    frame.size.height = notesLabelSize.height;
    self.notesTextLabel.frame = frame;
    
    self.notesTextLabel.text = notes;
    
    cY += frame.size.height;
    cY += 10.f;
    
    CGFloat buttonGap = 6.f;
    
    cY += buttonGap * 2;
    
    NSMutableArray *buttonsToShow = [NSMutableArray arrayWithObjects:self.facebookButton,self.callButton, self.smsButton, self.emailButton, self.deleteButton, nil];
    
    NSMutableArray *buttonsToHide = [NSMutableArray array];
    
    if (self.birthday.facebookID == nil) {
        [buttonsToShow removeObject:self.facebookButton];
        [buttonsToHide addObject:self.facebookButton];
    }
    
    if ([self callLink] == nil) {
        [buttonsToShow removeObject:self.callButton];
        [buttonsToHide addObject:self.callButton];
    }
    
    if ([self smsLink] == nil) {
        [buttonsToShow removeObject:self.smsButton];
        [buttonsToHide addObject:self.smsButton];
    }
    
    if ([self emailLink] == nil) {
        [buttonsToShow removeObject:self.emailButton];
        [buttonsToHide addObject:self.emailButton];
    }
    
    UIButton *button;
    
    for (button in buttonsToHide) {
        button.hidden = YES;
    }
    
    int i;
    
    for (i=0;i<[buttonsToShow count];i++) {
        button = [buttonsToShow objectAtIndex:i];
        button.hidden = NO;
        frame = button.frame;
        frame.origin.y = cY;
        button.frame = frame;
        cY += button.frame.size.height + buttonGap;
    }
    
    self.scrollView.contentSize = CGSizeMake(320, cY);

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


#pragma mark Button Actions

- (IBAction)facebookButtonTapped:(id)sender
{
    
}

- (IBAction)callButtonTapped:(id)sender
{
    NSString *link = [self callLink];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
}

- (IBAction)smsButtonTapped:(id)sender
{
    NSString *link = [self smsLink];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
}

- (IBAction)emailButtonTapped:(id)sender
{
    NSString *link = [self emailLink];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
}

- (IBAction)deleteButtonTapped:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:[NSString stringWithFormat:@"Delete %@",self.birthday.name] otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}

#pragma mark Address Book contact helper methods

-(NSString *)telephoneNumber
{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
    ABRecordRef record =  ABAddressBookGetPersonWithRecordID (addressBook,(ABRecordID)[self.birthday.addressBookID intValue]);
    
    ABMultiValueRef multi = ABRecordCopyValue(record, kABPersonPhoneProperty);
    
    NSString *telephone = nil;
    
    if (ABMultiValueGetCount(multi) > 0) {
        telephone = (__bridge_transfer NSString*)ABMultiValueCopyValueAtIndex(multi, 0);
        telephone = [telephone stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    CFRelease(multi);
    CFRelease(addressBook);
    
    return telephone;
}

-(NSString *)callLink
{
    if (!self.birthday.addressBookID || [self.birthday.addressBookID intValue]==0) return nil;
    NSString *telephoneNumber = [self telephoneNumber];
    if (!telephoneNumber) return nil;
    
    NSString *callLink = [NSString stringWithFormat:@"tel:%@",telephoneNumber];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:callLink]]) return callLink;
    
    return nil;
}

-(NSString *)smsLink
{
    if (!self.birthday.addressBookID || [self.birthday.addressBookID intValue]==0) return nil;
    NSString *telephoneNumber = [self telephoneNumber];
    if (!telephoneNumber) return nil;
    
    NSString *smsLink = [NSString stringWithFormat:@"sms:%@",telephoneNumber];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:smsLink]]) return smsLink;
    
    return nil;
}

-(NSString *)emailLink
{
    if (!self.birthday.addressBookID || [self.birthday.addressBookID intValue]==0) return nil;
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
    ABRecordRef record =  ABAddressBookGetPersonWithRecordID (addressBook,(ABRecordID)[self.birthday.addressBookID intValue]);
    
    ABMultiValueRef multi = ABRecordCopyValue(record, kABPersonEmailProperty);
    
    NSString *email = nil;
    if (ABMultiValueGetCount(multi) > 0) {//check if the contact has 1 or more emails assigned
         email = (__bridge_transfer NSString*)ABMultiValueCopyValueAtIndex(multi, 0);
    }
    CFRelease(multi);
    CFRelease(addressBook);
    
    if (email) {
        NSString *emailLink = [NSString stringWithFormat:@"mailto:%@",email];
        //we can pre-populate the email subject with the words Happy Birthday
        emailLink = [emailLink stringByAppendingString:@"?subject=Happy%20Birthday"];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:emailLink]]) return emailLink;
    }

    
    return nil;
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //check whether the user cancelled the delete instruction via the action sheet cancel button
    if (buttonIndex == actionSheet.cancelButtonIndex) return;
    
    //grab a reference to the Core Data managed object context
    NSManagedObjectContext *context = [BRDModel sharedInstance].managedObjectContext;
    //delete this birthday entity from the managed object context
    [context deleteObject:self.birthday];
    //save our delete change to the persistent Core Data store
    [[BRDModel sharedInstance] saveChanges];
    
    //pop this view controller off the stack and slide back to the home screen
    [self.navigationController popViewControllerAnimated:YES];
}

@end
