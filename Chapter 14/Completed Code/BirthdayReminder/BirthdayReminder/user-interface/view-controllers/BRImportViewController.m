//
//  BRImportViewController.m
//  BirthdayReminder
//
//  Created by Nick Kuh on 09/08/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import "BRImportViewController.h"
#import "BRBirthdayTableViewCell.h"
#import "BRDBirthdayImport.h"
#import "BRDModel.h"

@interface BRImportViewController ()

//Keeps track of selected rows
@property (nonatomic, strong) NSMutableDictionary *selectedIndexPathToBirthday;

@end

@implementation BRImportViewController
@synthesize importButton;
@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateImportButton];
}

-(NSMutableDictionary *) selectedIndexPathToBirthday
{
    if (_selectedIndexPathToBirthday == nil) {
        _selectedIndexPathToBirthday = [NSMutableDictionary dictionary];
    }
    return _selectedIndexPathToBirthday;
}

//Enables/Disables the import button if there are zero rows selected
- (void) updateImportButton
{
    self.importButton.enabled = [self.selectedIndexPathToBirthday count] > 0;
}

//Helper method to check whether a row is selected or not
-(BOOL) isSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    return self.selectedIndexPathToBirthday[indexPath] ? YES : NO;
}

//Refreshes the selection tick of a table cell
- (void)updateAccessoryForTableCell:(UITableViewCell *)tableCell atIndexPath:(NSIndexPath *)indexPath
{
    UIImageView *imageView;
    if ([self isSelectedAtIndexPath:indexPath]) {
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-import-selected.png"]];
    }
    else {
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-import-not-selected.png"]];
    }
    tableCell.accessoryView = imageView;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapImportButton:(id)sender {
    NSArray *birthdaysToImport = [self.selectedIndexPathToBirthday allValues];
    [[BRDModel sharedInstance] importBirthdays:birthdaysToImport];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapSelectAllButton:(id)sender {
    
    BRDBirthdayImport *birthdayImport;
    
    int maxLoop = [self.birthdays count];
    
    NSIndexPath *indexPath;
    
    for (int i=0;i<maxLoop;i++) {//loop through all the birthday import objects
        birthdayImport = self.birthdays[i];
        indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        //create the selection reference
        self.selectedIndexPathToBirthday[indexPath] = birthdayImport;
    }
    
    [self.tableView reloadData];
    [self updateImportButton];
}

- (IBAction)didTapSelectNoneButton:(id)sender {
    [self.selectedIndexPathToBirthday removeAllObjects];
    [self.tableView reloadData];
    [self updateImportButton];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.birthdays count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    BRDBirthdayImport *birthdayImport = self.birthdays[indexPath.row];
    
    BRBirthdayTableViewCell *brTableCell = (BRBirthdayTableViewCell *)cell;
    
    brTableCell.birthdayImport = birthdayImport;
    
    UIImage *backgroundImage = (indexPath.row == 0) ? [UIImage imageNamed:@"table-row-background.png"] : [UIImage imageNamed:@"table-row-icing-background.png"];
    brTableCell.backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
    
    [self updateAccessoryForTableCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BOOL isSelected = [self isSelectedAtIndexPath:indexPath];
    
    BRDBirthdayImport *birthdayImport = self.birthdays[indexPath.row];
    
    if (isSelected) {//already selected, so deselect
        [self.selectedIndexPathToBirthday removeObjectForKey:indexPath];
    }
    else {//not currently selected, so select
        [self.selectedIndexPathToBirthday setObject:birthdayImport forKey:indexPath];
    }
    
    //update the accessory view image
    [self updateAccessoryForTableCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
    
    //enable/disable the import button
    [self updateImportButton];
}


@end
