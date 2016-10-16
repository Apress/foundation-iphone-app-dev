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
    
    UIButton *button;
    
    int i;
    
    for (i=0;i<[buttonsToShow count];i++) {
        button = [buttonsToShow objectAtIndex:i];
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
    
}

- (IBAction)smsButtonTapped:(id)sender
{
    
}

- (IBAction)emailButtonTapped:(id)sender
{
    
}

- (IBAction)deleteButtonTapped:(id)sender
{
    
}

@end
