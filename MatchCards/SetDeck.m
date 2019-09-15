//
//  SetDeck.m
//  MatchCards
//
//  Created by Ofir Talmor on 08/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

@interface SetDeck()

@property (strong, nonatomic) NSMutableArray *cards;

@end

@implementation SetDeck

-(instancetype)init{
    NSLog(@"init a set deck started");
    self = [super init];
    
    if(self){
        for (NSString *shape in [SetCard validShapes]){
            for (NSString *color in [SetCard validColors]){
                for (NSUInteger number = 0; number < NUMBER_TO_MATCH; number++){
                    for (NSUInteger shading = 0; shading < NUMBER_TO_MATCH; shading++){
                        SetCard *card = [[SetCard alloc] init];
                        card.shape = shape;
                        card.color = color;
                        card.number = number;
                        card.shading = shading;
                        [self addCard:card];
                    }
                }
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
