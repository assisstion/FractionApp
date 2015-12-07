//
//  InputHandler.h
//  FractionApp
//
//  Created by Markus Feng on 9/22/15.
//  Copyright (c) 2015 Markus Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calculator.h"

@interface InputHandler : NSObject{
    //The operator to be used for the current operation
    char currentOperator;
    //True if the current numerator has a negative value
    bool currentNumeratorNegative;
    //The absolute value of the current numerator
    int currentNumerator;
    //True if the current denominator has a negative value
    bool currentDenominatorNegative;
    //The absolute value of the current denominator
    int currentDenominator;
    //True if the expected input is an operator
    bool onOperator;
    //True if the expected input is the value of the numerator
    //False if the expected input is the value of the denominator
    bool onNumerator;
    //True if the numerator is empty
    //this is to differentiate between not having a numerator
    //and a having a numerator of zero
    bool numeratorEmpty;
    //True if the denominator is empty
    //this is to differentiate between not having a denominator
    //and a having a denominator of zero
    bool denominatorEmpty;
    
    //Operations on the stack, for use with parenthases
    NSMutableArray * stackOperations;
    //Fractions on the stack, for use with parenthases
    NSMutableArray * stackValues;
    //The number of layers of nested parenthases
    int parens;
}

@property Calculator * calc;

-(void)handleNumber:(int)value;
-(void)handleOperation:(char)operation;
-(NSString *) inputString;
-(NSString *) valueString;
-(NSString *) decimalString;
-(NSString *) parensString;
@end
