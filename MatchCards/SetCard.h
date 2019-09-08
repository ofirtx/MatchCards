//
//  SetCard.h
//  MatchCards
//
//  Created by Ofir Talmor on 08/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCard : Card

@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *color;
@property (nonatomic) BOOL filled;

+ (NSArray *) validShapes;
+ (NSArray *) validColors;

@end

NS_ASSUME_NONNULL_END
