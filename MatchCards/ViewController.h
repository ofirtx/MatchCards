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


@interface ViewController : UIViewController

@property (nonatomic) CardMatchingGame *game;
@property (nonatomic) NSMutableAttributedString *history;

- (Deck *)createDeck;
- (NSAttributedString *)titleForCard:(Card *)card;
- (UIImage *)backgroundImageForCard:(Card *)card;
- (NSAttributedString *)getDescriptorText;
- (CardMatchingGame *)generateNewGameWithCardCount:(NSUInteger)cardCount;



@end

