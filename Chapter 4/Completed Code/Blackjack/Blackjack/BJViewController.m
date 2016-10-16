//
//  BJViewController.m
//  Blackjack
//
//  Created by Nick Kuh on 02/07/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import "BJViewController.h"
#import "BJDGameModel.h"
#import "BJDCard.h"

@interface BJViewController ()

@property (nonatomic,strong) NSArray *dealerCardViews;
@property (nonatomic,strong) NSArray *playerCardViews;
@property (nonatomic,strong) BJDGameModel *gameModel;

@end

@implementation BJViewController

@synthesize dealerCard1;
@synthesize dealerCard2;
@synthesize dealerCard3;
@synthesize dealerCard4;
@synthesize dealerCard5;
@synthesize playerCard1;
@synthesize playerCard2;
@synthesize playerCard3;
@synthesize playerCard4;
@synthesize playerCard5;
@synthesize standButton;
@synthesize hitButton;

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.gameModel = [[BJDGameModel alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotificationGameDidEnd:) name:BJNotificationGameDidEnd object:self.gameModel];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)renderCards
{
    int maxCard = self.gameModel.maxPlayerCards;
    
    BJDCard *dealerCard;
    BJDCard *playerCard;
    UIImageView *dealerCardView;
    UIImageView *playerCardView;
    
    for (int i=0; i<maxCard; i++) {
        dealerCardView = self.dealerCardViews[i];
        playerCardView = self.playerCardViews[i];
        
        dealerCard = [self.gameModel dealerCardAtIndex:i];
        playerCard = [self.gameModel playerCardAtIndex:i];
        
        dealerCardView.hidden = (dealerCard == nil);
        if (dealerCard && dealerCard.isFaceUp) {
            dealerCardView.image = [dealerCard getCardImage];
        }
        else {
            dealerCardView.image = [UIImage imageNamed:@"card-back.png"];
        }
        
        playerCardView.hidden = (playerCard == nil);
        if (playerCard && playerCard.isFaceUp) {
            playerCardView.image = [playerCard getCardImage];
        }
        else {
            playerCardView.image = [UIImage imageNamed:@"card-back.png"];
        }
    }
}

- (void)restartGame
{

    [self.gameModel resetGame];
    BJDCard *card;
    
    card = [self.gameModel nextPlayerCard];
    card.isFaceUp = YES;
    card = [self.gameModel nextDealerCard];
    card.isFaceUp = YES;
    
    card = [self.gameModel nextPlayerCard];
    card.isFaceUp = YES;
    
    [self.gameModel nextDealerCard];
    
    [self renderCards];
    
    self.standButton.enabled = self.hitButton.enabled = YES;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dealerCardViews = @[self.dealerCard1,self.dealerCard2,self.dealerCard3,self.dealerCard4,self.dealerCard5];
    self.playerCardViews = @[self.playerCard1,self.playerCard2,self.playerCard3,self.playerCard4,self.playerCard5];
}

- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    self.dealerCardViews = nil;
    self.playerCardViews = nil;    
    
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self restartGame];
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

- (NSUInteger)supportedInterfaceOrientations
{
     // We're not going to support multiple device orientation for this game
    return UIInterfaceOrientationMaskPortrait;
}

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



#pragma mark - Button Actions

- (IBAction)didTapStandButton:(id)sender {
    self.gameModel.gameStage = BJGameStageDealer;
    [self playDealerTurn];
}

- (IBAction)didTapHitButton:(id)sender {
    BJDCard *card = [self.gameModel nextPlayerCard];
    card.isFaceUp = YES;
    [self renderCards];
    
    [self.gameModel updateGameStage];
    if (self.gameModel.gameStage == BJGameStageDealer) {
        [self playDealerTurn];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self restartGame];
}

#pragma mark - NotificationCenter Notifications

-(void) handleNotificationGameDidEnd:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    NSNumber *num = userInfo[@"didDealerWin"];
    
    NSString *message = [num boolValue] ? @"Dealer won!" : @"You won!";
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"Play Again", nil];
    [alert show];
}






@end
