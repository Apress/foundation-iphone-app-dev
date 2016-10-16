//
//  BRImportViewController.h
//  BirthdayReminder
//
//  Created by Nick Kuh on 09/08/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import "BRCoreViewController.h"

@interface BRImportViewController : BRCoreViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *birthdays;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *importButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)didTapImportButton:(id)sender;
- (IBAction)didTapSelectAllButton:(id)sender;
- (IBAction)didTapSelectNoneButton:(id)sender;

@end
