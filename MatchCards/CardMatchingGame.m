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
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
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
        
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index{
    return index < [self.cards count] ? self.cards[index] : nil;
}

-(void)chooseCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    if(!card.matched){
        if(card.chosen){
            card.chosen = NO;
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

@end
