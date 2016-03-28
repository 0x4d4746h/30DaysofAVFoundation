//
//  BaseControlKnob.h
//  AVAudioPlayer
//
//  Created by MiaoGuangfa on 3/25/16.
//  Copyright © 2016 MiaoGuangfa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseControlKnob : UIControl

@property (nonatomic, assign) float maxValue;
@property (nonatomic, assign) float minValue;
@property (nonatomic, assign) float value;

@end


@interface GreenControlKnob : BaseControlKnob

@end

@interface OrangeControlKnob : BaseControlKnob

@end