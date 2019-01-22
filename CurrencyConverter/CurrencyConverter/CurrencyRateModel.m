//
//  CurrencyRateModel.m
//  CurrencyConverter
//
//  Created by Cooley, Jon on 11/9/16.
//  Copyright © 2016 Cooley, Jon. All rights reserved.
//

#import "CurrencyRateModel.h"

@implementation CurrencyRateModel

// Initialize public contants
NSString *const USDollar = @"US Dollar";
NSString *const Euro = @"Euro";
NSString *const BritishPound = @"British Pound";
NSString *const Yen = @"Japanese Yen";


+ (NSDecimalNumber *)exchangeRateFrom:(NSString *)fromCurrency to:(NSString *)toCurrency {
    
    // Define our dictionary...
    NSDictionary *conversionRates = @{
                                      USDollar : @{
                                              Euro : [NSDecimalNumber decimalNumberWithString:@"0.94"],
                                              BritishPound : [NSDecimalNumber decimalNumberWithString:@"0.80"],
                                              Yen : [NSDecimalNumber decimalNumberWithString:@"109.14"],
                                              },
                                      Euro : @{
                                              USDollar : [NSDecimalNumber decimalNumberWithString:@"1.07"],
                                              BritishPound : [NSDecimalNumber decimalNumberWithString:@"0.86"],
                                              Yen : [NSDecimalNumber decimalNumberWithString:@"116.57"],
                                              },
                                      BritishPound : @{
                                              Euro : [NSDecimalNumber decimalNumberWithString:@"1.16"],
                                              USDollar : [NSDecimalNumber decimalNumberWithString:@"1.24"],
                                              Yen : [NSDecimalNumber decimalNumberWithString:@"135.76"],
                                              },
                                      Yen : @{
                                              Euro : [NSDecimalNumber decimalNumberWithString:@"0.0086"],
                                              BritishPound : [NSDecimalNumber decimalNumberWithString:@"0.0074"],
                                              USDollar : [NSDecimalNumber decimalNumberWithString:@"0.0092"],
                                              },
                                      };
    
    NSLog(@"\nfromCurrency = %@\ntoCurrency = %@\n\n%@", fromCurrency, toCurrency, [conversionRates valueForKeyPath:[NSString stringWithFormat:@"%@.%@", fromCurrency, toCurrency]]);    // key path --- outerkey.innerpath    (USD.Yen exchange rates OR fromCurrency.toCurrency)
    
    return [conversionRates valueForKeyPath:[NSString stringWithFormat:@"%@.%@", fromCurrency, toCurrency]];

}

@end






/*   The data structure - NSDictionary (many-to-many / multi-dimensional)
 
 keys        value                   (outer array)
 key     value       (inner array)
 USD        1.  Euro    0.98
 2.  BP
 3.  Yen
 
 Euro       1.  USD
 2.  BP
 3.  Yen
 
 BP         1.  USD
 2.  Euro
 3.  Yen
 
 Yen        1.  USD
 2.  Euro
 3.  BP
 
 
 */
