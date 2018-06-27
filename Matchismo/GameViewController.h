//
//  GameViewController.h
//  Matchismo
//
//  Created by Matthew Green on 6/3/17.
//  Copyright © 2017 Matthew Green. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface GameViewController : UIViewController

- (Deck *)createDeck;
- (CardMatchingGame *)game;

@end
