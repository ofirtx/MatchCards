//
//  CardMatchingGame.m
//  MatchCards
//
//  Created by Ofir Talmor on 03/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "CardMatchingGame.h"
#import "MatchingGameLogic.h"

# define MISMATCH_PENALTY 2
#define MATCHING_BONUS 4
#define COST_TO_CHOSE 1

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, readwrite) NSMutableArray *chosenCards;
@property (nonatomic, readwrite) NSArray *lastMatched;
@property (nonatomic, readwrite) BOOL matchSuc;
@property (nonatomic, readwrite) NSInteger pointsGained;
@property (nonatomic) id <Deck> deck;
@property (nonatomic) id <MatchingGameLogic> logic;

@end

@implementation CardMatchingGame

- (NSMutableArray *)generateEmptyArray{
    return [[NSMutableArray alloc] init];
}

- (NSMutableArray *)cards{
    if (!_cards) _cards = [self generateEmptyArray];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(id <Deck>)deck usingLogic:(id <MatchingGameLogic>)logic matchingNumber:(NSUInteger)number{
    self = [super init];
    
    if(self){
        self.deck = deck;
        self.logic = logic;
        if (count <= 1){
            return nil;
        }
        for (int i = 0; i < count; i++){
            id <Card> card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
        
        self.numToMatch = number; //default number of cards to match
    }
    
    return self;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(id <Deck>)deck{
    self = [super init];
    
    if(self){
        if (count <= 1){
            return nil;
        }
        for (int i = 0; i < count; i++){
            id <Card> card = [deck drawRandomCard];
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

- (id <Card>)cardAtIndex:(NSUInteger)index{
    return index < [self.cards count] ? self.cards[index] : nil;
}

-(void)unChooseCard:(id <Card>)card{
    card.chosen = NO;
    [self.chosenCards removeObject:card];
    self.lastMatched = nil;
}

-(void)updateGameAfterAMatch{
    self.matchSuc = YES;
    self.score += self.pointsGained;
    for(id <Card> matchedCard in self.chosenCards){
        matchedCard.matched = YES;
    }
    self.lastMatched = self.chosenCards;
    self.chosenCards = [[NSMutableArray alloc] init];
}

- (NSMutableArray *)chosenCards{
    if (!_chosenCards) _chosenCards = [[NSMutableArray alloc] init];
    return _chosenCards;
}

-(void)updateGameAfterMismatch:(id <Card>)card{
    self.score -= self.logic.mismatchPenalty;
    self.pointsGained = -self.logic.mismatchPenalty;
    self.matchSuc = NO;
    for(id <Card> matchedCard in self.chosenCards){
        matchedCard.chosen = NO;
    }
    self.lastMatched = self.chosenCards;
    self.chosenCards = [[NSMutableArray alloc] init];
    [self.chosenCards addObject:card];
}

- (void)tryToMatch:(id <Card>)card{
    [self.chosenCards addObject:card];
    int matchScore = [self.logic match:self.chosenCards];
    if(matchScore){
        self.pointsGained = matchScore;
        [self updateGameAfterAMatch];
    }
    else{
        [self updateGameAfterMismatch:card];
    }
}

- (void)chooseCardAtIndex:(NSUInteger)index{
    id <Card> card = [self cardAtIndex:index];
    if(!card.matched){
        if(card.chosen){
            [self unChooseCard:card];
            return;
        } else {
            if([self.chosenCards count] == self.numToMatch - 1){
                [self tryToMatch:card];
            } else {
                [self.chosenCards addObject:card];
                self.lastMatched = nil;
            }
        }
        card.chosen = YES;
    }
    
}


@end
