//
//  SetCard.h
//  MatchCards
//
//  Created by Ofir Talmor on 08/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "Card.h"
#define NUMBER_TO_MATCH 3

NS_ASSUME_NONNULL_BEGIN

@interface SetCard : Card

@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *color;
@property (nonatomic) NSUInteger shading;
@property (nonatomic) NSUInteger number;

+ (NSArray *) validShapes;
+ (NSArray *) validColors;


@end

NS_ASSUME_NONNULL_END
