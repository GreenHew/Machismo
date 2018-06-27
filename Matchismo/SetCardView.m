//
//  SetCardView.m
//  SuperCard
//
//  Created by Matthew Green on 6/1/17.
//  Copyright © 2017 Matthew Green. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

#pragma mark - Properties

- (void)setShape:(NSString *)shape
{
    _shape = shape;
    [self setNeedsDisplay];
}

- (void)setColor:(NSString *)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (void)setShading:(NSString *)shading
{
    _shading = shading;
    [self setNeedsDisplay];
}

-(void)setNumber:(NSUInteger)number
{
    _number = number;
    [self setNeedsDisplay];
}

#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0
#define SHAPE_SPACING_PERCENTAGE 0.02

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)shapeWhiteSpace { return SHAPE_SPACING_PERCENTAGE * self.bounds.size.height; }

- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    NSMutableArray *shapes = [[NSMutableArray alloc] init];
    for (int i = 0; i < _number; i ++) {
        if (_number == 2) {
            if (i == 0) [shapes addObject:[self getDrawnShape:self.bounds.size.height * 0.135]];
            if (i == 1) [shapes addObject:[self getDrawnShape:-self.bounds.size.height * 0.135]];
        }
        else {
            if (i == 0) [shapes addObject:[self getDrawnShape:0.0]];
            if (i == 1) [shapes addObject:[self getDrawnShape:self.bounds.size.height * 0.27]];
            if (i == 2) [shapes addObject:[self getDrawnShape:-self.bounds.size.height * 0.27]];
        }
    }
    for (UIBezierPath *shape in shapes) {
        [[self getShapeColor] set];
        [shape setLineWidth:[self scaledShapeWidth] * .02];
        [shape stroke];
        if ([_shading isEqualToString:@"filled"]) {
            [shape fill];
        }
        if ([_shading isEqualToString:@"striped"]) {
            [self drawStripes:shape];
        }
    }
}

#pragma mark - Shapes

#define HSCALE_PERCENTAGE 0.75
#define VSCALE_PERCENTAGE 0.25

- (CGFloat)scaledShapeWidth { return self.bounds.size.width * HSCALE_PERCENTAGE; }
- (CGFloat)scaledShapeHeight { return self.bounds.size.height * VSCALE_PERCENTAGE; }

-(UIBezierPath *)getDrawnShape:(CGFloat)voffset
{
    if ([_shape isEqualToString:@"diamond"]) return [self drawDiamond:voffset];
    if ([_shape isEqualToString:@"oval"]) return [self drawOval:voffset];
    if ([_shape isEqualToString:@"squiggle"]) return [self drawSquiggle:voffset];
    else return nil;
}

-(UIBezierPath *)drawDiamond:(CGFloat)voffset
{
    // points of diamond shape in clockwise order starting at leftmost point
    CGPoint start = CGPointMake(self.bounds.size.width * 0.125, self.bounds.size.height/2 - voffset);
    CGPoint point1 = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2 - voffset - [self scaledShapeHeight]/2);
    CGPoint point2 = CGPointMake(start.x + [self scaledShapeWidth], start.y);
    CGPoint point3 = CGPointMake(point1.x, point1.y + [self scaledShapeHeight]);
    
    UIBezierPath *diamond = [[UIBezierPath alloc] init];
    [diamond moveToPoint:start];
    [diamond addLineToPoint:point1];
    [diamond addLineToPoint:point2];
    [diamond addLineToPoint:point3];
    [diamond closePath];
    return diamond;
    
}

- (UIBezierPath *)drawOval:(CGFloat)voffset
{
    UIBezierPath *oval = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.bounds.size.width * 0.125,
                                                                            self.bounds.size.height/2 - [self scaledShapeHeight]/2 - voffset,
                                                                            [self scaledShapeWidth],
                                                                            [self scaledShapeHeight])];
    return oval;
}

- (UIBezierPath *)drawSquiggle:(CGFloat)voffset
{
    
    CGSize size = CGSizeMake(self.bounds.size.width * .75, self.bounds.size.height * .25);
    CGPoint point = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2 - voffset);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(104, 15)];
    [path addCurveToPoint:CGPointMake(63, 54) controlPoint1:CGPointMake(112.4, 36.9) controlPoint2:CGPointMake(89.7, 60.8)];
    [path addCurveToPoint:CGPointMake(27, 53) controlPoint1:CGPointMake(52.3, 51.3) controlPoint2:CGPointMake(42.2, 42)];
    [path addCurveToPoint:CGPointMake(5, 40) controlPoint1:CGPointMake(9.6, 65.6) controlPoint2:CGPointMake(5.4, 58.3)];
    [path addCurveToPoint:CGPointMake(36, 12) controlPoint1:CGPointMake(4.6, 22) controlPoint2:CGPointMake(19.1, 9.7)];
    [path addCurveToPoint:CGPointMake(89, 14) controlPoint1:CGPointMake(59.2, 15.2) controlPoint2:CGPointMake(61.9, 31.5)];
    [path addCurveToPoint:CGPointMake(104, 15) controlPoint1:CGPointMake(95.3, 10) controlPoint2:CGPointMake(100.9, 6.9)];
    
    [path applyTransform:CGAffineTransformMakeScale(0.9524*size.width/100, 0.9524*size.height/50)];
    [path applyTransform:CGAffineTransformMakeTranslation(point.x - size.width/2 - 3 * size.width /100, point.y - size.height/2 - 8 * size.height/50)];
    return path;

}

#pragma mark - Colors and Shading

- (UIColor *)getShapeColor
{
    if ([_color isEqualToString:@"green"]) {
        return [UIColor greenColor];
    }
    else if ([_color isEqualToString:@"red"]) {
        return [UIColor redColor];
    }
    else if ([_color isEqualToString:@"blue"]) {
        return [UIColor blueColor];
    }
    else return [UIColor blackColor];
}

- (void)drawStripes:(UIBezierPath *)shape
{
    int stripeInterval = (int)([self scaledShapeWidth] *0.07);
    CGRect bounds = shape.bounds;
    UIBezierPath *stripes = [[UIBezierPath alloc] init];
    for (int x = 0; x <= bounds.size.width; x += stripeInterval)
    {
        [stripes moveToPoint:CGPointMake(bounds.origin.x + x, bounds.origin.y)];
        [stripes addLineToPoint:CGPointMake(bounds.origin.x + x, bounds.origin.y + bounds.size.height)];
    }
    [stripes setLineWidth:[self scaledShapeWidth] * .01];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [shape addClip];
    [[self getShapeColor] set];
    [stripes stroke];
    CGContextRestoreGState(context);

}

#pragma mark - Initialization 

- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

@end
