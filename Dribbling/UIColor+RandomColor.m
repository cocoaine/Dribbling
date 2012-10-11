//
//  UIColor+RandomColor.m
//  Dribbling
//
//  Created by J.C. Yang on 12. 10. 10..
//  Copyright (c) 2012년 Cocoaine Team. All rights reserved.
//

#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)

+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha {
    CGFloat red =  (CGFloat)arc4random() / (CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)arc4random() / (CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)arc4random() / (CGFloat)RAND_MAX;
	
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
