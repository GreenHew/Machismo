//
//  PlayingCard.m
//  Matchismo
//
//  Created by Matthew Green on 12/31/16.
//  Copyright © 2016 Matthew Green. All rights reserved.
//

#import "PlayingCard.h"

@interface PlayingCard()
@end


@implementation PlayingCard

static const int RANK_MATCH = 4;
static const int SUIT_MATCH = 2;


- (int)testMatch:(PlayingCard *)firstCard :(PlayingCard *)secondCard {
    int score = 0;
    if(firstCard.rank == secondCard.rank) {
        score += RANK_MATCH;
    }if([firstCard.suit isEqualToString:secondCard.suit]) {
        score += SUIT_MATCH;
    }
    return score;
}



- (int)match:(NSArray *)otherCards {
    int score = 0;
    if([otherCards count] > 0) {
        NSMutableArray *prevCards = [NSMutableArray array];
        for(PlayingCard *nextCard in otherCards) {
            int matchScore = 0;
            matchScore = [self testMatch:self :nextCard];
            if(matchScore) score += matchScore;
            if(matchScore) {
                [self setCardsMatched:self :otherCards];
            }
            for(PlayingCard *prevCard in prevCards){
                matchScore = [self testMatch:nextCard :prevCard];
                if(matchScore) score += matchScore;
            }if(matchScore) {
                [self setCardsMatched:self :otherCards];
            }
            [prevCards addObject:nextCard];
        }
    }
    return score;
}

- (void)setCardsMatched:(PlayingCard *)card :(NSArray *)otherCards {
    card.matched = YES;
    for(PlayingCard *card in otherCards) {
        card.matched = YES;
    }
}

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; //because we provide setter and getter
+ (NSArray *)validSuits {
    return @[@"♥︎",@"♦︎",@"♠︎",@"♣︎"];
}
- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}
- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank { return [[self rankStrings] count]-1; }

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
