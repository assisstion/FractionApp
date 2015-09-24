//
//  InputHandler.m
//  FractionApp
//
//  Created by Markus Feng on 9/22/15.
//  Copyright (c) 2015 Markus Feng. All rights reserved.
//

#import "InputHandler.h"

@implementation InputHandler

-(id)init{
    if(self){
        onOperator = true;
        onNumerator = true;
        numeratorEmpty = true;
        denominatorEmpty = true;
        currentNumerator = 0;
        currentDenominator = 0;
    }
    return self;
}


-(void)handleNumber:(int)value{
    if(onOperator){
        currentOperator = 'S';
        onOperator = false;
    }
    if(onNumerator){
        numeratorEmpty = false;
        currentNumerator = currentNumerator * 10 + value;
    }
    else{
        denominatorEmpty = false;
        currentDenominator = currentDenominator * 10 + value;
    }
}

-(void)handleOperation:(char)operation{
    if(operation == 'C'){
        if(onOperator){
            currentOperator = operation;
            [self runOperation];
            return;
        }
        else{
            [self resetInput];
            return;
        }
    }
    if(!onOperator && !numeratorEmpty){
        if(onNumerator){
            if(operation == '/'){
                onNumerator = false;
            }
            else{
                currentDenominator = 1;
                [self runOperation];
                [self updateOperation: operation];
            }
        }
        else{
            if(denominatorEmpty && operation == '-'){
                currentDenominatorNegative = !currentDenominatorNegative;
            }
            else{
                if(denominatorEmpty){
                    currentDenominator = 1;
                }
                [self runOperation];
                [self updateOperation: operation];
            }
        }
    }
    else{
        if(!onOperator && numeratorEmpty && operation == '-'){
            currentNumeratorNegative = !currentNumeratorNegative;
        }
        else{
            [self updateOperation: operation];
        }
    }
}

-(void)updateOperation: (char) operation{
    currentOperator = operation;
    if(currentOperator != ' '){
        onOperator = false;
    }
    else{
        onOperator = true;
    }
    currentNumeratorNegative = false;
}

-(void)runOperation{
    if(currentOperator == ' '){
        return;
    }
    int numerator = currentNumerator;
    if(currentNumeratorNegative){
        numerator = -numerator;
    }
    int denominator = currentDenominator;
    if(currentDenominatorNegative){
        denominator = -denominator;
    }
    [_calc operate:[Fraction with: numerator and:denominator] with:currentOperator];
    [_calc simplify];
    [self resetInput];
}

-(void)resetInput{
    onOperator = true;
    onNumerator = true;
    numeratorEmpty = true;
    denominatorEmpty = true;
    currentNumeratorNegative = false;
    currentDenominatorNegative = false;
    currentNumerator = 0;
    currentDenominator = 0;
    currentOperator = ' ';
}

-(NSString *)inputString{
    if(onOperator){
        return @"";
    }
    else{
        NSString * numeratorString = @"";
        if(currentNumeratorNegative){
            numeratorString = @"-";
        }
        NSString * denominatorString = @"";
        if(currentDenominatorNegative){
            denominatorString = @"-";
        }
        if(onNumerator){
            if(numeratorEmpty){
                return [NSString stringWithFormat:@"%c%@", currentOperator, numeratorString];
            }
            else{
                return [NSString stringWithFormat:@"%c%@%i", currentOperator, numeratorString, currentNumerator];
            }
        }
        else{
            if(denominatorEmpty){
                return [NSString stringWithFormat:@"%c%@%i/%@", currentOperator, numeratorString, currentNumerator, denominatorString];
            }
            else{
                return [NSString stringWithFormat:@"%c%@%i/%@%i", currentOperator, numeratorString, currentNumerator, denominatorString, currentDenominator];
            }
        }
    }
}

-(NSString *)valueString{
    Fraction * frac = [_calc accumulator];
    return [NSString stringWithFormat:@"%i/%i", [frac numerator], [frac denominator]];
}

-(NSString *)decimalString{
    Fraction * frac = [_calc accumulator];
    return [NSString stringWithFormat: @"%f", [frac doubleValue]];
}
@end
