//
//  KGHorizontalStepper.h
//  kangaroo
//
//  Created by ChenyangZhao on 9/2/16.
//  Copyright © 2016 HaveFunCraft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KGHorizontalStepper : UIView

@property (strong, nonatomic) NSNumber * stepCount;
@property (strong, nonatomic) NSNumber * currentLevel;
@property (strong, nonatomic) NSNumber * pointRadius;
@property (strong, nonatomic) NSNumber * maxLineHeight;

@property (strong, nonatomic) UIColor * achievedColor;
@property (strong, nonatomic) UIColor * unachievedColor;

@property CFTimeInterval animationDuration;

-(void)startAnimation;

@end
