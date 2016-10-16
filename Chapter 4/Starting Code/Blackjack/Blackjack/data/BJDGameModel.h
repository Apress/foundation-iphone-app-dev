//
//  BJDGameModel.h
//  Blackjack
//
//  Created by Nick Kuh on 02/07/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

typedef enum : int
{
    BJGameStagePlayer,
    BJGameStageDealer,
    BJGameStageGameOver
}BJGameStage;


#import <Foundation/Foundation.h>

@class BJDCard;

@interface BJDGameModel : NSObject

@property (nonatomic) BJGameStage gameStage;
@property (nonatomic) int maxPlayerCards;

-(void) resetGame;
-(void) updateGameStage;

-(BJDCard *) nextDealerCard;
-(BJDCard *) nextPlayerCard;

-(BJDCard *) playerCardAtIndex:(int)index;
-(BJDCard *) dealerCardAtIndex:(int)index;
-(BJDCard *) lastDealerCard;
-(BJDCard *) lastPlayerCard;

@end
