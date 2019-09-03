//
//  CardMatchingGame.h
//  MatchCards
//
//  Created by Ofir Talmor on 03/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame : Deck

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

@end

NS_ASSUME_NONNULL_END
