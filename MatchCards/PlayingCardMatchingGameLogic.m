//
//  PlayingCardMatchingGameLogic.m
//  MatchDrawnCards
//
//  Created by Ofir Talmor on 11/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "PlayingCardMatchingGameLogic.h"
#import "PlayingCard.h"

@implementation PlayingCardMatchingGameLogic

@synthesize choosingPenalty;

@synthesize mismatchPenalty;

- (NSUInteger)mismatchPenalty{return 1;}
- (NSUInteger)choosingPenalty{return 1;}

- (int)match:(NSArray <PlayingCard *>*)cards{
    int score = 0;
    if ([cards count] == 2){
        PlayingCard *firstCard = cards[0];
        PlayingCard *secondCard = cards[1];
        if (firstCard.rank == secondCard.rank){
            score = 4;
        } else if ([firstCard.suit isEqualToString:secondCard.suit]){
            score = 1;
        }
    } else {
        NSMutableArray *cardsWithoutFirst = [cards copy];
        PlayingCard *firstCard = [cardsWithoutFirst firstObject];
        [cardsWithoutFirst removeObjectAtIndex:0];
        
        for(PlayingCard *card in cardsWithoutFirst){
            score += [self match:@[firstCard, card]];
        }
        score += [self match:cardsWithoutFirst];
    }
    return score;
}

- (void)replaceMatchedCards:(NSMutableArray *)cards withDeck:(id <Deck>)deck{
    //TODO implement
}

- (NSUInteger)numberOfCardsToAdd{return 1;}

@end
