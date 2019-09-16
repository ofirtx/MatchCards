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
#import "CardViewHolder.h"


@interface MatchingCardViewController : UIViewController

@property (nonatomic) CardMatchingGame *game;
@property (nonatomic) NSMutableAttributedString *history;
@property (nonatomic) NSMutableArray <CardViewHolder*> *cardViewHolders;

- (NSAttributedString *)titleForCard:(id <Card>)card;
- (UIImage *)backgroundImageForCard:(id <Card>)card;
- (NSAttributedString *)getDescriptorText;
- (CardMatchingGame *)generateNewGameWithCardCount:(NSUInteger)cardCount;
- (UIView *)generateViewForCard:(id <Card>)card;
- (void)updateView:(UIView *)view forCard:(id <Card>)card;
- (void)touchView:(UIView *)view;
- (void)updateUI;
- (void)touchCard:(UITapGestureRecognizer *)gesture;
- (CardViewHolder *)getHolderOfView:(UIView *)view;
- (CardViewHolder *)getHolderOfCard:(id <Card>)card;




@end

