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
   
    
    self.amountPicker.delegate = self;
    self.amountPicker.dataSource = self;
    
    self.amount = [NSNumber numberWithFloat:0];
    
    self.amountLabel.text = [self showAmount];

}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController setTitle:@"New Debt"];
    
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
    
    self.dueDate = self.datePicker.date;
    
    if ([self.descriptionTextField.text  isEqual: @""]) {
        self.descriptionTextField.text = @"No description given";
    }
    
    //disable due date from being recorded if user does not want a notification
    
    if (self.notificationSwitch.on == 0) {
        self.dueDate = [NSDate date];
    }
    
    
#pragma mark invalid entry checking
    
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
        
        NSLog(@"%@", log);
        
        
        //Uses the toast libary to give the user visual feedback that the debt has been entered into the system
        
        [self.view makeToast:@"New Debt Created"];
        
        //Calls a function to bring the view to its default position
        
        [self resetView];
    }
    
    @catch (NSException *exception) {
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Important Entry not selected" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }
    

    
    
        
}
- (IBAction)toggleNotifications:(id)sender {
    
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



#pragma mark internal methods

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

-(void) resetView {
    
    //reset amount picker
    
    for (int i; i < 7; i++) {
        
        [self.amountPicker selectRow:0 inComponent:i animated:YES];
        
    }
    
    //reset date picker to current date
    
    [self.datePicker setDate:[NSDate date]];
    
    //reset notification switch back to enable
    
    [self.notificationSwitch setOn:YES];
    
    //update labels to match
    
    self.amountLabel.text = [self showAmount];
    self.payeeName = nil;
    self.payeeID = nil;
    
    self.payeeLabel.text = @"Select Payee";
    
    
}

@end
