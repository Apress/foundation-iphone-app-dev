//
//  BRSettingsViewController.h
//  BirthdayReminder
//
//  Created by Nick Kuh on 13/08/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BRSettingsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITableViewCell *tableCellDaysBefore;
@property (weak, nonatomic) IBOutlet UITableViewCell *tableCellNotificationTime;
- (IBAction)didClickDoneButton:(id)sender;

@end
