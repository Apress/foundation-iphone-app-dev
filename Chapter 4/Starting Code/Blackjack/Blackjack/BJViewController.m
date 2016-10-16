//
//  BJViewController.m
//  Blackjack
//
//  Created by Nick Kuh on 02/07/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import "BJViewController.h"

@interface BJViewController ()

@end

@implementation BJViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

/*
#pragma mark - Automated Dealer Play

-(void) showSecondDealerCard
{
    BJDCard *card = [self.gameModel lastDealerCard];
    card.isFaceUp = YES;
    [self renderCards];
    [self.gameModel updateGameStage];
    if (self.gameModel.gameStage != BJGameStageGameOver) {
        [self performSelector:@selector(showNextDealerCard) withObject:nil afterDelay:0.8];
    }
    
}

-(void) showNextDealerCard
{
    //next card
    BJDCard *card = [self.gameModel nextDealerCard];
    card.isFaceUp = YES;
    [self renderCards];
    [self.gameModel updateGameStage];
    if (self.gameModel.gameStage != BJGameStageGameOver) {
        [self performSelector:@selector(showNextDealerCard) withObject:nil afterDelay:0.8];
    }
}

- (void)playDealerTurn {
    self.standButton.enabled = self.hitButton.enabled = NO;
    [self performSelector:@selector(showSecondDealerCard) withObject:nil afterDelay:0.8];
}
 
*/

@end
