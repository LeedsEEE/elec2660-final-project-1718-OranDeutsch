//
//  SelectAmountViewController.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 28/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "SelectAmountViewController.h"

@interface SelectAmountViewController () <UIPickerViewDelegate , UIPickerViewDataSource>

@end

@implementation SelectAmountViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.amountPicker.delegate = self;
    self.amountPicker.dataSource = self;
    
    self.amount = [NSNumber numberWithFloat:0];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Picker View Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 7;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:
                            (NSInteger)component{
    NSInteger rows;
    
    if (component == 4) {
        rows = 1;
    } else {
        rows = 10;
    }
    
    return rows;
    
}

#pragma mark - Picker View Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{
    
    
    
    NSString *rowvalue = [NSString stringWithFormat:@"%i",(int)row];
    
    if (component == 4) {
        rowvalue = @".";
    }
    
    return rowvalue;
    
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component{
    
    float tempAmount = [self.amountPicker selectedRowInComponent:0] * 1000;
    tempAmount = tempAmount + [self.amountPicker selectedRowInComponent:1] * 100;
    tempAmount = tempAmount + [self.amountPicker selectedRowInComponent:2] * 10;
    tempAmount = tempAmount + [self.amountPicker selectedRowInComponent:3] * 1;
    tempAmount = tempAmount + [self.amountPicker selectedRowInComponent:5] * 0.1;
    tempAmount = tempAmount + [self.amountPicker selectedRowInComponent:6] * 0.01;
    
    self.amount = [NSNumber numberWithFloat:tempAmount];
    
    self.amountLabel.text = [NSString stringWithFormat:@"£%.2f", tempAmount];
   

}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NewDebtViewController *destinationViewController = [segue destinationViewController];
    
    
    if ([[segue identifier] isEqualToString:@"amountSelected"]) {
        

        destinationViewController.amount = self.amount;
        
        
    }

}


@end
