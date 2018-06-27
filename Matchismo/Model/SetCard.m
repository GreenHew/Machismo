//
//  SetCard.m
//  Matchismo
//
//  Created by Matthew Green on 5/7/17.
//  Copyright © 2017 Matthew Green. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard
@synthesize shape = _shape;
@synthesize color = _color;
@synthesize shading = _shading;

static const int MATCH_SCORE = 5;

- (int)match:(NSArray *)otherCards
{
    int shapeMatchCount = 0;
    int colorMatchCount = 0;
    int shadingMatchCount = 0;
    int numberMatchCount = 0;
    SetCard *cardTwo = [otherCards objectAtIndex:0];
    SetCard *cardThree = [otherCards objectAtIndex:1];
    shapeMatchCount = [self compareShapes:cardTwo.shape] + [self compareShapes:cardThree.shape] + [cardTwo compareShapes:cardThree.shape];
    colorMatchCount = [self compareColors:cardTwo.color] + [self compareColors:cardThree.color] + [cardTwo compareColors:cardThree.color];
    shadingMatchCount = [self compareShading:cardTwo.shading] + [self compareShading:cardThree.shading] + [cardTwo compareShading:cardThree.shading];
    numberMatchCount = [self compareNumbers:cardTwo.number] + [self compareNumbers:cardThree.number] + [cardTwo compareNumbers:cardThree.number];
    if (shapeMatchCount == 1 || colorMatchCount == 1 || numberMatchCount == 1) return 0;
    else {
        self.matched = YES;
        for(SetCard *card in otherCards) {
            card.matched = YES;
        }
        return MATCH_SCORE;
    };
}

- (int)compareShapes:(NSString *)otherShape
{
    if ([_shape isEqualToString:otherShape]) return 1;
    else return 0;
}

- (int)compareColors:(NSString *)otherColor
{
    if ([_color isEqualToString:otherColor]) return 1;
    else return 0;
}

- (int)compareShading:(NSString *)otherShading
{
    if ([_shading isEqualToString:otherShading]) return 1;
    else return 0;
}

- (int)compareNumbers:(NSUInteger)otherNumber
{
    if (_number == otherNumber) return 1;
    else return 0;
}

+ (NSArray *)validShapes
{
    return @[@"diamond", @"oval", @"squiggle"];
}

+ (NSArray *)validColors
{
    return @[@"red", @"green", @"blue"];
}

+ (NSArray *)validShading
{
    return @[@"filled", @"unfilled", @"striped"];
}

+ (NSUInteger)maxNumber
{
    return (NSUInteger)3;
}

- (void)setShape:(NSString *)shape
{
    if ([[SetCard validShapes] containsObject:shape]) {
        _shape = shape;
    }
}

- (NSString *)shape
{
    return _shape ? _shape : @"?";
}

- (void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (NSString *)color
{
    return _color ? _color : @"?";
}

- (void)setShading:(NSString *)shading
{
    if ([[SetCard validShading] containsObject:shading]) {
        _shading = shading;
    }
}

- (NSString *)shading
{
    return _shading ? _shading : @"?";
}

- (void)setNumber:(NSUInteger)number
{
    if (number <= [SetCard maxNumber]) {
        _number = number;
    }
}



@end
