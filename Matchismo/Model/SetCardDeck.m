//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Matthew Green on 5/8/17.
//  Copyright © 2017 Matthew Green. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init {
    self = [super init];
    if (self) {
        NSUInteger maxNumber = [SetCard maxNumber];
        for (NSString *shape in [SetCard validShapes]) {
            for (NSString *color in [SetCard validColors]) {
                for (NSString *shading in [SetCard validShading]) {
                    for (NSUInteger i = 1; i <= maxNumber; i++) {
                        SetCard *card = [[SetCard alloc] init];
                        [card setShape:shape];
                        [card setColor:color];
                        [card setShading:shading];
                        card.number = i;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}

@end
