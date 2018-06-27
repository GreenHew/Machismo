//
//  SetCardViewController.m
//  Matchismo
//
//  Created by Matthew Green on 5/8/17.
//  Copyright © 2017 Matthew Green. All rights reserved.
//

#import "SetCardViewController.h"
#import "SetCardDeck.h"

@interface SetCardViewController ()

@end

@implementation SetCardViewController

- (Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

- (NSMutableAttributedString *)titleForCard:(SetCard *)card {
    NSMutableString *text = [[NSMutableString alloc] init];
    UIColor *color = [[UIColor alloc] init];
    if ([card.color isEqualToString:@"red"]) color = [UIColor redColor];
    if ([card.color isEqualToString:@"green"]) color = [UIColor greenColor];
    if ([card.color isEqualToString:@"blue"]) color = [UIColor blueColor];
    for (NSUInteger i = 0; i < card.number; i++) {
        [text appendString:card.shape];
    }
    [text appendString:@" "];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:text];
    [title setAttributes:@{ NSForegroundColorAttributeName : color } range:NSMakeRange(0, [title length])];
    return title;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.game.matchCount = 3;
    // Do any additional setup after loading the view.
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
