//
//  CardMatchingGame.h
//  MatchCards
//
//  Created by Ofir Talmor on 03/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "Deck.h"
#import "MatchingGameLogic.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(id <Deck>)deck usingLogic:(id <MatchingGameLogic>)logic matchingNumber:(NSUInteger)number;
// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(id <Deck>)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (id <Card>)cardAtIndex:(NSUInteger)index;
- (NSUInteger)numberOfDealtCards;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger numToMatch;
@property (nonatomic, readonly) NSArray *lastMatched;
@property (nonatomic, readonly) BOOL matchSuc;
@property (nonatomic, readonly) NSInteger pointsGained;
@property (nonatomic, readonly) NSMutableArray *chosenCards;

@end

NS_ASSUME_NONNULL_END
