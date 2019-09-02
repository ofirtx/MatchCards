//
//  ViewController.m
//  MatchCards
//
//  Created by Ofir Talmor on 02/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"

@interface ViewController ()

@property (nonatomic) Deck * deck;

@end

@implementation ViewController

- (Deck *) deck{
    if(!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)touchCardButton:(UIButton *)sender {
    if (![sender.currentTitle length]){
        [sender setBackgroundImage:[UIImage imageNamed:@"blank"] forState:UIControlStateNormal];
        NSString * contents = [self.deck drawRandomCard].contents;
        [sender setTitle:contents forState:UIControlStateNormal];
    }
    else{
        [sender setBackgroundImage:[UIImage imageNamed:@"stanford"] forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    }
}


@end
