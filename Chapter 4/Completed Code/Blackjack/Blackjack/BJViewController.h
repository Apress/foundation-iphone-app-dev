//
//  BJViewController.h
//  Blackjack
//
//  Created by Nick Kuh on 02/07/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BJViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *dealerCard1;
@property (weak, nonatomic) IBOutlet UIImageView *dealerCard2;
@property (weak, nonatomic) IBOutlet UIImageView *dealerCard3;
@property (weak, nonatomic) IBOutlet UIImageView *dealerCard4;
@property (weak, nonatomic) IBOutlet UIImageView *dealerCard5;
@property (weak, nonatomic) IBOutlet UIImageView *playerCard1;
@property (weak, nonatomic) IBOutlet UIImageView *playerCard2;
@property (weak, nonatomic) IBOutlet UIImageView *playerCard3;
@property (weak, nonatomic) IBOutlet UIImageView *playerCard4;
@property (weak, nonatomic) IBOutlet UIImageView *playerCard5;

@property (weak, nonatomic) IBOutlet UIButton *standButton;
@property (weak, nonatomic) IBOutlet UIButton *hitButton;

- (IBAction)didTapStandButton:(id)sender;
- (IBAction)didTapHitButton:(id)sender;

@end
