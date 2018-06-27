//
//  Card.h
//  Matchismo
//
//  Created by Matthew Green on 12/31/16.
//  Copyright © 2016 Matthew Green. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;
@property (nonatomic, strong) NSMutableArray *matchedCards;

- (int)match:(NSArray *)otherCards;

@end
