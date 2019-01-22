//
//  Validator.h
//  CurrencyConverter
//
//  Created by Cooley, Jon on 11/9/16.
//  Copyright © 2016 Cooley, Jon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validator : NSObject

// declare class methods
+ (BOOL)isDifferentFromCurrency:(NSString *)fromCurrencyType thanToCurrency:(NSString *)toCurrencyType;

+ (BOOL)isValid:(NSString *)fromCurrencyAmountText;


@end
