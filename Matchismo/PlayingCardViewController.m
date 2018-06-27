//
//  PlayingCardViewController.m
//  Matchismo
//
//  Created by Matthew Green on 5/5/17.
//  Copyright © 2017 Matthew Green. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardViewController ()

@end

@implementation PlayingCardViewController

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (NSMutableAttributedString *)titleForCard:(PlayingCard *)card {
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:(card.contents)];
    [title setAttributes:@{ NSForegroundColorAttributeName : UIColor.blackColor } range:NSMakeRange(0, [title length])];
    return title;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.game.matchCount = 2;
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:20.0] } forState:UIControlStateNormal];
    
}


@end
