//
//  BRHomeViewController.h
//  BirthdayReminder
//
//  Created by Nick Kuh on 04/07/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRCoreViewController.h"

@interface BRHomeViewController : BRCoreViewController

-(IBAction)unwindBackToHomeViewController:(UIStoryboardSegue *)segue;

@end
