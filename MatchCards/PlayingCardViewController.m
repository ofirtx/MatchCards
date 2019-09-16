//
//  PlayingCardViewController.m
//  MatchCards
//
//  Created by Ofir Talmor on 08/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchinGameFactory.h"
#import "PlayingCard.h"
#import "PlayingCardView.h"

@interface PlayingCardViewController ()

@property (nonatomic) UIView *chosenview;

@end

@implementation PlayingCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (CardMatchingGame *)generateNewGameWithCardCount:(NSUInteger)cardCount{
    CardMatchingGame *generatedGame = [CardMatchinGameFactory createPlayingCardMatchingGameWithCount:cardCount];
    return generatedGame;
}

- (NSAttributedString *)titleForCard:(PlayingCard *)card {
    NSString *title = card.chosen ? card.contents : @"";
    return [[NSAttributedString alloc] initWithString:title attributes:@{}];
}

- (UIImage *)backgroundImageForCard:(PlayingCard *)card{
    return [UIImage imageNamed:card.chosen ? @"blank" : @"stanford"];
}

- (NSAttributedString *)getDescriptorText{
    NSString *descriptorText;
    if(self.game.lastMatched){
        NSString * str = [self cardsToString:self.game.lastMatched];
        if(self.game.matchSuc){
            descriptorText = [NSString stringWithFormat:@"%@ matched for %ld points", str, self.game.pointsGained];
        } else {
            descriptorText = [NSString stringWithFormat:@"%@ Do not match! %ld points reduced", str, -self.game.pointsGained];
        }
    } else {
        if ([self.game.chosenCards count] > 0){
            NSString * str = [self cardsToString:self.game.chosenCards];
            descriptorText = [NSString stringWithFormat:@"you chose %@", str];
        }
        else {
            descriptorText = @"Please choose a card";
        }
    }
    return [[NSAttributedString alloc] initWithString:descriptorText attributes:@{}];
}

-(NSString *)cardsToString:(NSArray *)cards{
    NSMutableString * str = [[NSMutableString alloc] init];
    for(PlayingCard *card in cards){
        [str appendString:card.contents];
    }
    return str;
}

- (UIView *)generateViewForCard:(PlayingCard *)card{
    PlayingCardView *view = [[PlayingCardView alloc] init];
    [self updateView:view forCard:card];
    return view;
}

- (void)setView:(PlayingCardView *)view forCard:(PlayingCard *)card{
    view.rank = card.rank;
    view.suit = card.suit;
}

- (void)touchCard:(UITapGestureRecognizer *)gesture{
        if (gesture.state == UIGestureRecognizerStateEnded) {
            __weak PlayingCardViewController * weakSelf = self;
            PlayingCardView *touchedView = (PlayingCardView *)gesture.view;
            CardViewHolder *touchedHolder = [self getHolderOfView:touchedView];
            NSUInteger index = [self.cardViewHolders indexOfObject:touchedHolder];
            if([self.game cardAtIndex:index].matched){
                return;
            }
            if(touchedView.faceUp){
                [self.game chooseCardAtIndex:index];
                [self updateUI];
                return;
            }
            [UIView transitionWithView:touchedView
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                               
                               [weakSelf touchView:gesture.view];
                           } completion:^(BOOL finished) {
                               [weakSelf.game chooseCardAtIndex:index];
                               [weakSelf updateUI];
                           }];
    }
}

- (void)touchView:(PlayingCardView *)view{
    if(view.faceUp) return;
    [UIView transitionWithView:view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                           view.faceUp = !view.faceUp;
                       } completion:^(BOOL finished) {}];
    [view setNeedsDisplay];
}

- (void)updateView:(PlayingCardView *)view forCard:(PlayingCard *)card{
    if(view.faceUp != card.chosen){
        __weak PlayingCardViewController * weakSelf = self;
        [UIView transitionWithView:view
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                               [weakSelf setView:view forCard:card];
                               view.faceUp = !view.faceUp;
                           } completion:^(BOOL finished) {
                           }];
    }
    else{
        [self setView:view forCard:card];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
