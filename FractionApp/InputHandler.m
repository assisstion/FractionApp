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
        //Initializes the calculator
        _calc = [[Calculator alloc] init];
        stackOperations = [[NSMutableArray alloc] init];
        stackValues = [[NSMutableArray alloc] init];
        [self resetInput];
    }
    return self;
}


//Handles a button press of a number
-(void)handleNumber:(int)value{
    //If no operator exists, change the operator to "Set"
    if(onOperator){
        currentOperator = 'S';
        onOperator = false;
    }
    //If the numerator is expected, modify the numerator
    if(onNumerator){
        numeratorEmpty = false;
        currentNumerator = currentNumerator * 10 + value;
    }
    //If the denominator is expected, modify the denominator
    else{
        denominatorEmpty = false;
        currentDenominator = currentDenominator * 10 + value;
    }
}

//Handles a button press of an operation
-(void)handleOperation:(char)operation{
    //If the operation is "Clear", immediately activates
    if(operation == 'C'){
        //If no opeartion exists, set the value to zero
        if(onOperator){
            if([[_calc accumulator] numerator] == 0){
                [stackOperations removeAllObjects];
                [stackValues removeAllObjects];
                parens = 0;
            }
            currentOperator = operation;
            [self runOperation];
        }
        //Otherwise, clears the current line of input
        else{
            [self resetInput];
        }
        return;
    }
    //If the operation is "Open Parenthases", immediately activates
    if(operation == '('){
        //True if the parenthases should be multiplied by -1
        bool negate = false;
        //True if the operation should be replaced with "Division"
        bool divide = false;
        if(!onOperator && !numeratorEmpty){
            if(denominatorEmpty){
                currentDenominator = 1;
                if(!onNumerator){
                    divide = true;
                    if(currentDenominatorNegative){
                        negate = true;
                        //Double negative to cancel the RunOperation negative
                        currentDenominator = -1;
                    }
                }
            }
            //Run the operation of the current input if there is any
            [self runOperation];
        }
        if(numeratorEmpty){
            if(currentNumeratorNegative){
                negate = true;
            }
        }
        //If the operator is empty, assign to multiplication by default
        if(currentOperator == ' '){
            if(divide){
                currentOperator = '/';
            }
            else{
                if([[_calc accumulator] numerator] == 0){
                    [_calc setAccumulator:[Fraction with:1 and:1]];
                }
                currentOperator = '*';
            }
        }
        //Add the current accumulator to the stack
        [stackValues addObject:[_calc accumulator]];
        //Add the current operator and the negation to the stack as an NSString
        //index 0: char for operation
        //index 1: "+" if positive, "-" if negative;
        if(negate){
            [stackOperations addObject: [NSString stringWithFormat: @"%c-", currentOperator]];
        }
        else{
            [stackOperations addObject: [NSString stringWithFormat: @"%c+", currentOperator]];
        }
        //Increases the layers of parenthases by 1
        parens++;
        //Sets the accumulator to 0 and clears the input
        [_calc clear];
        [self resetInput];
        return;
    }
    //If the operation is "Close Parenthases", immediately activates
    if(operation == ')'){
        [self closeParen];
        return;
    }
    //If the equals operation is run while the input is empty
    //calculates all of the operations on the parenthases stack
    if(operation == ' ' && onOperator && parens > 0){
        bool working = true;
        while(working){
            working = [self closeParen];
        }
        return;
    }
    if(!onOperator && !numeratorEmpty){
        if(onNumerator){
            //Make the value a fraction
            if(operation == '/'){
                onNumerator = false;
            }
            //Run the pervious operation, then set the next operation to the input
            else{
                currentDenominator = 1;
                [self runOperation];
                [self updateOperation: operation];
            }
        }
        else{
            //Change the value to the negative value
            if(denominatorEmpty && operation == '-'){
                currentDenominatorNegative = !currentDenominatorNegative;
            }
            //Run the pervious operation, then set the next operation to the input
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
        //Change the value to the negative value
        if(!onOperator && numeratorEmpty && operation == '-'){
            currentNumeratorNegative = !currentNumeratorNegative;
        }
        //Set the operation
        else{
            [self updateOperation: operation];
        }
    }
}

//Close a parenthases
//Returns true if a parenthases is closed, false otherwise
-(bool)closeParen{
    if(parens == 0){
        return false;
    }
    if(!onOperator && !numeratorEmpty){
        if(denominatorEmpty){
            currentDenominator = 1;
        }
        //Run the operation of the current input if there is any
        [self runOperation];
    }
    
    //Reduces the layers of parenthases by 1
    parens--;
    
    //Pops the stack for the information of the last added object
    Fraction * fraction = [stackValues lastObject];
    char op = [[stackOperations lastObject] characterAtIndex:0];
    char negative = [[stackOperations lastObject] characterAtIndex:1];
    [stackValues removeLastObject];
    [stackOperations removeLastObject];
    
    //Move the value of the current accumulator to the current operation
    currentOperator = op;
    currentNumerator = [[_calc accumulator] numerator];
    if(negative == '-'){
        currentNumerator = currentNumerator * -1;
    }
    currentDenominator = [[_calc accumulator] denominator];
    
    //Moves the fraction from the stack to the accumulator
    [_calc setAccumulator:fraction];
    [self runOperation];
    return true;
}

//Set the operation to a different value
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

//Runs an operation, clearing the input and updating the accumulator
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

//Clears the input
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

//Returns the string for the input display
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

//Returns the string for the accumulator display
-(NSString *)valueString{
    Fraction * frac = [_calc accumulator];
    return [NSString stringWithFormat:@"%i/%i", [frac numerator], [frac denominator]];
}

//Returns the string for the decimal value display
-(NSString *)decimalString{
    Fraction * frac = [_calc accumulator];
    return [NSString stringWithFormat: @"%f", [frac doubleValue]];
}

//Returns the string for the parenthases display
-(NSString *)parensString{
    NSString * value = @"";
    //Loops through the stack to for the display
    for (int i = 0; i < [stackValues count]; i++) {
        Fraction * frac = stackValues[i];
        char op = [stackOperations[i] characterAtIndex:0];
        NSString * negate = @"";
        if([stackOperations[i] characterAtIndex:1] == '-'){
            negate = @"-";
        }
        value = [NSString stringWithFormat:@"%@%i/%i%c%@(", value, [frac numerator], [frac denominator], op, negate];
    }
    return value;
}
@end
