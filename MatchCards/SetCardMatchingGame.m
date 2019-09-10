//
//  SetCardMatchingGame.m
//  MatchCards
//
//  Created by Ofir Talmor on 08/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "SetCardMatchingGame.h"

@interface SetCardMatchingGame()

@property (nonatomic, readwrite) NSArray *lastMatched;
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic) NSUInteger numToMatch;
@property (nonatomic, readwrite) BOOL matchSuc;
@property (nonatomic, readwrite) int pointsGained;
@property (nonatomic, readwrite) NSMutableArray *chosenCards;

@end

@implementation SetCardMatchingGame


@synthesize lastMatched;
@synthesize score;
@synthesize numToMatch;
@synthesize matchSuc;
@synthesize pointsGained;
@synthesize chosenCards = _chosenCards;

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self = [super initWithCardCount:count usingDeck:deck];
    self.numToMatch = 3;
    return self;
}

-(void)unChooseCard:(Card *)card{
    card.chosen = NO;
    [self.chosenCards removeObject:card];
    self.lastMatched = nil;
}

-(void)updateGameAfterAMatch{
    self.matchSuc = YES;
    self.score += self.pointsGained;
    for(Card * matchedCard in self.chosenCards){
        matchedCard.matched = YES;
    }
    self.lastMatched = self.chosenCards;
    self.chosenCards = [[NSMutableArray alloc] init];
}

- (NSMutableArray *)chosenCards{
    if (!_chosenCards) _chosenCards = [[NSMutableArray alloc] init];
    return _chosenCards;
}

-(void)updateGameAfterMismatch:(Card *)card{
    self.score -= 1;
    self.pointsGained = -1;
    self.matchSuc = NO;
    for(Card * matchedCard in self.chosenCards){
        matchedCard.chosen = NO;
    }
    self.lastMatched = self.chosenCards;
    self.chosenCards = [[NSMutableArray alloc] init];
    [self.chosenCards addObject:card];
}

-(void)tryToMatch:(Card *)card{
    int matchScore = [card match:self.chosenCards];
    [self.chosenCards addObject:card];
    if(matchScore){
        self.pointsGained = matchScore;
        [self updateGameAfterAMatch];
    }
    else{
        [self updateGameAfterMismatch:card];
    }
}

- (void)chooseCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
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
