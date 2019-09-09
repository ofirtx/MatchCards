//
//  PlayingCardMatchingGame.m
//  MatchCards
//
//  Created by Ofir Talmor on 08/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "PlayingCardMatchingGame.h"

@implementation PlayingCardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self = [super initWithCardCount:count usingDeck:deck];
    self.numToMatch = 2;
    return self;
}

@end
