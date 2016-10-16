//
//  NSMutableArray+Shuffle.m
//  Blackjack
//
//  Created by Nick Kuh on 02/07/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import "NSMutableArray+Shuffle.h"

@implementation NSMutableArray (Shuffle)

- (void)shuffle
{
    int count = [self count];
    
    NSMutableArray *dupeArr = [self mutableCopy];
    count = [dupeArr count];
    [self removeAllObjects];
    
    for (int i = 0; i < count; ++i) {
        // Select a random element between i and the end of the array to swap with.
        int nElements = count - i;
        int n = (arc4random() % nElements);
        [self addObject:dupeArr[n]];
        [dupeArr removeObjectAtIndex:n];
    }
    
}

@end
