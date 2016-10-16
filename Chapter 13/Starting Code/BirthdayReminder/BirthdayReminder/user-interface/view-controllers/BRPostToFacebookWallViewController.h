//
//  BRPostToFacebookWallViewController.h
//  BirthdayReminder
//
//  Created by Nick Kuh on 13/08/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import "BRCoreViewController.h"

@interface BRPostToFacebookWallViewController : BRCoreViewController<UITextViewDelegate>

- (IBAction)postToFacebook:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *postButton;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) NSString *facebookID;
@property (strong, nonatomic) NSString *initialPostText;

@end
