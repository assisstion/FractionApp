//
//  ViewController.m
//  FractionApp
//
//  Created by Markus Feng on 9/22/15.
//  Copyright (c) 2015 Markus Feng. All rights reserved.
//

#import "ViewController.h"
#import "Fraction.h"
#import "Calculator.h"
#import "InputHandler.h"

@interface ViewController ()
@property InputHandler * handler;
@property (weak, nonatomic) IBOutlet UILabel *inputLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *decimalLabel;
@property (weak, nonatomic) IBOutlet UILabel *parensLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Allocates and initializes the input handler
    _handler = [[InputHandler alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Handles a button press of a number button
//by sending the operation to the input handler
-(void)handleNumber:(int)value{
    [_handler handleNumber:value];
    [self refresh];
}

//Handles a button press of an operation button
//by sending the operation to the input handler
-(void)handleOperation:(char)operation{
    [_handler handleOperation:operation];
    [self refresh];
}

//Set the text in the display to the current values
//Finds the values in the input handler
-(void)refresh{
    _inputLabel.text = [_handler inputString];
    _valueLabel.text = [_handler valueString];
    _decimalLabel.text = [_handler decimalString];
    _parensLabel.text = [_handler parensString];
}


//The following are all outlets for the buttons
//They call either the handleNumber function
//or the handleOperation function

- (IBAction)buttonOne:(id)sender {
    [self handleNumber:1];
}
- (IBAction)buttonTwo:(id)sender {
    [self handleNumber:2];
}
- (IBAction)buttonThree:(id)sender {
    [self handleNumber:3];
}
- (IBAction)buttonFour:(id)sender {
    [self handleNumber:4];
}
- (IBAction)buttonFive:(id)sender {
    [self handleNumber:5];
}
- (IBAction)buttonSix:(id)sender {
    [self handleNumber:6];
}
- (IBAction)buttonSeven:(id)sender {
    [self handleNumber:7];
}
- (IBAction)buttonEight:(id)sender {
    [self handleNumber:8];
}
- (IBAction)buttonNine:(id)sender {
    [self handleNumber:9];
}
- (IBAction)buttonZero:(id)sender {
    [self handleNumber:0];
}
- (IBAction)buttonPlus:(id)sender {
    [self handleOperation:'+'];
}
- (IBAction)buttonMinus:(id)sender {
    [self handleOperation:'-'];
}
- (IBAction)buttonTimes:(id)sender {
    [self handleOperation:'*'];
}
- (IBAction)buttonDivide:(id)sender {
    [self handleOperation:'/'];
}
- (IBAction)buttonSet:(id)sender {
    [self handleOperation:'S'];
}
- (IBAction)buttonClear:(id)sender {
    [self handleOperation:'C'];
}
- (IBAction)buttonCalculate:(id)sender {
    [self handleOperation:' '];
}
- (IBAction)buttonLeftParen:(id)sender {
    [self handleOperation:'('];
}
- (IBAction)buttonRightParen:(id)sender {
    [self handleOperation:')'];
}


@end
