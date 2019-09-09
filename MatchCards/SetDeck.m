//
//  SetDeck.m
//  MatchCards
//
//  Created by Ofir Talmor on 08/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

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

@end
