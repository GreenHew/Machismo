//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Matthew Green on 5/26/17.
//  Copyright © 2017 Matthew Green. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
