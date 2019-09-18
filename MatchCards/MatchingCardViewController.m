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

@interface MatchingCardViewController ()


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameDescriptor;
@property (weak, nonatomic) IBOutlet UIView *tableView;

@property (nonatomic) Grid *grid;

@end

@implementation MatchingCardViewController

#pragma mark - getters

- (Grid *)grid{
    if (!_grid){
        _grid = [[Grid alloc] init];
    }
    return _grid;
}

- (NSMutableAttributedString *)history{
    if(!_history) _history = [[NSMutableAttributedString alloc] initWithString:@"" attributes:@{}];
    return _history;
}

- (CardMatchingGame *)game{
    if (!_game){
        _game = [self generateNewGameWithCardCount:12];
    }
    return _game;
}

- (NSMutableArray *)cardViewHolders
{
    if (!_cardViewHolders) _cardViewHolders = [NSMutableArray array];
    return _cardViewHolders;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"show history"]){
        if([segue.destinationViewController isKindOfClass:[ShowHistoryViewController class]]){
            ShowHistoryViewController *shvc = (ShowHistoryViewController *)segue.destinationViewController;
            [shvc setHistory:self.history];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
    self.gameDescriptor.text = @"Please choose a card";
    // Do any additional setup after loading the view.
}

#pragma mark - abstarct methods

- (NSAttributedString *)titleForCard:(id <Card>)card {return nil;}
- (UIImage *)backgroundImageForCard:(id <Card>)card {return nil;}
- (CardMatchingGame *)generateNewGame{return nil;}
- (CardMatchingGame *)generateNewGameWithCardCount:(NSUInteger)cardCount{return nil;}
- (NSAttributedString *)getDescriptorText{return nil;}
- (void)updateView:(UIView *)view forCard:(id <Card>)card{}
- (void)touchView:(UIView *)view{}
- (void)touchCard:(UITapGestureRecognizer *)gesture{}

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
    CardViewHolder *holder = nil;
    for (CardViewHolder *holder in self.cardViewHolders){
        if(holder.card == card) return holder;
    }
    return holder;
}

- (CardViewHolder *)getHolderOfView:(UIView *)view{
    CardViewHolder *holder = nil;
    for (CardViewHolder *holder in self.cardViewHolders){
        if(holder.view == view) return holder;
    }
    return holder;
}
#pragma mark - UI changes

- (UIView *)generateViewForCard:(id <Card>)card{
    UIView *view = [[UIView alloc] initWithFrame:[self.grid frameOfCellAtRow:0 inColumn:0]];
    view.backgroundColor = [UIColor whiteColor];
    return view;// TODO implement
}

- (UIView *)generateViewForCard:(id <Card>)card withIndex:(NSUInteger)index{
    UIView *view = [[UIView alloc] initWithFrame:[self frameForIndex:index]];
    view.backgroundColor = [UIColor whiteColor];
    return view;// TODO implement
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
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(touchCard:)];
            [holder.view addGestureRecognizer:tap];
            //holder.view.frame = [self frameForIndex:i];
            [self.tableView addSubview:holder.view];
            [holder.view setNeedsDisplay];
        }
        [holders addObject:holder];
    }
    for(CardViewHolder *holder in self.cardViewHolders){
        if(![holders containsObject:holder])
            [holder.view removeFromSuperview];
    }
    self.cardViewHolders = holders;
}

- (CGRect)frameForIndex:(NSUInteger)index{
    return [self.grid frameOfCellAtRow:index / [self.grid columnCount] inColumn: index % [self.grid columnCount]];
}

- (void)placeViews{
    __weak MatchingCardViewController *weakSelf = self;
    for(NSUInteger i = 0; i < self.cardViewHolders.count; i++){
//        self.cardViewHolders[i].view.frame = [self frameForIndex:i];
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.cardViewHolders[i].view.frame = [weakSelf frameForIndex:i];
        }];
    }
}

- (void)updateViews{
    for(CardViewHolder *holder in self.cardViewHolders){
        [self updateView:holder.view forCard:holder.card];
    }
}

- (void)placeCards{
    [self setHoldersInPlace];
    [self placeViews];
    [self updateViews];
}

- (void) updateUI{
    [self adjustGridToView];
    [self placeCards];
    for(NSUInteger i = 0; i < [self.game numberOfDealtCards]; i++){
        
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];
    self.gameDescriptor.attributedText = [self getDescriptorText];
}

-(NSString *)cardsToString:(NSArray *)cards{
    NSMutableString * str = [[NSMutableString alloc] init];
    for(id <Card> card in cards){
        [str appendString:card.contents];
    }
    return str;
}

#pragma mark - user input



- (IBAction)resetGame:(id)sender {
    self.game = [self generateNewGame];
    for(CardViewHolder *holder in self.cardViewHolders){
        [holder.view removeFromSuperview];
    }
    self.cardViewHolders = [NSMutableArray array];
    [self updateUI];
    self.gameDescriptor.text = @"Please choose a card";
}

- (void)adjustGridToView{
    Grid *grid = self.grid;
    grid.size = self.tableView.frame.size;
    grid.maxCellWidth = grid.size.width / 4;
    grid.maxCellHeight = grid.size.width * 1.5;
    grid.cellAspectRatio =  grid.size.width / grid.size.height;
    grid.minimumNumberOfCells = 12;
    
    //TODO adjust to actually fit
}

@end
