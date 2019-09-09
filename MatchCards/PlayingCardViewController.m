//
//  PlayingCardViewController.m
//  MatchCards
//
//  Created by Ofir Talmor on 08/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardMatchingGame.h"

@interface PlayingCardViewController ()

@end

@implementation PlayingCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (CardMatchingGame *)generateNewGameWithCardCount:(NSUInteger)cardCount{
    CardMatchingGame *generatedGame = [[PlayingCardMatchingGame alloc] initWithCardCount:cardCount usingDeck:[self createDeck]];
    return generatedGame;
}

- (NSAttributedString *)titleForCard:(Card *)card {
    NSString *title = card.chosen ? card.contents : @"";
    return [[NSAttributedString alloc] initWithString:title attributes:@{}];
}

- (UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.chosen ? @"blank" : @"stanford"];
}

- (NSAttributedString *)getDescriptorText{
    NSString *descriptorText;
    if(self.game.lastMatched){
        NSString * str = [self cardsToString:self.game.lastMatched];
        if(self.game.matchSuc){
            descriptorText = [NSString stringWithFormat:@"%@ matched for %d points", str, self.game.pointsGained];
        } else {
            descriptorText = [NSString stringWithFormat:@"%@ Do not match! %d points reduced", str, -self.game.pointsGained];
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
    for(Card *card in cards){
        [str appendString:card.contents];
    }
    return str;
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
