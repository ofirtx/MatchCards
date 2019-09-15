//
//  MatchingGameLogic.h
//  MatchCards
//
//  Created by Ofir Talmor on 10/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MatchingGameLogic <NSObject>

@required
@property (nonatomic, readonly) NSUInteger mismatchPenalty;
@property (nonatomic, readonly) NSUInteger choosingPenalty;
@property (nonatomic, readonly) NSUInteger numberOfCardsToAdd;


- (int)match:(NSArray *)cards;
- (void)replaceMatchedCards:(NSMutableArray *)cards withDeck:(id <Deck>)deck;

@optional

@end

NS_ASSUME_NONNULL_END
