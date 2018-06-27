//
//  MatchHistoryViewController.m
//  Matchismo
//
//  Created by Matthew Green on 5/17/17.
//  Copyright © 2017 Matthew Green. All rights reserved.
//

#import "MatchHistoryViewController.h"

@interface MatchHistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textViewHistroy;

@end

@implementation MatchHistoryViewController

- (void)setMatchHistoryList:(NSMutableArray *)matchHistoryList {
    _matchHistoryList = matchHistoryList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableAttributedString *newLine = [[NSMutableAttributedString alloc] initWithString:@"\n"];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
    for (NSMutableAttributedString *curText in _matchHistoryList) {
        [text appendAttributedString:curText];
        [text appendAttributedString:newLine];
    }
    [_textViewHistroy setAttributedText:text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
