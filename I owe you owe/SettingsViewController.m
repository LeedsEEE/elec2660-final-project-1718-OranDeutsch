//
//  SettingsViewController.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 21/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()


@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currencyLogos = @[@"£",        @"$",           @"€",       @"¥",   @"¥"];
    self.currencyNames = @[@"Pound",    @"US Dollar",   @"Euro",    @"Yen", @"Yuan "];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Picker View Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:
(NSInteger)component{
    NSInteger rows;
    
    rows = [self.currencyLogos count];
    
    return rows;
    
}

#pragma mark - Picker View Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{
    
    
    
    NSString *rowvalue = [NSString stringWithFormat:@"%@ (%@)",
                          [self.currencyNames objectAtIndex:row],
                          [self.currencyLogos objectAtIndex:row]];
    
    return rowvalue;
    
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component{
    
    
    self.tempSettings.currency = [self.currencyLogos objectAtIndex:row];
    
    NSLog(@"selected currency = %@ or %@", self.tempSettings.currency, [self.currencyLogos objectAtIndex:row]);
    
    [Settings updateCurrency:[self.currencyLogos objectAtIndex:row]];

    
    
}



#pragma mark - Navigation
 
- (IBAction)backAfterDelete:(UIStoryboardSegue *)segue{
}

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
