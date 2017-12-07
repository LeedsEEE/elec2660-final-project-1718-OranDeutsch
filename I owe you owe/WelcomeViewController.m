//
//  WelcomeViewController.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 01/12/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "WelcomeViewController.h"


@interface WelcomeViewController ()  <UIPickerViewDelegate , UIPickerViewDataSource>

@end

@implementation WelcomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //sets up a currency pickerview based on the currency array stored in the settings class based on the Currency object I created
    
    self.currencyData = [Settings returnCurrencies];
    
    self.currencyPicker.delegate = self;
    self.currencyPicker.dataSource = self;
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //Dismisses the view if the app already has an object in the settings entity
    
    if ([Settings firstTimeLoad] == YES) {
        
    }else{
        [self proceed];
    }
    
    
    //since the picker starts at row 0
    [Settings updateCurrency:0];
    
    
}

- (IBAction)goToApp:(id)sender {
    
    //Allows the user to proceed to the app but only when they have selected a currency
    
    if ([Settings firstTimeLoad] == YES) {
        
    }else{
        [self proceed];
    }
    
    
}

-(void) proceed {
    
    [self performSegueWithIdentifier:@"Proceed" sender:self];
    
}



#pragma mark - Picker View Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:
(NSInteger)component{
    NSInteger rows;
    
    rows = [self.currencyData count];
    
    
    
    return rows;
    
}

#pragma mark - Picker View Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{
    
    
    Currency *tempCurrency = [self.currencyData objectAtIndex:row];
    
    NSString *rowvalue = [NSString stringWithFormat:@"%@ (%@)",
                          tempCurrency.name,
                          tempCurrency.symbol];
    
    
    
    return rowvalue;
    
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component{
    
    //updates selcted currency when user picks a currency in the pickerview
    [Settings updateCurrency:row];
    
    
    
}


- (IBAction)firstTimeRunSegue:(id)sender {
    
    
}
@end
