//
//  CardMatchinGameFactory.m
//  MatchCards
//
//  Created by Ofir Talmor on 12/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "CardMatchinGameFactory.h"
#import "SetDeck.h"
#import "SetMatchingGameLogic.h"
#import "PlayingCardDeck.h"
#import "PlayingCardMatchingGameLogic.h"

@implementation CardMatchinGameFactory

#pragma mark - SetGame

#define SET_GAME_DEFAULT_COUNT 12

+ (CardMatchingGame *)createSetGame{
    return [[CardMatchingGame alloc] initWithCardCount:SET_GAME_DEFAULT_COUNT usingDeck:[[SetDeck alloc] init] usingLogic:[[SetMatchingGameLogic alloc] init] matchingNumber:3];
}

+ (CardMatchingGame *)createSetGameWithCount:(NSUInteger)count{
    return [[CardMatchingGame alloc] initWithCardCount:count usingDeck:[[SetDeck alloc] init] usingLogic:[[SetMatchingGameLogic alloc] init] matchingNumber:3];
}

#pragma mark - SetGame

#define PLAYING_CARD_GAME_DEFAULT_COUNT 30

+ (CardMatchingGame *)createPlayingCardMatchingGame{
    return [[CardMatchingGame alloc] initWithCardCount:PLAYING_CARD_GAME_DEFAULT_COUNT usingDeck:[[PlayingCardDeck alloc] init] usingLogic:[[PlayingCardMatchingGameLogic alloc] init] matchingNumber:2];
}

+ (CardMatchingGame *)createPlayingCardMatchingGameWithCount:(NSUInteger)count{
    return [[CardMatchingGame alloc] initWithCardCount:count usingDeck:[[PlayingCardDeck alloc] init] usingLogic:[[PlayingCardMatchingGameLogic alloc] init] matchingNumber:2];
}

@end
