//
//  NewDebtTableViewController.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 04/12/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "NewDebtTableViewController.h"


@interface NewDebtTableViewController ()  <UIPickerViewDelegate , UIPickerViewDataSource, UITextFieldDelegate>

@end

@implementation NewDebtTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    //set up datasources and delegate for relevant objects
    
    self.amountPicker.delegate = self;
    self.amountPicker.dataSource = self;
    
    self.amount = [NSNumber numberWithFloat:0];
    
    self.descriptionTextField.delegate = self;
    self.amountLabel.text = [self showAmount];
    
    //disable the user from selected a date below the current date for notifications
    
    self.datePicker.minimumDate = [NSDate date];
    
    [self resetView];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //set title to change when view shows
    
    [self.tabBarController setTitle:@"New Debt"];
    [self showAmount];
    
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.amountLabel.text = [NSString stringWithFormat:@"%@", [Debt amountString:self.amount]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Picker View Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    //as I am working to 6 significant figures and a decimal place I need 7 components
    
    return 7;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:
(NSInteger)component{
    NSInteger rows;
    
    //sets 10 rows for ever component except the decimal place component at 4
    
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
    
    //sets the rows to a value from 0 to 9 other than the decimal place component
    
    NSString *rowvalue = [NSString stringWithFormat:@"%i",(int)row];
    
    if (component == 4) {
        rowvalue = @".";
    }
    
    return rowvalue;
    
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component{
    
    
    //sets the amount lavvel to a function which turns the picker view into a amount float and then into a string with the currency symbol
    
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

#pragma mark Savedebt


- (IBAction)saveDebt:(id)sender {
    
    //conditions data inputs to avoid errors
    
    self.dueDate = self.datePicker.date;
    
    if ([self.descriptionTextField.text  isEqual: @""]) {
        self.descriptionTextField.text = @"No description given";
    }
    
    //disable due date from being recorded if user does not want a notification
    
    if (self.notificationSwitch.on == 0) {
        self.dueDate = [NSDate date];
    }
    
    
#pragma mark invalid entry checking
    
    //try catch used to detect errors inputing data into a dictionary
    
    if ([self.amount floatValue] != 0.0) {
    
        @try {
        
        
            NSDictionary *newDebt = @{@"payee" : self.payeeName,
                                      @"payeeID" : self.payeeID,
                                      @"amount": self.amount,
                                      @"isPaid": [NSNumber numberWithBool:0],
                                      @"debtID": [NSNumber numberWithInt:-1],
                                      @"dateStarted": [NSDate date],
                                      @"dateDue" : self.dueDate,
                                      @"infomation": self.descriptionTextField.text,
                                      @"imOwedDebt" : [NSNumber numberWithInt:self.ImOwedSwitch.on],
                                      @"iOweDebt" : [NSNumber numberWithInt:!(self.ImOwedSwitch.on)],
                                      @"sendNotification" : [NSNumber numberWithInt:(self.notificationSwitch.on)]};
        
        
        
        
            NSString *log = [Debt AddDebtFromDictionary:newDebt].description;
        
            NSLog(@"Creating new debt from dictionary : %@", log);
        
        
            //Uses the toast libary to give the user visual feedback that the debt has been entered into the system
        
            [self.view makeToast:@"New Debt Created"];
        
            //Calls a function to bring the view to its default position
        
            [self resetView];
        }
    
        @catch (NSException *exception) {
        
        //uses a UI alert controller
        
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Important Entry not selected" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        
        
        }
    

    }else{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please enter an amount greater than 0" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
}
- (IBAction)toggleNotifications:(id)sender {
    
    //fades out the date picker when the user disables notifications
    
    
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
    
    //closes the keyboard when the user types "enter"
    
    
    [textField resignFirstResponder];
    
    return YES;
    
}



#pragma mark internal methods

-(NSString *) showAmount {
    
    //takes each element of the pickerview and multiplies it by its respective order of magnitude
    
    float tempAmount = [self.amountPicker selectedRowInComponent:0] * 1000;
    tempAmount = tempAmount + [self.amountPicker selectedRowInComponent:1] * 100;
    tempAmount = tempAmount + [self.amountPicker selectedRowInComponent:2] * 10;
    tempAmount = tempAmount + [self.amountPicker selectedRowInComponent:3] * 1;
    tempAmount = tempAmount + [self.amountPicker selectedRowInComponent:5] * 0.1;
    tempAmount = tempAmount + [self.amountPicker selectedRowInComponent:6] * 0.01;
    
    
    //Sets the amount value and then calls the Debt method to create a string with the users selected currency
    
    self.amount = [NSNumber numberWithFloat:tempAmount];
    
    
    
    NSString *amount = [NSString stringWithFormat:@"%@", [Debt amountString:self.amount]];
    
    
    return amount;
}

-(void) resetView {
    
    //reset amount picker
    
    for (int i; i < 7; i++) {
        
        [self.amountPicker selectRow:0 inComponent:i animated:YES];
        
    }
    
    //reset date picker to current date
    
    [self.datePicker setDate:[NSDate date]];
    
    //reset notification switch back to disabled
    
    [self.notificationSwitch setOn:NO];
    
    self.datePicker.enabled = 0;
    self.datePicker.alpha = 0.4;
    
    //update labels to match
    
    self.amountLabel.text = [self showAmount];
    self.payeeName = nil;
    self.payeeID = nil;
    
    self.payeeLabel.text = @"Select Payee";
    
    
}

@end
