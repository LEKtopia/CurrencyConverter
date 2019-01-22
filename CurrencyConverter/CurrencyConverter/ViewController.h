//
//  ViewController.h
//  CurrencyConverter
//
//  Created by Cooley, Jon on 11/7/16.
//  Copyright © 2016 Cooley, Jon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate> {
    
    __weak IBOutlet UITextField *fromAmountTextField;
    __weak IBOutlet UITextField *toAmountTextField;
    __weak IBOutlet UIButton *convertButton;
    __weak IBOutlet UILabel *responseLabel;
    
}

@property (weak, nonatomic) IBOutlet UIPickerView *pickerFrom;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerTo;

- (IBAction)convertCurrency;

@end
