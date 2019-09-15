//
//  SetMatchingGameLogic.m
//  MatchDrawnCards
//
//  Created by Ofir Talmor on 11/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "SetMatchingGameLogic.h"
#import "SetCard.h"

@implementation SetMatchingGameLogic

@synthesize choosingPenalty;

@synthesize mismatchPenalty;

- (NSUInteger)mismatchPenalty {return 1;}
- (NSUInteger)choosingPenalty {return 0;}

- (int)match:(nonnull NSArray <SetCard *> *)cards {
    if([cards count] != 3) return 0;
    return ([self shapesMatch:cards] && [self colorsMatch:cards] && [self numbersMatch:cards] && [self shadingsMatch:cards]) ? 3 : 0;
}

-(BOOL)shapesMatch:(NSArray *)cards{
    SetCard *firstCard = cards[0];
    SetCard *secondCard = cards[1];
    SetCard *thirdCard = cards[2];
    BOOL equal = [thirdCard.shape isEqualToString:firstCard.shape] && [thirdCard.shape isEqualToString:secondCard.shape];
    BOOL dif = !([thirdCard.shape isEqualToString:firstCard.shape] || [thirdCard.shape isEqualToString:secondCard.shape] || [secondCard.shape isEqualToString:firstCard.shape]);
    return equal || dif;
}

-(BOOL)colorsMatch:(NSArray *)cards{
    SetCard *firstCard = cards[0];
    SetCard *secondCard = cards[1];
    SetCard *thirdCard = cards[2];
    BOOL equal = [thirdCard.color isEqualToString:firstCard.color] && [thirdCard.color isEqualToString:secondCard.color];
    BOOL dif = !([thirdCard.color isEqualToString:firstCard.color] || [thirdCard.color isEqualToString:secondCard.color] || [secondCard.color isEqualToString:firstCard.color]);
    return equal || dif;
}

-(BOOL)numbersMatch:(NSArray *)cards{
    SetCard *firstCard = cards[0];
    SetCard *secondCard = cards[1];
    SetCard *thirdCard = cards[2];
    BOOL equal = (thirdCard.number == firstCard.number) && (thirdCard.number == secondCard.number);
    BOOL dif = !((thirdCard.number ==  firstCard.number) || (thirdCard.number == secondCard.number) || (secondCard.number == firstCard.number));
    return equal || dif;
}

-(BOOL)shadingsMatch:(NSArray *)cards{
    SetCard *firstCard = cards[0];
    SetCard *secondCard = cards[1];
    SetCard *thirdCard = cards[2];
    BOOL equal = (thirdCard.shading == firstCard.shading) && (thirdCard.shading == secondCard.shading);
    BOOL dif = !((thirdCard.shading ==  firstCard.shading) || (thirdCard.shading == secondCard.shading) || (secondCard.shading == firstCard.shading));
    return equal || dif;
}

- (void)replaceMatchedCards:(NSMutableArray *)cards withDeck:(id <Deck>)deck{
    return nil; //TODO implement
}

@end
