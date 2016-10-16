//
//  BJDCard.h
//  Blackjack
//
//  Created by Nick Kuh on 02/07/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : int
{
    BJCardSuitClub = 0,
    BJCardSuitSpade,
    BJCardSuitDiamond,
    BJCardSuitHeart
}BJCardSuit;

@interface BJDCard : NSObject

@property (nonatomic) BJCardSuit suit;
@property (nonatomic) int digit;
@property (nonatomic) BOOL isFaceUp;

-(BOOL) isAnAce;
-(BOOL) isAFaceOrTenCard;
-(UIImage *)getCardImage;

+(NSMutableArray *) generateAPackOfCards;

@end
