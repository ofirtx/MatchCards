//
//  ViewController.m
//  MatchCards
//
//  Created by Ofir Talmor on 02/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "MatchingCardViewController.h"
#import "ShowHistoryViewController.h"
#import "Grid.h"
#import "CardViewHolder.h"

@interface MatchingCardViewController ()


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameDescriptor;
@property (weak, nonatomic) IBOutlet UISegmentedControl *numToMatchControl;

@property (nonatomic) NSMutableArray <CardViewHolder*> *cardViewHolders;
@property (nonatomic) Grid *grid;

@end

@implementation MatchingCardViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"show history"]){
        if([segue.destinationViewController isKindOfClass:[ShowHistoryViewController class]]){
            ShowHistoryViewController *shvc = (ShowHistoryViewController *)segue.destinationViewController;
            [shvc setHistory:self.history];
        }
    }
}

- (NSMutableAttributedString *)history{
    if(!_history) _history = [[NSMutableAttributedString alloc] initWithString:@"" attributes:@{}];
    return _history;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
    self.gameDescriptor.text = @"Please choose a card";
    // Do any additional setup after loading the view.
}

- (NSAttributedString *)titleForCard:(id <Card>)card {return nil;}
- (UIImage *)backgroundImageForCard:(id <Card>)card {return nil;}

- (CardMatchingGame *)generateNewGame{
    return nil;
}

- (CardMatchingGame *)generateNewGameWithCardCount:(NSUInteger)cardCount{ //abstract
    return nil;
}

- (CardMatchingGame *)game{
    if (!_game){
        _game = [self generateNewGameWithCardCount:[self.buttons count]];
    }
    return _game;
}

- (NSMutableArray *)cardViewHolders
{
    if (!_cardViewHolders) _cardViewHolders = [NSMutableArray array];
    return _cardViewHolders;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger chosenButtonIndex = [self.buttons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    [self updateHistory];
}

- (void)updateHistory{
    if (self.game.lastMatched){
        [self.history appendAttributedString:self.gameDescriptor.attributedText];
        [self.history appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:@{}]];
    }
}

- (CardViewHolder *)getHolderOfCard:(id <Card>)card{
    return nil; //TODO implement
}

- (void)removeMatchedCardViews{
}

- (UIView *)generateViewForCard:(id <Card>)card{
    return nil; // TODO implement
}

- (void)setHoldersInPlace{
    NSMutableArray *holders = [[NSMutableArray alloc] init];
    for(NSUInteger i = 0; i < [self.game numberOfDealtCards]; i++){
        id <Card> card = [self.game cardAtIndex:i];
        CardViewHolder *holder = [self getHolderOfCard:card];
        if(!holder){
            holder = [[CardViewHolder alloc] init];
            holder.card = card;
            holder.view = [self generateViewForCard:card];
        }
        [holders addObject:holder];
    }
}

- (void)placeViews{
    
}

- (void)placeCards{
    [self setHoldersInPlace];
    [self placeViews];
}

- (void) updateUI{
    [self placeCards];
    for(NSUInteger i = 0; i < [self.game numberOfDealtCards]; i++){
        
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];
    self.gameDescriptor.attributedText = [self getDescriptorText];
}

- (NSAttributedString *)getDescriptorText{ //abstract
    return nil;
}

-(NSString *)cardsToString:(NSArray *)cards{
    NSMutableString * str = [[NSMutableString alloc] init];
    for(id <Card> card in cards){
        [str appendString:card.contents];
    }
    return str;
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
