//
//  SetCard.h
//  Matchismo
//
//  Created by Matthew Green on 5/7/17.
//  Copyright © 2017 Matthew Green. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) NSUInteger number;

+ (NSArray *)validShapes;
+ (NSArray *)validColors;
+ (NSArray *)validShading;
+ (NSUInteger)maxNumber;

@end
