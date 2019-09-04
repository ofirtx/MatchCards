//
//  ViewController.m
//  MatchCards
//
//  Created by Ofir Talmor on 02/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameDescriptor;
@property (weak, nonatomic) IBOutlet UISegmentedControl *numToMatchControl;



@end

@implementation ViewController

- (CardMatchingGame *)generateNewGame{
    return [[CardMatchingGame alloc] initWithCardCount:[self.buttons count] usingDeck:[self createDeck]];
}

- (CardMatchingGame *)game{
    if (!_game) _game = [self generateNewGame];
    return _game;
}

- (Deck *)createDeck{
    return [[PlayingCardDeck alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)touchCardButton:(UIButton *)sender {
    self.numToMatchControl.enabled = NO;
    NSUInteger chosenButtonIndex = [self.buttons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (void) updateUI{
    for (UIButton *cardButton in self.buttons){
        NSUInteger cardButtonIndex = [self.buttons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.matched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];
    if(self.game.lastMatched){
        NSString * str = [self cardsToString:self.game.lastMatched];
        if(self.game.matchSuc){
            self.gameDescriptor.text = [NSString stringWithFormat:@"%@ matched for %d points", str, self.game.pointsGained];
        } else {
            self.gameDescriptor.text = [NSString stringWithFormat:@"%@ Do not match! %d points reduced", str, -self.game.pointsGained];
        }
    } else {
        NSString * str = [self cardsToString:self.game.chosenCards];
        self.gameDescriptor.text = [NSString stringWithFormat:@"you chose %@", str];
    }
}

-(NSString *)cardsToString:(NSArray *)cards{
    NSMutableString * str = [[NSMutableString alloc] init];
    for(Card *card in cards){
        [str appendString:card.contents];
    }
    return str;
}

- (NSString *)titleForCard:(Card *)card {
    return card.chosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.chosen ? @"blank" : @"stanford"];
}

- (IBAction)resetGame:(id)sender {
    self.game = [self generateNewGame];
    [self updateUI];
    self.gameDescriptor.text = @"Please choose a card";
    self.numToMatchControl.enabled = YES;
}

- (IBAction)adjustNumToMatch:(UISegmentedControl *)sender {
    self.game.numToMatch = sender.selectedSegmentIndex + 2;
}

@end
