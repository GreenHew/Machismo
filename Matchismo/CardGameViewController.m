//
//  ViewController.m
//  Matchismo
//
//  Created by Matthew Green on 12/31/16.
//  Copyright © 2016 Matthew Green. All rights reserved.
//

#import "CardGameViewController.h"
#import "MatchHistoryViewController.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic, strong) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchCount;
@property (weak, nonatomic) IBOutlet UILabel *matchText;
@property (nonatomic, strong) NSMutableArray *matchTextHistory;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game {
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                         usingDeck:[self createDeck]];
    return _game;
}

- (void)disableSwitch {
    _matchCount.enabled = !_matchCount.isEnabled;
}

- (NSMutableArray *)matchTextHistory {
    if (!_matchTextHistory) _matchTextHistory = [[NSMutableArray alloc] init];
    return _matchTextHistory;
}

- (Deck *)createDeck {  // abstract
    return nil;
}

- (void)viewDidLoad {
    _matchText.lineBreakMode = NSLineBreakByWordWrapping;
    _matchText.numberOfLines = 0;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Match History"]) {
        if ([segue.destinationViewController isKindOfClass:[MatchHistoryViewController class]]) {
            MatchHistoryViewController *mhvc = (MatchHistoryViewController *)segue.destinationViewController;
            [mhvc setMatchHistoryList:_matchTextHistory];
        }
    }
}

- (IBAction)touchMatchNumberButton:(id)sender {
    if(_matchCount.selectedSegmentIndex == 0){
        _game.matchCount = 2;
    }else if (_matchCount.selectedSegmentIndex == 1) {
        _game.matchCount = 3;
    }
}

- (IBAction)touchResetButton:(UIButton *)sender {
    [_game resetScore];
    for (UIButton *cardButton in self.cardButtons) {
        int cardIndex = (int)[self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        if (card.isChosen) {
            card.chosen = NO;
            card.matched = NO;
            if (!cardButton.enabled) {
                cardButton.enabled = YES;
            }
        }
    }
    _matchTextHistory = [[NSMutableArray alloc] init];
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                              usingDeck:[self createDeck]];
    if(!_matchCount.isEnabled) [self disableSwitch];
    [self updateUI];
}


- (IBAction)touchCardButton:(UIButton *)sender {
    if(_matchCount.isEnabled) [self disableSwitch];
    int cardIndex = (int)[self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
    
}

- (void)updateUI {
    NSMutableArray *chosenCards = [NSMutableArray array];
    for (UIButton *cardButton in self.cardButtons) {
        int cardIndex = (int)[self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        if(card.isChosen) [chosenCards addObject:card];
        [cardButton setAttributedTitle: card.isChosen ? [self titleForCard:card] : [[NSMutableAttributedString alloc] initWithString:@""] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        if(!cardButton.enabled) card.chosen = NO;
    }
    NSMutableAttributedString *curMatchText = [[NSMutableAttributedString alloc] init];
    if([chosenCards count] == self.game.matchCount) {
        curMatchText = [self matchCardText:chosenCards :self.game.curMatchScore];
        [self.matchTextHistory addObject:curMatchText];
    }
    self.matchText.attributedText = curMatchText;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    if(self.game.misMatch) {
        for (Card *card in chosenCards) {
            card.chosen = NO;
        }
    }
}

- (NSMutableAttributedString *)matchCardText:(NSMutableArray *)cards :(NSInteger)matchScore { //abstract
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *attributedEndText = [[NSMutableAttributedString alloc] init];
    NSMutableString *endText = [[NSMutableString alloc] init];
    for (Card *card in cards) {
        [text appendAttributedString:[self titleForCard:card]];
    }
    if(matchScore > 0){
        [endText insertString:@" Matched " atIndex:0];
        NSString *scoreString = [NSString stringWithFormat:@"for %ld points", matchScore];
        [endText appendString:scoreString];
        attributedEndText = [[NSMutableAttributedString alloc] initWithString:endText];
        [attributedEndText setAttributes:@{ NSForegroundColorAttributeName : UIColor.blackColor } range:NSMakeRange(0, [endText length])];
    }else if(matchScore < 0) {
        NSString *scoreString = [NSString stringWithFormat:@" don't match! %ld penalty!", matchScore];
        [endText appendString:scoreString];
        attributedEndText = [[NSMutableAttributedString alloc] initWithString:endText];
        [attributedEndText setAttributes:@{ NSForegroundColorAttributeName : UIColor.blackColor } range:NSMakeRange(0, [endText length])];
    }
    [text appendAttributedString:attributedEndText];
    return text;
}

- (NSMutableAttributedString *)titleForCard:(Card *)card { //abstract
    return nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}


@end
