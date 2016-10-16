//
//  BRNotificationTimeViewController.h
//  BirthdayReminder
//
//  Created by Nick Kuh on 05/07/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import "BRCoreViewController.h"

@interface BRNotificationTimeViewController : BRCoreViewController

@property (weak, nonatomic) IBOutlet UILabel *whatTimeLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
- (IBAction)didChangeTime:(id)sender;

@end
