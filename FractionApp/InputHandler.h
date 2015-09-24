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
    char currentOperator;
    bool currentNumeratorNegative;
    int currentNumerator;
    bool currentDenominatorNegative;
    int currentDenominator;
    bool onOperator;
    bool onNumerator;
    bool numeratorEmpty;
    bool denominatorEmpty;
}

@property Calculator * calc;

-(void)handleNumber:(int)value;
-(void)handleOperation:(char)operation;
-(NSString *) inputString;
-(NSString *) valueString;
-(NSString *) decimalString;
@end
