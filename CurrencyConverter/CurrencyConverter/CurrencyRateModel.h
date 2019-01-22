//
//  CurrencyRateModel.h
//  CurrencyConverter
//
//  Created by Cooley, Jon on 11/9/16.
//  Copyright © 2016 Cooley, Jon. All rights reserved.
//

#import <Foundation/Foundation.h>

// Declare public contants
extern NSString *const USDollar;
extern NSString *const Euro;
extern NSString *const BritishPound;
extern NSString *const Yen;


@interface CurrencyRateModel : NSObject

+ (NSDecimalNumber *)exchangeRateFrom:(NSString *)FromCurrency to:(NSString *)ToCurrency;

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
