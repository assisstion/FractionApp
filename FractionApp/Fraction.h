//
//  Fraction.h
//  FractionCalculator
//
//  Created by Markus Feng on 9/17/15.
//  Copyright (c) 2015 Markus Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fraction : NSObject{
    int numerator;
    int denominator;
}

-(void)setNumerator: (int)n;
-(void)setDenominator: (int)d;
-(int)numerator;
-(int)denominator;
-(NSString *)toString;
-(void)simplify;
+(Fraction *)with: (int)numerator and: (int)denominator;
-(double)doubleValue;
@end
