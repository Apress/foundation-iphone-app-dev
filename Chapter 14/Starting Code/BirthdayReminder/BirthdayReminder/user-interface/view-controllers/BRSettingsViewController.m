//
//  BRSettingsViewController.m
//  BirthdayReminder
//
//  Created by Nick Kuh on 13/08/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import "BRSettingsViewController.h"
#import "BRDSettings.h"
#import "BRStyleSheet.h"
#import "BRDModel.h"
#import "Appirater.h"
#import <Social/Social.h>

@interface BRSettingsViewController ()

@end

@implementation BRSettingsViewController

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tableCellNotificationTime.detailTextLabel.text = [[BRDSettings sharedInstance] titleForNotificationTime];
    self.tableCellDaysBefore.detailTextLabel.text =  [[BRDSettings sharedInstance] titleForDaysBefore:[BRDSettings sharedInstance].daysBefore];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app-background.png"]];
    self.tableView.backgroundView = backgroundView;
}

- (IBAction)didClickDoneButton:(id)sender {
    [[BRDModel sharedInstance] updateCachedBirthdays];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIView *) createSectionHeaderWithLabel:(NSString *)text
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40.f)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 15.f, 300.f, 20.f)];
    label.backgroundColor = [UIColor clearColor];
    [BRStyleSheet styleLabel:label withType:BRLabelTypeLarge];
    label.text = text;
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return section == 0 ? [self createSectionHeaderWithLabel:@"Reminders"] : [self createSectionHeaderWithLabel:@"Share the Love"];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //ignore if the user tapped the Day Before or Alert Time table cells
    if (indexPath.section == 0) return;
    
    NSString *text = @"Check out this iPhone App: Birthday Reminder";
    UIImage *image = [UIImage imageNamed:@"icon300x300.png"];
    NSURL *facebookPageLink = [NSURL URLWithString:@"http://www.facebook.com/apps/application.php?id=123956661050729"];
    NSURL *appStoreLink = [NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=489537509&mt=8"];
    
    SLComposeViewController *composeViewController;
    
    switch (indexPath.row) {
        case 0: //Add an App Store Review!
            [Appirater rateApp];
            break;
        case 1: //Share on Facebook
        {
            if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
            {
                NSLog(@"No Facebook Account available for user");
                return;
            }
            composeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [composeViewController addImage:image];
            [composeViewController setInitialText:text];
            [composeViewController addURL:appStoreLink];
            [self presentViewController:composeViewController animated:YES
                             completion:nil];
            break;
        }
        case 2: //Like on Facebook
            [[UIApplication sharedApplication] openURL:facebookPageLink];
            break;
        case 3://Share on Twitter
        {
            if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
            {
                NSLog(@"No Twitter Account available for user");
                return;
            }
            composeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [composeViewController addImage:image];
            [composeViewController setInitialText:text];
            [composeViewController addURL:appStoreLink];
            [self presentViewController:composeViewController animated:YES
                             completion:nil];
            break;
        }
        case 4://Email a Friend
        {
            if (![MFMailComposeViewController canSendMail]) {
                NSLog(@"Can't send email");
                return;
            }
            MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
            
            //When adding attachments we have to convert the image into it's raw NSData representation
            [mailViewController addAttachmentData:UIImagePNGRepresentation(image) mimeType:@"image/png" fileName:@"pic.png"];
            [mailViewController setSubject:@"Birthday Reminder"];
            
            //Combine the text and the app store link to create the email body
            NSString *textWithLink = [NSString stringWithFormat:@"%@\n\n%@",text,appStoreLink];
            
            [mailViewController setMessageBody:textWithLink isHTML:NO];
            mailViewController.mailComposeDelegate = self;
            [self presentViewController:mailViewController animated:YES
                             completion:nil];
            break;
        }
        case 5://SMS a Friend
        {
            if (![MFMessageComposeViewController canSendText]) {
                NSLog(@"Can't send messages");
                return;
            }
            MFMessageComposeViewController *messageViewController = [[MFMessageComposeViewController alloc] init];
            
            //Combine the text and the app store link to create the email body
            NSString *textWithLink = [NSString stringWithFormat:@"%@\n\n%@",text,appStoreLink];
            
            [messageViewController setBody:textWithLink];
            messageViewController.messageComposeDelegate = self;
            [self presentViewController:messageViewController animated:YES
                             completion:nil];
            break;
        }
        default:
            break;
    }
}

#pragma mark MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"mail composer cancelled");
			break;
		case MFMailComposeResultSaved:
			NSLog(@"mail composer saved");
			break;
		case MFMailComposeResultSent:
			NSLog(@"mail composer sent");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"mail composer failed");
			break;
	}
	
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result)
	{
		case MessageComposeResultCancelled:
			NSLog(@"message composer cancelled");
			break;
		case MessageComposeResultFailed:
			NSLog(@"message composer saved");
			break;
		case MessageComposeResultSent:
			NSLog(@"message composer sent");
			break;
	}
	
    [controller dismissViewControllerAnimated:YES completion:nil];

}


@end
