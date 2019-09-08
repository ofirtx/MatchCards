//
//  SetCard.m
//  MatchCards
//
//  Created by Ofir Talmor on 08/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (NSArray *)validShapes{
    return @[@"●", @"■", @"▲"];
}

+ (NSArray *)validColors{
    return @[@"red", @"blue", @"green"];
}

- (void) setShape:(NSString *)shape{
    if([[SetCard validShapes] containsObject:shape]) _shape = shape;
}

- (void) setColor:(NSString *)color{
    if([[SetCard validColors] containsObject:color]) _color = color;
}

- (int)match:(NSArray *)otherCards{
    return 0; //TODO: implement Set game match
}

@end
