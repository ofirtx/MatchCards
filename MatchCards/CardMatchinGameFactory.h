//
//  CardMatchinGameFactory.h
//  MatchCards
//
//  Created by Ofir Talmor on 12/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchinGameFactory : NSObject

+ (CardMatchingGame *)createSetGame;
+ (CardMatchingGame *)createSetGameWithCount:(NSUInteger)count;

+ (CardMatchingGame *)createPlayingCardMatchingGame;
+ (CardMatchingGame *)createPlayingCardMatchingGameWithCount:(NSUInteger)count;

@end

NS_ASSUME_NONNULL_END
