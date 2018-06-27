//
//  GameViewController.m
//  Matchismo
//
//  Created by Matthew Green on 6/3/17.
//  Copyright © 2017 Matthew Green. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()
@property (weak, nonatomic) IBOutlet UIView *cardBoundsView;
@property (nonatomic, strong) CardMatchingGame *game;
@property (nonatomic, strong) Deck *deck;
@property (strong, nonatomic) NSMutableArray *cardViews;
@end

@implementation GameViewController

#define CARD_SPACING_PERCENTAGE 0.0625

- (void)updateViewBounds
{
    CGRect newBounds = _cardBoundsView.bounds;
    newBounds.size.height = _cardBoundsView.bounds.size.width;
    newBounds.size.width = _cardBoundsView.bounds.size.height;
    _cardBoundsView.bounds = newBounds;
}

- (CGFloat)scaledCardSpacing
{
    if (_cardBoundsView.bounds.size.height > _cardBoundsView.bounds.size.width) return _cardBoundsView.bounds.size.height * CARD_SPACING_PERCENTAGE;
    else return _cardBoundsView.bounds.size.width * CARD_SPACING_PERCENTAGE;
}

- (CardMatchingGame *)game
{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardViews count]
                                                         usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck //abstract
{
    return nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
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
