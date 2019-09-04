//
//  PlayingCard.m
//  MatchCards
//
//  Created by Ofir Talmor on 02/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits{
    return @[@"♠︎", @"♣︎", @"♥︎", @"♦︎"];
}

+ (NSArray *) rankStrings{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger) maxRank{
    return [[self rankStrings] count] -1;
}

- (void) setSuit:(NSString *)suit{
    if ([PlayingCard.validSuits containsObject:suit]){
        _suit = suit;
    }
}

- (NSString *) suit{
    return _suit ? _suit : @"?";
}

- (void) setRank:(NSUInteger)rank{
    if(rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

- (int)match:(NSArray *)otherCards{
    int score = 0;
    if ([otherCards count] == 1){
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank){
            score = 4;
        } else if ([self.suit isEqualToString:otherCard.suit]){
            score = 1;
        }
    } else {
        NSMutableArray *  newList = [[NSMutableArray alloc] init];
        for(Card *card in otherCards){
            score += [self match:@[card]];
            [newList addObject:card];
        }
        Card *firstCard = [newList firstObject];
        [newList removeObjectAtIndex:0];
        score += [firstCard match:newList];
    }
    return score;
}

@end
