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
    
    //infomation text field setup
    self.infomationField.delegate = self;
    
    //Imports current debt infomation from a method in the debt coreData class
    self.debtDictionary = [Debt ViewDebtFromId: self.debtID];
    
    //disable the user from selected a date below the current date for notifications
    self.datePicker.minimumDate = [NSDate date];
    
    
    //To keep the title neat the first word in the "name" is extracted, usually this will be the first name of the payee
    NSString *firstName = [[[self.debtDictionary objectForKey:@"name"] componentsSeparatedByString:@" "] objectAtIndex:0];
    
    
    //Formats the title string depending on if the debt is to or from the payee
    if ([[self.debtDictionary objectForKey:@"IOweDebt"] integerValue] == 1) {
        self.titleLabel.text = [NSString stringWithFormat:@"Debt to %@",firstName];
    }else{
        self.titleLabel.text = [NSString stringWithFormat:@"Debt from %@",firstName];
        
    }
    
    //Assigns the amount label to the value of the debt being modified
    self.amountLabel.text = [Debt amountString:[self.debtDictionary objectForKey:@"amount"]];

    
    //Set up date picker to current due date, if there is no due data as the user has disabled notifications then the datw picker is disabled and faded out
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
    
    self.amount = [self.debtDictionary objectForKey:@"amount"];
    NSString *amountString = [NSString stringWithFormat:@"%.2f", [self.amount floatValue]];
    int stringLength = (int)[amountString length];
    
    while (stringLength < 7) {
        //loops so the string will be in the formalt XXXX.XX, for example 32.2 will become 0032.20 or conversion will result in an invaid output
        amountString = [NSString stringWithFormat:@"0%@", amountString];
        stringLength = (int)[amountString length];
    }
    
    //This is to prevent the user having to enter their value again even if they have no intentions to modify it
    for (int i = 0; i < 7; i++) {
        if (i != 4)  {
            NSString *singleChar = [amountString substringWithRange:NSMakeRange(i, 1)]; //Makes a new string of just one number
            NSInteger row = [singleChar intValue]; //turns that character into a integer of equal value
            [self.amountPicker selectRow:row inComponent:i animated:YES]; //uses that integer to select the amount picker row
        }else if (i == 4) {
            //Component 4 contains the decimal place so it will always be on row 0 because it only has one row
            [self.amountPicker selectRow:0 inComponent:i animated:YES];
        }
        
        
        
        
        
    }
    
    [self showAmount];
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
    
    //All components have values 0 - 9 except component 4 which serves as a decimal point
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
    
    //sets the title for each row to be a integer from 0 to 9
    NSString *rowvalue = [NSString stringWithFormat:@"%i",(int)row];
    
    //sets the 4th component to be a decimal place
    if (component == 4) {
        rowvalue = @".";
    }
    
    return rowvalue;
    
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component{
    
    //The amountlabel is updated from the showAmount method
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
    
    //Assigns the due date to the current date on the pickerview
    self.dueDate = self.datePicker.date;
    
    //to prevent a nil error a placeholder string for infomation 
    if ([self.infomationField.text  isEqual: @""]) {
        self.infomationField.text = @"No description given";
    }
    
    //disable due date from being recorded if user does not want a notification
    if (self.notificationSwitch.on == 0) {
        self.dueDate = [NSDate date];
    }
    
    #pragma mark invalid entry checking
    
    
    
    
    @try {
        
        //Extracts infomation either from the view or the imported dictionary to create a new debt
        NSDictionary *newDebt = @{@"payee" : [self.debtDictionary objectForKey:@"payee"],
                                  @"payeeID" : [self.debtDictionary objectForKey:@"payeeID"],
                                  @"amount": self.amount,
                                  @"isPaid": [NSNumber numberWithBool:0],
                                  @"debtID": [NSNumber numberWithInt:-1],       //The value for debt ID is assigned in the AddDebt method, -1 is used for troubleshooting
                                  @"dateStarted": [self.debtDictionary objectForKey:@"dateStarted"],
                                  @"dateDue" : self.dueDate,
                                  @"infomation": self.infomationField.text,
                                  @"imOwedDebt" : [self.debtDictionary objectForKey:@"imOwedDebt"],
                                  @"iOweDebt" : [self.debtDictionary objectForKey:@"iOweDebt"],
                                  @"sendNotification" : [NSNumber numberWithInt:(self.notificationSwitch.on)]
                                  };
        
        
        //If the dictionary can be loaded then it'll be safe to delete the old debt entry and create a new one with the new details
        [Debt deleteDebtFromID:(int)self.debtID];
        [Debt AddDebtFromDictionary:newDebt];
        

    
    }
    
    @catch (NSException *exception) {
        
        //displays an alert to the user if there was an error creating the debt, this is almost always because the user did not select an essential entry in the new debt form
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
    
    
    //Closes the keyboard if the user hits return
    [textField resignFirstResponder];
    
    return YES;
    
}

#pragma mark supporting methods

-(NSString *) showAmount {
    
    
    //creates a value for amount from theinput on the picker view
    float tempAmount =        [self.amountPicker selectedRowInComponent:0] * 1000;
    tempAmount = tempAmount + [self.amountPicker selectedRowInComponent:1] * 100;
    tempAmount = tempAmount + [self.amountPicker selectedRowInComponent:2] * 10;
    tempAmount = tempAmount + [self.amountPicker selectedRowInComponent:3] * 1;
    tempAmount = tempAmount + [self.amountPicker selectedRowInComponent:5] * 0.1;
    tempAmount = tempAmount + [self.amountPicker selectedRowInComponent:6] * 0.01;
    
    
    //the amount stored in the viewcontroller is then updated to match the value calculated from the picker view
    self.amount = [NSNumber numberWithFloat:tempAmount];
    NSString *amount = [NSString stringWithFormat:@"%@", [Debt amountString:self.amount]];
    
    
    return amount;
}

@end
