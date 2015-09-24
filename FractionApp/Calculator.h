//
//  Calculator.h
//  FractionCalculator
//
//  Created by Markus Feng on 9/17/15.
//  Copyright (c) 2015 Markus Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fraction.h"

@interface Calculator : NSObject{
    Fraction * accumulator;
}

-(bool)process;
-(bool)operate: (Fraction *) fraction with: (char) operation;
-(void)addFraction: (Fraction *) fraction;
-(void)subtractFraction: (Fraction *) fraction;
-(void)multiplyFraction: (Fraction *) fraction;
-(void)divideFraction: (Fraction *) fraction;
-(void)setFraction: (Fraction *) fraction;
-(Fraction *)accumulator;
-(void)clear;
-(void)simplify;

@end
