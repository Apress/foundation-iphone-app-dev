//
//  BJDCard.m
//  Blackjack
//
//  Created by Nick Kuh on 02/07/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import "BJDCard.h"

@implementation BJDCard

-(BOOL) isAnAce
{
    if (self.digit == 1) return YES;
    return NO;
}

-(BOOL) isAFaceOrTenCard
{
    if (self.digit > 9) return YES;
    return NO;
}

-(UIImage *)getCardImage
{
    NSString *suit;
    
    switch (self.suit) {
        case BJCardSuitClub:
            suit = @"club";
            break;
        case BJCardSuitSpade:
            suit = @"spade";
            break;
        case BJCardSuitDiamond:
            suit = @"diamond";
            break;
        case BJCardSuitHeart:
            suit = @"heart";
            break;
            
        default:
            break;
    }
    
    
    NSString *filename = [NSString stringWithFormat:@"%@-%d.png",suit,self.digit];
    
    return [UIImage imageNamed:filename];
    
}

//Creates 52 instances of BJDCard representing each card in the pack
+(NSMutableArray *) generateAPackOfCards
{
    NSMutableArray *arr = [NSMutableArray array];
    
    BJDCard *card;
    
    int suit,digit;
    
    for (suit=0;suit<4;suit++) {
        for (digit=1;digit<=13;digit++)
        {
            card = [[BJDCard alloc] init];
            card.suit = suit;
            card.digit = digit;
            [arr addObject:card];
        }
    }
    
    return arr;
}

@end
