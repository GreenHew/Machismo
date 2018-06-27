//
//  ViewController.h
//  Matchismo
//
//  Created by Matthew Green on 12/31/16.
//  Copyright © 2016 Matthew Green. All rights reserved.
//
// Abstract class. Must implement methods as described below

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

//protected
//for subclasses
- (Deck *)createDeck;  // abstract
- (NSMutableAttributedString *)titleForCard:(Card *)card;
- (CardMatchingGame *)game;

@end

