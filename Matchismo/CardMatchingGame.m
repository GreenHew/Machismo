//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Matthew Green on 1/2/17.
//  Copyright © 2017 Matthew Green. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of Card
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;


- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)resetScore {
    self.score = 0;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    if (self ) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
    self.curMatchScore = 0;
    Card *card = [self cardAtIndex:index];
    NSMutableArray *otherCards = [NSMutableArray array];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            // match against another card
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [otherCards addObject:otherCard];
                    if ([otherCards count] == _matchCount - 1) {
                        self.curMatchScore = [card match:otherCards];
                        if (self.curMatchScore) {
                            self.curMatchScore *= MATCH_BONUS;
                            self.score += self.curMatchScore;
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            self.curMatchScore -= MISMATCH_PENALTY;
                        }
                        break;
                    }
                }
            }
            self.score -= COST_TO_CHOOSE;
            self.curMatchScore -= COST_TO_CHOOSE;
            if ([otherCards count] == _matchCount -1 && _curMatchScore <= 0) {
                _misMatch = YES;
            }else {
                _misMatch = NO;
            }
            card.chosen = YES;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (instancetype) init {
    return nil;
}

@end
