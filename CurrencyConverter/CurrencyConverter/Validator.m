//
//  Validator.m
//  CurrencyConverter
//
//  Created by Cooley, Jon on 11/9/16.
//  Copyright © 2016 Cooley, Jon. All rights reserved.
//

#import "Validator.h"

@implementation Validator

+ (BOOL)isDifferentFromCurrency:(NSString *)fromCurrencyType thanToCurrency:(NSString *)toCurrencyType {
    
    if (fromCurrencyType == toCurrencyType) {
        return NO;
    } else {
        return YES;
    }
    
}

+ (BOOL)isValid:(NSString *)fromCurrencyAmountText {
    
    NSDecimalNumber *fromCurrencyAmount;
    
    if (!fromCurrencyAmountText.length) {
        return NO;
    } else if ([fromCurrencyAmount = [NSDecimalNumber decimalNumberWithString:fromCurrencyAmountText] isEqualToNumber:[NSDecimalNumber notANumber]]) {
        // user's entered from currency amount could not be converted
        // to an NSDecimalNumber...
        return NO;
        
    } else if ([fromCurrencyAmount doubleValue] <= 0) {
        
        return NO;
        
    }
    
    return YES;     // we have a valid NSDecimal number > 0
    
}

@end
