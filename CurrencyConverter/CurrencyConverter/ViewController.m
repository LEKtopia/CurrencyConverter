//
//  ViewController.m
//  CurrencyConverter
//
//  Created by Cooley, Jon on 11/7/16.
//  Copyright © 2016 Cooley, Jon. All rights reserved.
//

#import "ViewController.h"
#import "Validator.h"
#import "CurrencyRateModel.h"

@interface ViewController () {
    
    // Declare private instance variables (properties) here.
    //
    // Note: Cannot initialize any of them here - must
    //       do that in the @implementation block
    NSArray *_pickerFromData;
    NSArray *_pickerToData;
    
    // These will be used as indexes into the above arrays
    NSInteger selectedFromCurrency;
    NSInteger selectedToCurrency;
    
    NSString *fromCurrencyType;
    NSString *toCurrencyType;
    
    NSDecimalNumber *oneHundred;
    NSDecimalNumber *rateFrom;
    NSDecimalNumber *fromAmount;
    NSDecimalNumber *toAmount;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Alter appearance of our button outlet
    convertButton.layer.cornerRadius = 8;
    convertButton.layer.borderWidth = .5;
    convertButton.layer.borderColor = [UIColor blueColor].CGColor;
    
    // Initialize PickerView data in our array instance variables
    _pickerFromData = @[@"US Dollar", @"Euro", @"British Pound", @"Japanese Yen"];
    
    _pickerToData = @[@"Euro", @"US Dollar", @"British Pound", @"Japanese Yen"];
    
    // Connect the above data to our PickerViews
    //
    // Set our ViewController as the datasource and delegate of our
    // PickerViews...
    self.pickerFrom.dataSource = self;
    self.pickerFrom.delegate = self;
    
    self.pickerTo.dataSource = self;
    self.pickerTo.delegate = self;
}


// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // Note: shortcut _pickerFrom is same as self.pickerFrom
    if (pickerView == _pickerFrom) {
        return _pickerFromData.count;
    } else if (pickerView == _pickerTo) {
        return _pickerToData.count;
    }
    
    return 0;
    
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (pickerView == _pickerFrom) {
        return _pickerFromData[row];
    } else if (pickerView == _pickerTo) {
        return _pickerToData[row];
    }
    
    return @"";

}


// Capture the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameters named row and component represent what was selected.
    
    if (pickerView == _pickerFrom) {
        selectedFromCurrency = row;
    } else if (pickerView == _pickerTo) {
        selectedToCurrency = row;
    }
    
}



- (IBAction)convertCurrency {
    
    //responseLabel.text = [NSString stringWithFormat:@"%li = %@\n%li = %@", selectedFromCurrency, _pickerFromData[selectedFromCurrency], selectedToCurrency, _pickerToData[selectedToCurrency]];
    
    fromCurrencyType = _pickerFromData[selectedFromCurrency];
    toCurrencyType = _pickerToData[selectedToCurrency];
    
    // Validate the user's input
    //
    // 1) Ensure the from Currency is different than the to Currency
    // 2) Then, check validity of entered from Currency amount
    
    if ([Validator isDifferentFromCurrency:fromCurrencyType thanToCurrency:toCurrencyType]) {
        
        // NSLog(@"selected currencies are different\nFrom currency: %@\nTo currency: %@", _pickerFromData[selectedFromCurrency], _pickerToData[selectedToCurrency]);
        
        // Now, check if entered from amount is valid
        if ([Validator isValid:(fromAmountTextField.text)]) {
        
            // responseLabel.text = @"Yay, our currency amount is valid.";
            
            
            // Start our currency conversion work...
            //  (Model (data, date-related, conversions, not data from the user) (using a dictionary (Apple's term) - associative array)
            // Get the exchange rate to use in our currency conversion
            rateFrom = [CurrencyRateModel exchangeRateFrom:fromCurrencyType to:toCurrencyType];
            
            // Now that we know that it's safe (validated) to convert fromAmountTextField.text...
            fromAmount = [NSDecimalNumber decimalNumberWithString:fromAmountTextField.text];
            
            // Round up our result to two decimal places...
            NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundUp scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];

            // Convert an integer constant of 100 to be an NSDecimalNumber instead
            oneHundred = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInt:100] decimalValue]];
            
            // Display exchange rate for a single fromCurrency type to a  single
            // toCurrency type
            responseLabel.text = [NSString stringWithFormat:@"1 %@ equals\n%@ %@", fromCurrencyType, rateFrom, toCurrencyType];
            
            // Multiply exhange rate by 100
            rateFrom = [rateFrom decimalNumberByMultiplyingBy:oneHundred];
            
            // Convert
            toAmount = [[fromAmount decimalNumberByMultiplyingBy:rateFrom] decimalNumberByDividingBy:oneHundred withBehavior:roundUp];
            
            // Place result in toAmountTextField
            toAmountTextField.text = [NSNumberFormatter localizedStringFromNumber:toAmount numberStyle:NSNumberFormatterCurrencyStyle];
            
            
            
            
        } else {
            responseLabel.text = @"Invalid amount!  Please enter a valid amount for the currency you wish to convert from.";
            
            fromAmountTextField.text = @"";     // Clear text field
            
        }
        
    } else {
        responseLabel.text = @"Your convert from and convert to currencies must be different!  Please change at least one of your currency types.";
    }
    
}
@end
