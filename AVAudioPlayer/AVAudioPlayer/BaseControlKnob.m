//
//  BaseControlKnob.m
//  AVAudioPlayer
//
//  Created by MiaoGuangfa on 3/25/16.
//  Copyright © 2016 MiaoGuangfa. All rights reserved.
//

#import "BaseControlKnob.h"

@implementation BaseControlKnob

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupView];
    }
    return self;
}


- (void)setupView {
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect {
    NSLog(@"%s, %@", __FUNCTION__, NSStringFromCGRect(rect));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *strokeColor = [UIColor colorWithWhite:0.06 alpha:1.0f];
    UIColor *gradientLightColor = [UIColor colorWithRed:0 green:0.100 blue:0 alpha:1.000];
    UIColor *gradientDarkColor = [UIColor whiteColor];
    
    NSArray *gradientColors = @[(id)gradientDarkColor.CGColor,(id)gradientLightColor.CGColor];
    CGFloat locations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, locations);
    
    CGRect insetRect = CGRectInset(rect, 2.0f, 2.0f);
    
    // Draw Bezel
    CGContextSetFillColorWithColor(context, strokeColor.CGColor);
    CGContextFillEllipseInRect(context, insetRect);
    
    CGFloat midX = CGRectGetMidX(insetRect);
    CGFloat midY = CGRectGetMidY(insetRect);
    NSLog(@"%f, %f", midX, midY);
    // Draw Bezel Light Shadow Layer
    CGContextAddArc(context, midX, midY, CGRectGetWidth(insetRect) / 2, 0, M_PI * 2, 1);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 0.5f), 2.0f, [UIColor darkGrayColor].CGColor);
    CGContextFillPath(context);
    
    // Add Clipping Region for Knob Background
    CGContextAddArc(context, midX, midY, (CGRectGetWidth(insetRect) - 6) / 2, 0, M_PI * 2, 1);
    CGContextClip(context);
    
    CGPoint startPoint = CGPointMake(midX, CGRectGetMaxY(insetRect));
    CGPoint endPoint = CGPointMake(midX, CGRectGetMinY(insetRect));
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}


@end

@implementation GreenControlKnob



@end

@implementation OrangeControlKnob



@end