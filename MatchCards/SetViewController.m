//
//  SetViewController.m
//  MatchCards
//
//  Created by Ofir Talmor on 08/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "SetViewController.h"
#import "SetDeck.h"
#import "SetCardMatchingGame.h"

@interface SetViewController ()

@end

@implementation SetViewController

- (Deck *)createDeck {
    Deck *deck = [[SetDeck alloc] init];
    return deck;
}

- (CardMatchingGame *)generateNewGameWithCardCount:(NSUInteger)cardCount{
    CardMatchingGame *generatedGame = [[SetCardMatchingGame alloc] initWithCardCount:cardCount usingDeck:[self createDeck]];
    return generatedGame;
}

- (NSAttributedString *)titleForCard:(SetCard *)card {
    NSLog(@"generating title for card");
    NSAttributedString *title = [[NSMutableAttributedString alloc] initWithString:[self getCardTitleString:card] attributes:@{NSForegroundColorAttributeName: [self getCardColor:card], NSStrokeColorAttributeName: [SetViewController getColorByName:card.color], NSStrokeWidthAttributeName: card.shading ? @0 : @-5}];
    NSLog(@"generated");
    return title;
}

- (NSString *)getCardTitleString:(SetCard *)card{
    NSMutableString *title = [[NSMutableString alloc] initWithString:@""];
    for(NSUInteger i = 0; i <= card.number; i++){
        [title appendString:card.shape];
    }
    return title;
}

- (NSString *)convertShapeToUnfilledShape:(NSString *)shape {
    NSDictionary *dict = @{@"●":@"○", @"■":@"□", @"▲":@"△"};
    return dict[shape];
}

- (UIColor *)getCardColor:(SetCard *)card{
    UIColor *color = [SetViewController getColorByName:card.color];
    UIColor *colorWithAlpha = [color colorWithAlphaComponent:0.5*card.shading];
    return colorWithAlpha;
}

+ (UIColor *)getColorByName:(NSString *)colorName{
    NSDictionary *dict = @{@"blue": [UIColor blueColor], @"red": [UIColor redColor], @"green": [UIColor greenColor]};
    UIColor *color = dict[colorName];
    return color;
}

- (UIImage *)backgroundImageForCard:(Card *)card{
    UIImage *image = [UIImage imageNamed:@"blank"];
    return image;
}

- (NSAttributedString *)getDescriptorText{
    NSMutableAttributedString *descriptorText = [[NSMutableAttributedString alloc] init];
    if(self.game.lastMatched){
        [descriptorText appendAttributedString:[self cardsToString:self.game.lastMatched]];
        if(self.game.matchSuc){
            [descriptorText appendAttributedString: [[NSAttributedString alloc] initWithString:@" matched! :)" attributes:@{}]];
        } else {
            [descriptorText appendAttributedString: [[NSAttributedString alloc] initWithString:@" did not match :(" attributes:@{}]];
        }
    } else {
        if([self.game.chosenCards count] > 0){
            [descriptorText appendAttributedString:[self cardsToString:self.game.chosenCards]];
            [descriptorText appendAttributedString:[[NSAttributedString alloc] initWithString:@" Are chosen" attributes:@{}]];
        }
        else {
            [descriptorText appendAttributedString:[[NSAttributedString alloc] initWithString:@"Please choose a card" attributes:@{}]];
        }
    }
    return descriptorText;
}

-(NSMutableAttributedString *)cardsToString:(NSArray *)cards{
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] init];
    for(Card *card in cards){
        [str appendAttributedString:[self titleForCard:card]];
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
