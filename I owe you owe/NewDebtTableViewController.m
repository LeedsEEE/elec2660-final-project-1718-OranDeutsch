//
//  NewDebtTableViewController.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 04/12/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "NewDebtTableViewController.h"

@interface NewDebtTableViewController ()  <UIPickerViewDelegate , UIPickerViewDataSource>

@end

@implementation NewDebtTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.amountPicker.delegate = self;
    self.amountPicker.dataSource = self;
    
    self.amount = [NSNumber numberWithFloat:0];
    
    self.amountLabel.text = [self showAmount];

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
    
    
    self.amountLabel.text = [self showAmount];
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)payeeSelectComplete:(id)sender {
    
    
    self.payeeLabel.text = self.payeeName;
    
    
    
}



- (IBAction)saveDebt:(id)sender {
    
    NSLog(@"new debt button pressed");
    
}
- (IBAction)toggleNotifications:(id)sender {
}


-(NSString *) showAmount {
    
    float tempAmount = [self.amountPicker selectedRowInComponent:0] * 1000;
    tempAmount = tempAmount + [self.amountPicker selectedRowInComponent:1] * 100;
    tempAmount = tempAmount + [self.amountPicker selectedRowInComponent:2] * 10;
    tempAmount = tempAmount + [self.amountPicker selectedRowInComponent:3] * 1;
    tempAmount = tempAmount + [self.amountPicker selectedRowInComponent:5] * 0.1;
    tempAmount = tempAmount + [self.amountPicker selectedRowInComponent:6] * 0.01;
    
    self.amount = [NSNumber numberWithFloat:tempAmount];
    
    NSString *amount = [NSString stringWithFormat:@"£%.2f", tempAmount];
    
    
    return amount;
}

@end
