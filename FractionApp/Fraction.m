//
//  Fraction.m
//  FractionCalculator
//
//  Created by Markus Feng on 9/17/15.
//  Copyright (c) 2015 Markus Feng. All rights reserved.
//

#import "Fraction.h"

@implementation Fraction

-(void)setNumerator: (int)n{
    numerator = n;
}

-(void)setDenominator: (int)d{
    denominator = d;
}

-(int)numerator{
    return numerator;
}

-(int)denominator{
    return denominator;
}
-(void)simplify{
    //No factor can be higher than this value;
    if(denominator == 0){
        if(numerator != 0){
            numerator = 1;
        }
        return;
    }
    if(numerator == 0){
        denominator = 1;
        return;
    }
    int highestFactor = MAX(numerator, denominator);
    for(int i = 2; i <= highestFactor; i++){
        //If a common factor is found
        if(numerator % i == 0 && denominator % i == 0){
            //Divide by the common factor
            numerator /= i;
            denominator /= i;
            //Simplify again
            [self simplify];
            return;
        }
    }
    //Move negative sign from denominator up to numerator
    if(denominator < 0){
        numerator *= -1;
        denominator *= -1;
    }
}
-(NSString *)toString{
    return [NSString stringWithFormat:@"%i/%i", numerator, denominator];
}

+(Fraction *)with: (int)numerator and: (int)denominator{
    Fraction * fraction = [[Fraction alloc] init];
    [fraction setNumerator:numerator];
    [fraction setDenominator:denominator];
    return fraction;
}
-(double)doubleValue{
    return ((double)[self numerator]) / [self denominator];
}
@end
