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

- (void)setNumber:(NSUInteger)number{
    if(number < NUMBER_TO_MATCH) _number = number;
}

- (void) setShading:(NSUInteger)shading{
    if(shading < NUMBER_TO_MATCH) _shading = shading;
}

- (int)match:(NSArray *)otherCards{
    if([otherCards count] != 2) return 0;
    return ([self shapesMatch:otherCards] && [self colorsMatch:otherCards] && [self numbersMatch:otherCards] && [self shadingsMatch:otherCards]) ? 3 : 0; //TODO: implement Set game match
}

-(BOOL)shapesMatch:(NSArray *)otherCards{
    SetCard *firstCard = otherCards[0];
    SetCard *secondCard = otherCards[1];
    BOOL equal = [self.shape isEqualToString:firstCard.shape] && [self.shape isEqualToString:secondCard.shape];
    BOOL dif = !([self.shape isEqualToString:firstCard.shape] || [self.shape isEqualToString:secondCard.shape] || [secondCard.shape isEqualToString:firstCard.shape]);
    return equal || dif;
}

-(BOOL)colorsMatch:(NSArray *)otherCards{
    SetCard *firstCard = otherCards[0];
    SetCard *secondCard = otherCards[1];
    BOOL equal = [self.color isEqualToString:firstCard.color] && [self.color isEqualToString:secondCard.color];
    BOOL dif = !([self.color isEqualToString:firstCard.color] || [self.color isEqualToString:secondCard.color] || [secondCard.color isEqualToString:firstCard.color]);
    return equal || dif;
}

-(BOOL)numbersMatch:(NSArray *)otherCards{
    SetCard *firstCard = otherCards[0];
    SetCard *secondCard = otherCards[1];
    BOOL equal = (self.number == firstCard.number) && (self.number == secondCard.number);
    BOOL dif = !((self.number ==  firstCard.number) || (self.number == secondCard.number) || (secondCard.number == firstCard.number));
    return equal || dif;
}

-(BOOL)shadingsMatch:(NSArray *)otherCards{
    SetCard *firstCard = otherCards[0];
    SetCard *secondCard = otherCards[1];
    BOOL equal = (self.shading == firstCard.shading) && (self.shading == secondCard.shading);
    BOOL dif = !((self.shading ==  firstCard.shading) || (self.shading == secondCard.shading) || (secondCard.shading == firstCard.shading));
    return equal || dif;
}
@synthesize chosen;

@synthesize contents;

@synthesize matched;

@end

