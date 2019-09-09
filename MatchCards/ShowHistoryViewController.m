//
//  ShowHistoryViewController.m
//  MatchCards
//
//  Created by Ofir Talmor on 09/09/2019.
//  Copyright © 2019 Ofir Talmor. All rights reserved.
//

#import "ShowHistoryViewController.h"

@interface ShowHistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *HistoryTextView;
@property (nonatomic) NSAttributedString *historyTextToPresent;

@end

@implementation ShowHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    self.HistoryTextView.attributedText = self.historyTextToPresent;
}

- (void)setHistory:(NSAttributedString *)history{
    self.historyTextToPresent = history;
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
