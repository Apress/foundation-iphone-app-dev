//
//  BRNotificationTimeViewController.m
//  BirthdayReminder
//
//  Created by Nick Kuh on 05/07/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import "BRNotificationTimeViewController.h"
#import "BRStyleSheet.h"
#import "BRDSettings.h"

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
    [BRDSettings sharedInstance].notificationHour = components.hour;
    [BRDSettings sharedInstance].notificationMinute = components.minute;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Retrieve the stored user settings for notification hour and minute
    int hour = [BRDSettings sharedInstance].notificationHour;
    int minute = [BRDSettings sharedInstance].notificationMinute;
    
    //Use NSDateComponents to create today's date with the hour/minute stored user notification settings
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:[NSDate date]];
    components.hour = hour;
    components.minute = minute;
    //Update the date/time picker to display the hour/minutes matching the stored user settings
    self.timePicker.date = [[NSCalendar currentCalendar] dateFromComponents:components];
}

@end
