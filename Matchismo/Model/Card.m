//
//  Card.m
//  Matchismo
//
//  Created by Matthew Green on 12/31/16.
//  Copyright © 2016 Matthew Green. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
