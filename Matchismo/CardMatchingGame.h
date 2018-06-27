//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Matthew Green on 1/2/17.
//  Copyright © 2017 Matthew Green. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"


@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void) resetScore;

- (void) chooseCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSInteger matchCount;
@property (nonatomic) NSInteger curMatchScore;
@property (nonatomic) BOOL misMatch;

@end
