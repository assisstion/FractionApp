//
//  Calculator.m
//  FractionCalculator
//
//  Created by Markus Feng on 9/17/15.
//  Copyright (c) 2015 Markus Feng. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

-(id)init{
    if(self) {
        [self clear];
    }
    return self;
}

-(bool)process{
    
    int numerator;
    printf("Numerator: ");
    scanf("%i", &numerator);
    
    int denominator;
    printf("Denominator: ");
    scanf("%i", &denominator);
    
    if(denominator == 0){
        printf("Denominator cannot be zero!\n");
        return true;
    }
    
    char operator;
    printf("Operator: ");
    scanf(" %c", &operator);
    
    Fraction * fraction = [Fraction with:numerator and:denominator];
    //NSLog(@"%i/%i", [fraction numerator], [fraction denominator]);

    [self operate:fraction with:operator];
    
    [self simplify];
    printf("Accumulator value: %i/%i\n", [accumulator numerator], [accumulator denominator]);
    return true;
    
}

-(bool)operate: (Fraction *) fraction with: (char) operator{
    switch (operator) {
        case '+':
            [self addFraction:fraction];
            break;
        case '-':
            [self subtractFraction:fraction];
            break;
        case '*':
            [self multiplyFraction:fraction];
            break;
        case '/':
            [self divideFraction:fraction];
            break;
        case 'S':
            [self setFraction:fraction];
            break;
        case 'C':
            [self clear];
            break;
        case 'E':
            return false;
        default:
            NSLog(@"Invalid input!");
            break;
    }
    return true;
}

-(void)simplify{
    [accumulator simplify];
}

-(void)addFraction: (Fraction *) fraction{
    int newNumerator = [accumulator numerator] * [fraction denominator]
        + [accumulator denominator] * [fraction numerator];
    int newDenominator = [accumulator denominator] * [fraction denominator];
    accumulator = [Fraction with:newNumerator and:newDenominator];
}
-(void)subtractFraction: (Fraction *) fraction{
    int newNumerator = [accumulator numerator] * [fraction denominator]
        - [accumulator denominator] * [fraction numerator];
    int newDenominator = [accumulator denominator] * [fraction denominator];
    accumulator = [Fraction with:newNumerator and:newDenominator];
}
-(void)multiplyFraction: (Fraction *) fraction{
    int newNumerator = [accumulator numerator] * [fraction numerator];
    int newDenominator = [accumulator denominator] * [fraction denominator];
    accumulator = [Fraction with:newNumerator and:newDenominator];
}
-(void)divideFraction: (Fraction *) fraction{
    int newNumerator = [accumulator numerator] * [fraction denominator];
    int newDenominator = [accumulator denominator] * [fraction numerator];
    accumulator = [Fraction with:newNumerator and:newDenominator];
}
-(void)setFraction: (Fraction *) fraction{
    int newNumerator = [fraction numerator];
    int newDenominator = [fraction denominator];
    accumulator = [Fraction with:newNumerator and:newDenominator];
}
-(Fraction *)accumulator{
    return accumulator;
}
-(void)clear{
    accumulator = [Fraction with:0 and:1];
}

@end
