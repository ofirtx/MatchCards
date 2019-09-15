//
//  PlayingCardDeck.m
//  MatchCards
//
//  Created by Ofir Talmor on 02/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface PlayingCardDeck()

@property (strong, nonatomic) NSMutableArray *cards;

@end

@implementation PlayingCardDeck

-(instancetype)init{
    self = [super init];
    
    if(self){
        for (NSString *suit in [PlayingCard validSuits]){
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++){
                PlayingCard *card = [[PlayingCard alloc] init];
                card.suit = suit;
                card.rank = rank;
                [self addCard:card];
            }
        }
    }
    
    return self;
}

- (NSMutableArray *)cards{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void) addCard:(id <Deck>) card atTop:(BOOL)atTop{
    if (atTop){
        [self.cards insertObject:card atIndex:0];
    }
    else{
        [self.cards addObject:card];
    }
}

- (void) addCard:(id <Card>)card{
    [self addCard:card atTop:YES];
}

- (id <Card>)drawRandomCard{
    id <Card> randomCard = nil;
    
    if([self.cards count]){
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end
