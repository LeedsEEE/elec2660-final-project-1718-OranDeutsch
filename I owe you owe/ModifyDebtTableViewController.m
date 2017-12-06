//
//  ModifyDebtTableViewController.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 04/12/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "ModifyDebtTableViewController.h"

@interface ModifyDebtTableViewController () <UIPickerViewDelegate , UIPickerViewDataSource, UITextFieldDelegate>

@end

@implementation ModifyDebtTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Picker view setup
    
    self.amountPicker.delegate = self;
    self.amountPicker.dataSource = self;
    
    self.infomationField.delegate = self;
    
    self.debtDictionary = [Debt ViewDebtFromId: self.debtID];
    
    //disable the user from selected a date below the current date for notifications
    
    self.datePicker.minimumDate = [NSDate date];
    
    
    
    NSString *firstName = [[[self.debtDictionary objectForKey:@"name"] componentsSeparatedByString:@" "] objectAtIndex:0];
    
    if ([[self.debtDictionary objectForKey:@"IOweDebt"] integerValue] == 1) {
        
        self.titleLabel.text = [NSString stringWithFormat:@"Debt to %@",firstName];
        
    }else{
        
        self.titleLabel.text = [NSString stringWithFormat:@"Debt from %@",firstName];
        
        
    }
    
    
    self.amount = [self.debtDictionary objectForKey:@"amount"] ;
    
    
    self.amountLabel.text = [Debt amountString:self.amount];
    
    

    
    //Set up date picker to current due date
    
    
    if ([[self.debtDictionary objectForKey:@"sendNotification"]integerValue] == 1) {
        
        [self.notificationSwitch setOn:1];
        [self.datePicker setDate:[self.debtDictionary objectForKey:@"dateDue"]];
        
        
    }else{
        
        [self.notificationSwitch setOn:0];
        self.datePicker.enabled = 0;
        self.datePicker.alpha = 0.4;
        
        
    }
    

    //Set up amount picker to current value
    
    //As I needed to split up the float into a series of singular integers I had to convert the 2 decimal place float into a string, make sure it had 7 figures displayed and then seperate each value.
    
    //This is to prevent the user having to enter their value again even if they have no intentions to modify it
    
    
    for (int i = 0; i < 7; i++) {
        
        NSString *amountString = [NSString stringWithFormat:@"%.2f", [self.amount floatValue]];
        int stringLength = (int)[amountString length];
        
        while (stringLength < 7) {
            
            amountString = [NSString stringWithFormat:@"0%@", amountString];
            stringLength = (int)[amountString length];
        }
        
        
        if (i < 4) {
        
            
            NSString *singleChar = [amountString substringWithRange:NSMakeRange(i, 1)];
            NSInteger row = [singleChar intValue];
            [self.amountPicker selectRow:row inComponent:i animated:YES];
            
        }else if ( i > 4) {
            
            NSString *singleChar = [amountString substringWithRange:NSMakeRange(i, 1)];
            NSInteger row = [singleChar intValue];
            [self.amountPicker selectRow:row inComponent:i animated:YES];
            
        }else if (i == 4) {
            
            [self.amountPicker selectRow:0 inComponent:i animated:YES];
        }
        
        
        

        
        
        
    }
    
    //Set up infomation field to existing value
    
    [self.infomationField setText:[self.debtDictionary objectForKey:@"infomation"]];

    
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
    
    //
    
    self.amountLabel.text = [self showAmount];
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveChanges:(id)sender {
    
    
    self.dueDate = self.datePicker.date;
    
    if ([self.infomationField.text  isEqual: @""]) {
        self.infomationField.text = @"No description given";
    }
    
    //disable due date from being recorded if user does not want a notification
    
    if (self.notificationSwitch.on == 0) {
        self.dueDate = [NSDate date];
    }
    
#pragma mark invalid entry checking
    
    
    
    
    @try {
        
        NSDictionary *newDebt = @{@"payee" : [self.debtDictionary objectForKey:@"payee"],
                                  @"payeeID" : [self.debtDictionary objectForKey:@"payeeID"],
                                  @"amount": self.amount,
                                  @"isPaid": [NSNumber numberWithBool:0],
                                  @"debtID": [NSNumber numberWithInt:-1],
                                  @"dateStarted": [self.debtDictionary objectForKey:@"dateStarted"],
                                  @"dateDue" : self.dueDate,
                                  @"infomation": self.infomationField.text,
                                  @"imOwedDebt" : [self.debtDictionary objectForKey:@"imOwedDebt"],
                                  @"iOweDebt" : [self.debtDictionary objectForKey:@"iOweDebt"],
                                  @"sendNotification" : [NSNumber numberWithInt:(self.notificationSwitch.on)]
                                  };
        
        
        NSLog(@"creating new debt from : %@", newDebt);
        
        [Debt deleteDebtFromID:(int)self.debtID];
        [Debt AddDebtFromDictionary:newDebt];
        

    
    }
    
    @catch (NSException *exception) {
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Important Entry not selected" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }

    
    
    
    
    
}

- (IBAction)toggleNotification:(id)sender {
    
    // fades the pickerview out when the user does not want the app to produce a reminder notification
    
    if (self.notificationSwitch.on == 1) {
        
        self.datePicker.enabled = 1;
        self.datePicker.alpha = 1;
        
        
    }else{
        
        self.datePicker.enabled = 0;
        self.datePicker.alpha = 0.4;
        
    }
    
    
}



#pragma mark Text field Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}



-(NSString *) showAmount {
    
    
    //creates a value for amount from theinput on the picker view
    
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
