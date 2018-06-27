//
//  Deck.h
//  Matchismo
//
//  Created by Matthew Green on 12/31/16.
//  Copyright © 2016 Matthew Green. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
