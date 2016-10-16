//
//  BJDGameModel.m
//  Blackjack
//
//  Created by Nick Kuh on 02/07/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import "BJDGameModel.h"
#import "BJDCard.h"
#import "NSMutableArray+Shuffle.h"

@interface BJDGameModel ()

@property (nonatomic,strong) NSMutableArray *cards;
@property (nonatomic,strong) NSMutableArray *playerCards;
@property (nonatomic,strong) NSMutableArray *dealerCards;
@property (readwrite) BOOL didDealerWin;

@end

@implementation BJDGameModel

-(id) init
{
    self = [super init];
    if (self) {
        self.maxPlayerCards = 5;
        [self resetGame];
    }
    return self;
}

#pragma mark - Public Interface for our model

-(void) resetGame
{
    self.cards = [BJDCard generateAPackOfCards];
    [self.cards shuffle];
    
    self.playerCards = [NSMutableArray array];
    self.dealerCards = [NSMutableArray array];
    self.gameStage = BJGameStagePlayer;
    
    
}

-(BJDCard *) nextDealerCard
{
    BJDCard *card = [self nextCard];
    [self.dealerCards addObject:card];
    
    return card;
}

-(BJDCard *) nextPlayerCard
{
    BJDCard *card = [self nextCard];
    [self.playerCards addObject:card];
    
    return card;
}


-(BJDCard *) playerCardAtIndex:(int)index
{
    if (index < [self.playerCards count]) {
        return self.playerCards[index];
    }
    return nil;
}

-(BJDCard *) dealerCardAtIndex:(int)index
{
    if (index < [self.dealerCards count]) {
        return self.dealerCards[index];
    }
    return nil;
}


-(BJDCard *) lastDealerCard
{
    if ([self.dealerCards count] > 0) return [self.dealerCards lastObject];
    return nil;
}

-(BJDCard *) lastPlayerCard
{
    if ([self.playerCards count] > 0) return [self.playerCards lastObject];
    return nil;
}

-(void) updateGameStage
{
    if (self.gameStage == BJGameStagePlayer) {
        if ([self areCardsBust:self.playerCards]) {
            self.gameStage = BJGameStageGameOver;
            self.didDealerWin = YES;
            [self notifyGameDidEnd];
        }
        else if ([self.playerCards count] == self.maxPlayerCards) {
            self.gameStage = BJGameStageDealer;
        }
    }
    else if (self.gameStage == BJGameStageDealer) {
        //check if we're done now?
        if ([self areCardsBust:self.dealerCards]) {
            self.gameStage = BJGameStageGameOver;
            self.didDealerWin = NO;
            [self notifyGameDidEnd];
        }
        else if ([self.dealerCards count] == self.maxPlayerCards) {
            self.gameStage = BJGameStageGameOver;
            [self calculateWinner];
            [self notifyGameDidEnd];
        }
        else {
            //should the dealer stop, has he won?
            int dealerScore = [self calculateBestScore:self.dealerCards];
            if (dealerScore < 17) {
                //keep playing, dealer can't stand on less than 17
            }
            else {
                int playerScore = [self calculateBestScore:self.playerCards];
                if (playerScore > dealerScore) {
                    //dealer must play again as he's not equal or better to the player's score
                    //keep playing, dealer will play another card
                }
                else {
                    //dealer has equalled or beaten the player so the game is over
                    self.didDealerWin = YES;
                    self.gameStage = BJGameStageGameOver;
                    [self notifyGameDidEnd];
                }
            }
            
        }
    }
}


#pragma mark - Private Interface for our model

//slides a single card off the shuffled pack and returns the card
-(BJDCard *) nextCard
{
    BJDCard *card = self.cards[0];
    [self.cards removeObjectAtIndex:0];
    return card;
}


#pragma mark - Notification Dispatch

//dispatches an NSNotification via the NSNotificationCenter (and view controllers listening for this notification will receive and handle the notification
-(void) notifyGameDidEnd
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    //wrapping a Boolean into an NSNumber object using lierals syntax
    NSNumber *didDealerWin = @(self.didDealerWin);
    
    //creating a dictionary using lierals syntax
    NSDictionary *dict = @{@"didDealerWin": didDealerWin};
    
    [notificationCenter postNotificationName:BJNotificationGameDidEnd object:self userInfo:dict];
}

#pragma mark - Utility Black Jack Hand Logic

-(void) calculateWinner
{
    int dealerScore = [self calculateBestScore:self.dealerCards];
    int playerScore = [self calculateBestScore:self.playerCards];
    if (playerScore > dealerScore) {
        self.didDealerWin = NO;
    }
    else {
        self.didDealerWin = YES;
    }
}

-(BOOL) areCardsBust:(NSMutableArray *)cards
{
    BJDCard *card;
    int lowestScore = 0;
    int maxLoop = [cards count];
    for (int i=0;i<maxLoop;i++) {
        card = cards[i];
        if (card.isAnAce) {
            lowestScore += 1;
        }
        else if (card.isAFaceOrTenCard) {
            lowestScore += 10;
        }
        else {
            lowestScore += card.digit;
        }
    }
    if (lowestScore > 21) return YES;
    return NO;
}

-(int) calculateBestScore:(NSMutableArray *)cards
{
    if ([self areCardsBust:cards]) {
        return 0;
    }
    
    //We have a hand of 21 or less then...
    
    BJDCard *card;
    int highestScore = 0;
    int maxLoop = [cards count];
    for (int i=0;i<maxLoop;i++) {
        card = cards[i];
        if (card.isAnAce) {
            highestScore += 11;
        }
        else if (card.isAFaceOrTenCard) {
            highestScore += 10;
        }
        else {
            highestScore += card.digit;
        }
    }
    while (highestScore > 21) {
        highestScore -= 10;
    }
    return highestScore;
}


@end
