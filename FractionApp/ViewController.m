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
@property Calculator * calc;
@property InputHandler * handler;
@property (weak, nonatomic) IBOutlet UILabel *inputLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *decimalLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _calc = [[Calculator alloc] init];
    _handler = [[InputHandler alloc] init];
    _handler.calc = _calc;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)handleNumber:(int)value{
    [_handler handleNumber:value];
    [self refresh];
}

-(void)refresh{
    _inputLabel.text = [_handler inputString];
    _valueLabel.text = [_handler valueString];
    _decimalLabel.text = [_handler decimalString];
}


-(void)handleOperation:(char)operation{
    [_handler handleOperation:operation];
    [self refresh];
}

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


@end
