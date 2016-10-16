//
//  BRPostToFacebookWallViewController.m
//  BirthdayReminder
//
//  Created by Nick Kuh on 13/08/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import "BRPostToFacebookWallViewController.h"
#import "BRStyleSheet.h"
#import "UIImageView+RemoteFile.h"
#import "BRDModel.h"

@interface BRPostToFacebookWallViewController ()

@end

@implementation BRPostToFacebookWallViewController


-(void) viewDidLoad
{
    [super viewDidLoad];
    
    [BRStyleSheet styleRoundCorneredView:self.photoView];
    [BRStyleSheet styleTextView:self.textView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *facebookPicURL = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large",self.facebookID];
    
    [self.photoView setImageWithRemoteFileURL:facebookPicURL placeHolderImage:[UIImage imageNamed:@"icon-birthday-cake.png"]];
    self.textView.text = self.initialPostText;
    
    [self.textView becomeFirstResponder];
    
    [self updatePostButton];
}



- (IBAction)postToFacebook:(id)sender {
    [[BRDModel sharedInstance] postToFacebookWall:self.textView.text withFacebookID:self.facebookID];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) updatePostButton
{
    self.postButton.enabled = self.textView.text.length > 0;
}

#pragma mark UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    [self updatePostButton];
}

@end


