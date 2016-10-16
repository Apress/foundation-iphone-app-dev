//
//  BRNotificationTimeViewController.m
//  BirthdayReminder
//
//  Created by Nick Kuh on 05/07/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import "BRNotificationTimeViewController.h"

@interface BRNotificationTimeViewController ()

@end

@implementation BRNotificationTimeViewController
@synthesize whatTimeLabel;
@synthesize timePicker;

- (IBAction)didChangeTime:(id)sender {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:self.timePicker.date];
    
    NSLog(@"Changed time to: %d:%d",components.hour,components.minute);
}

@end
