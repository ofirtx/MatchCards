//
//  SetCardMatchingGame.m
//  MatchCards
//
//  Created by Ofir Talmor on 08/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "SetCardMatchingGame.h"
@implementation SetCardMatchingGame


- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self = [super initWithCardCount:count usingDeck:deck];
    self.numToMatch = 3;
    return self;
}
@end
