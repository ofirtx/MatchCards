//
//  CardMatchingGame.m
//  MatchCards
//
//  Created by Ofir Talmor on 03/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "CardMatchingGame.h"

# define MISMATCH_PENALTY 2
#define MATCHING_BONUS 4
#define COST_TO_CHOSE 1

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, readwrite) NSMutableArray *chosenCards;
@property (nonatomic, readwrite) NSArray *lastMatched;
@property (nonatomic, readwrite) BOOL matchSuc;
@property (nonatomic, readwrite) int pointsGained;
@end

@implementation CardMatchingGame

- (NSMutableArray *)generateEmptyArray{
    return [[NSMutableArray alloc] init];
}

- (NSMutableArray *)chosenCards{
    if (!_chosenCards) _chosenCards = [self generateEmptyArray];
    return _chosenCards;
}

- (NSMutableArray *)cards{
    if (!_cards) _cards = [self generateEmptyArray];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self = [super init];
    
    if(self){
        if (count <= 1){
            return nil;
        }
        for (int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
        
        self.numToMatch = 2; //default number of cards to match
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index{
    return index < [self.cards count] ? self.cards[index] : nil;
}

-(void)chooseCardAtIndex2:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    if(!card.matched){
        if(card.chosen){
            card.chosen = NO;
            return;
        } else {
            for (Card * otherCard in self.cards){
                if (otherCard.chosen && !otherCard.matched){
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore){
                        self.score += matchScore * MATCHING_BONUS;
                        card.matched = YES;
                        otherCard.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
        }
        self.score -= COST_TO_CHOSE;
        card.chosen = YES;
    }
}

- (void)chooseCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    if(!card.matched){
        if(card.chosen){
            card.chosen = NO;
            [self.chosenCards removeObject:card];
            self.lastMatched = nil;
            return;
        } else {
            if([self.chosenCards count] == self.numToMatch - 1){
                int matchScore = [card match:self.chosenCards];
                [self.chosenCards addObject:card];
                if(matchScore){
                    self.matchSuc = YES;
                    self.pointsGained = matchScore * MATCHING_BONUS;
                    self.score += self.pointsGained;
                    for(Card * matchedCard in self.chosenCards){
                        matchedCard.matched = YES;
                    }
                    self.lastMatched = self.chosenCards;
                    self.chosenCards = [self generateEmptyArray];
                } else {
                    self.score -= MISMATCH_PENALTY;
                    self.pointsGained = -MISMATCH_PENALTY;
                    self.matchSuc = NO;
                    for(Card * matchedCard in self.chosenCards){
                        matchedCard.chosen = NO;
                    }
                    self.lastMatched = self.chosenCards;
                    self.chosenCards = [self generateEmptyArray];
                    [self.chosenCards addObject:card];
                }
            }
            else{
                [self.chosenCards addObject:card];
                self.lastMatched = nil;
            }
            card.chosen = YES;
        }
        self.score -= COST_TO_CHOSE;
        card.chosen = YES;
    }
}

@end
