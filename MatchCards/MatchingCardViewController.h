//
//  ViewController.h
//  MatchCards
//
//  Created by Ofir Talmor on 02/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"


@interface MatchingCardViewController : UIViewController

@property (nonatomic) CardMatchingGame *game;
@property (nonatomic) NSMutableAttributedString *history;

- (NSAttributedString *)titleForCard:(id <Card>)card;
- (UIImage *)backgroundImageForCard:(id <Card>)card;
- (NSAttributedString *)getDescriptorText;
- (CardMatchingGame *)generateNewGameWithCardCount:(NSUInteger)cardCount;



@end

