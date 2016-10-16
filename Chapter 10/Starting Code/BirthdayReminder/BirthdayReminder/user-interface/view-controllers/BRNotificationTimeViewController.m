//
//  BRNotificationTimeViewController.m
//  BirthdayReminder
//
//  Created by Nick Kuh on 05/07/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import "BRNotificationTimeViewController.h"
#import "BRStyleSheet.h"

@interface BRNotificationTimeViewController ()

@end

@implementation BRNotificationTimeViewController
@synthesize whatTimeLabel;
@synthesize timePicker;

-(void) viewDidLoad
{
    [super viewDidLoad];
    [BRStyleSheet styleLabel:self.whatTimeLabel withType:BRLabelTypeLarge];
}

- (IBAction)didChangeTime:(id)sender {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:self.timePicker.date];
    
    NSLog(@"Changed time to: %d:%d",components.hour,components.minute);
}

@end
