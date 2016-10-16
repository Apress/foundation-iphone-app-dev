//
//  BRHomeViewController.m
//  BirthdayReminder
//
//  Created by Nick Kuh on 04/07/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import "BRHomeViewController.h"
#import "BRBirthdayDetailViewController.h"
#import "BRBirthdayEditViewController.h"
#import "BRDBirthday.h"
#import "BRDModel.h"
#import "BRBirthdayTableViewCell.h"
#import "BRStyleSheet.h"

@interface BRHomeViewController ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) BOOL hasFriends;

@end

@implementation BRHomeViewController
@synthesize tableView;
@synthesize importLabel;
@synthesize addressBookButton;
@synthesize facebookButton;
@synthesize importView;

-(void) viewDidLoad
{
    [super viewDidLoad];
    [BRStyleSheet styleLabel:self.importLabel withType:BRLabelTypeLarge];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    self.hasFriends = [self.fetchedResultsController.fetchedObjects count] > 0;
}

-(void) setHasFriends:(BOOL)hasFriends
{
    _hasFriends = hasFriends;
    self.importView.hidden = _hasFriends;
    self.tableView.hidden = !_hasFriends;
    
    if (self.navigationController.topViewController == self) {
        [self.navigationController setToolbarHidden:!_hasFriends animated:NO];
    }
}

#pragma mark Segues

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    
    if ([identifier isEqualToString:@"BirthdayDetail"]) {
        //First get the data
        NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
        BRDBirthday *birthday = [self.fetchedResultsController objectAtIndexPath:selectedIndexPath];
        
        BRBirthdayDetailViewController *birthdayDetailViewController = segue.destinationViewController;
        birthdayDetailViewController.birthday = birthday;
    }
    else if ([identifier isEqualToString:@"AddBirthday"]) {
        //Add a new birthday dictionary to the array of birthdays
        
        NSManagedObjectContext *context = [BRDModel sharedInstance].managedObjectContext;
        BRDBirthday *birthday = [NSEntityDescription insertNewObjectForEntityForName:@"BRDBirthday" inManagedObjectContext:context];
        [birthday updateWithDefaults];
        UINavigationController *navigationController = segue.destinationViewController;
        
        BRBirthdayEditViewController *birthdayEditViewController = (BRBirthdayEditViewController *) navigationController.topViewController;
        birthdayEditViewController.birthday = birthday;
    }
}

-(IBAction)unwindBackToHomeViewController:(UIStoryboardSegue *)segue
{
    NSLog(@"unwindBackToHomeViewController!");
}

#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    BRDBirthday *birthday = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    BRBirthdayTableViewCell *brTableCell = (BRBirthdayTableViewCell *)cell;
    brTableCell.birthday = birthday;
    
    UIImage *backgroundImage = (indexPath.row == 0) ? [UIImage imageNamed:@"table-row-background.png"] : [UIImage imageNamed:@"table-row-icing-background.png"];
    brTableCell.backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];

    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Fetched Results Controller to keep track of the Core Data BRDBirthday managed objects

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController == nil) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        //access the single managed object context through model singleton
        NSManagedObjectContext *context = [BRDModel sharedInstance].managedObjectContext;
        
        //fetch request requires an entity description - we're only interested in BRDBirthday managed objects
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"BRDBirthday" inManagedObjectContext:context];
        fetchRequest.entity = entity;
        
        //we'll order the BRDBirthday objects in name sort order for now
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nextBirthday" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        fetchRequest.sortDescriptors = sortDescriptors;
        
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
        self.fetchedResultsController.delegate = self;
        NSError *error = nil;
        if (![self.fetchedResultsController performFetch:&error]) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
    }
	
	return _fetchedResultsController;
}

#pragma mark NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    //The fetched results changed
}

- (IBAction)importFromAddressBookTapped:(id)sender {
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ImportAddressBook"];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

- (IBAction)importFromFacebookTapped:(id)sender {
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ImportFacebook"];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}
@end
