//
//  PlayingCardMatchingGameLogic.h
//  MatchDrawnCards
//
//  Created by Ofir Talmor on 11/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatchingGameLogic.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardMatchingGameLogic : NSObject <MatchingGameLogic>

@property (nonatomic, readonly) NSUInteger mismatchPenalty;
@property (nonatomic, readonly) NSUInteger choosingPenalty;
@property (nonatomic, readonly) NSUInteger numberOfCardsToAdd;

-(int)match:(NSArray *)cards;
- (void)replaceMatchedCards:(NSMutableArray *)cards withDeck:(id <Deck>)deck;

@end

NS_ASSUME_NONNULL_END
