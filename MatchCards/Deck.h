//
//  Deck.h
//  MatchCards
//
//  Created by Ofir Talmor on 02/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@protocol Deck <NSObject>

- (void) addCard:(id <Card>)card atTop:(BOOL)atTop;
- (void) addCard:(id <Card>)card;
- (id <Card>)drawRandomCard;

@end

NS_ASSUME_NONNULL_END
