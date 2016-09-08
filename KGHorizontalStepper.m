//
//  KGHorizontalStepper.m
//  kangaroo
//
//  Created by ChenyangZhao on 9/2/16.
//  Copyright © 2016 HaveFunCraft. All rights reserved.
//

#import "KGHorizontalStepper.h"

@interface KGHorizontalStepper ()

@property (strong, nonatomic) UIColor * defaultBaseColor;

@end

@implementation KGHorizontalStepper {
    CAShapeLayer * maskLayer;
    CAShapeLayer * moveLayer;
    UIView * baseView;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initConfig];
    }
    return self;
}
- (instancetype)initWithCoder: (NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initConfig];
    }
    return self;
}

- (void) initConfig { // initialize all views
    _defaultBaseColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00];
    maskLayer = [CAShapeLayer layer];
}
- (void)layoutSubviews {
    [super layoutSubviews]; // remove exiting views
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self configureElementsOnBase: NO];

    baseView = [[UIView alloc] initWithFrame:self.bounds];
    maskLayer.frame = baseView.frame;
    [self addSubview: baseView];
    [self configureElementsOnBase: YES];
    [self bringSubviewToFront:baseView];
//    [self configMaskLayer];
}

- (void) configureElementsOnBase: (BOOL) isOnBase {
    if (_stepCount == 0) { return; }

    CGFloat lineHeight = [_maxLineHeight floatValue] ? [_maxLineHeight floatValue] : [_pointRadius floatValue];
    CGFloat unitLineWidth = (self.frame.size.width - 2 * [_pointRadius floatValue]) / ([_stepCount integerValue] - 1);
    CGSize pointSize = CGSizeMake([_pointRadius floatValue] * 2, [_pointRadius floatValue] * 2);

    for (NSInteger index = 0; index < [_stepCount integerValue]; index++ ) {

        CGRect pointRect = CGRectMake(index * (unitLineWidth + [_pointRadius floatValue]), self.frame.size.height / 2 - [_pointRadius floatValue], pointSize.width, pointSize.height);
        if (index < [_currentLevel integerValue]) {
            // achieved
            [self addPointOnBaseWithFrame:pointRect onBase:isOnBase andAchieved: YES];
        }
        else {
            [self addPointOnBaseWithFrame:pointRect onBase:isOnBase andAchieved: NO];
        }

        if (index < [_stepCount integerValue] - 1){
            CGRect unitLineRect = CGRectMake(pointRect.origin.x + pointRect.size.width, (self.frame.size.height - lineHeight) / 2, unitLineWidth, lineHeight);

            if (index < [_currentLevel integerValue] - 1){
                [self addLineOnBaseWithFrame:unitLineRect onBase:isOnBase andAchieved: YES];
            }
            else{
                [self addLineOnBaseWithFrame:unitLineRect onBase:isOnBase andAchieved: NO];
            }
        }
    }
}

- (void) addLineOnBaseWithFrame: (CGRect) frame onBase: (BOOL) isOnBase andAchieved: (BOOL) done {
    UIView * lineRectView = [[UIView alloc] initWithFrame: frame];
    if (isOnBase && done) {
        lineRectView.backgroundColor = _achievedColor ? _achievedColor :[UIColor blueColor];
    } else {
        lineRectView.backgroundColor = _unachievedColor ? _unachievedColor : _defaultBaseColor;
    }
    if (isOnBase) {
        [baseView addSubview:lineRectView];
    } else {
        [self addSubview:lineRectView];
    }
}

- (void) addPointOnBaseWithFrame: (CGRect) frame onBase: (BOOL) isOnBase andAchieved: (BOOL) done {
    UIView * pointRectView = [[UIView alloc] initWithFrame:frame];
    CAShapeLayer *pointLayer = [CAShapeLayer layer];
    pointLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    pointLayer.path = [UIBezierPath bezierPathWithArcCenter:pointLayer.position
                                                     radius:[_pointRadius floatValue]
                                                 startAngle:0.0f
                                                   endAngle: 2.0 * M_PI
                                                  clockwise:YES].CGPath;
    pointLayer.strokeColor = [UIColor whiteColor].CGColor;
    pointLayer.lineWidth = 2.0f;
    pointLayer.fillRule = kCAFillRuleNonZero;
    pointRectView.layer.cornerRadius = pointRectView.frame.size.width / 2;

    if (isOnBase && done) {
        pointLayer.fillColor = _achievedColor.CGColor ? _achievedColor.CGColor :[UIColor blueColor].CGColor;
    } else {
        pointLayer.fillColor = _unachievedColor.CGColor ? _unachievedColor.CGColor : _defaultBaseColor.CGColor;
    }

    [pointRectView.layer addSublayer: pointLayer];

    if (isOnBase) {
        [baseView addSubview: pointRectView];
    } else {
        [self addSubview:pointRectView];
    }
}

- (void) configMaskLayer {
    moveLayer = [CAShapeLayer layer];
    moveLayer.bounds = maskLayer.bounds;
    moveLayer.path = [UIBezierPath bezierPathWithRect:maskLayer.bounds].CGPath;
    moveLayer.fillColor = [UIColor colorWithRed:0.96 green:0.42 blue:0.20 alpha:0.50].CGColor;
    moveLayer.position = CGPointMake(- maskLayer.bounds.size.width / 2, maskLayer.bounds.size.height / 2);
    [maskLayer addSublayer:moveLayer];
    baseView.layer.mask = maskLayer;
}

- (void) startAnimation {
    CABasicAnimation *rightAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    rightAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(- maskLayer.bounds.size.width / 2, maskLayer.bounds.size.height / 2)];
    rightAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(maskLayer.bounds.size.width /2, maskLayer.bounds.size.height / 2)];
    rightAnimation.duration = _animationDuration ? _animationDuration : 5;
    rightAnimation.repeatCount = 3;
    rightAnimation.removedOnCompletion = NO;
    [moveLayer addAnimation:rightAnimation forKey:@"rightAnimation"];
}
@end
