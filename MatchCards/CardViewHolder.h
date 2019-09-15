//
//  CardViewHolder.h
//  MatchCards
//
//  Created by Ofir Talmor on 15/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardViewHolder : NSObject

@property (nonatomic) UIView *view;
@property (nonatomic) id <Card> card;

@end

NS_ASSUME_NONNULL_END
