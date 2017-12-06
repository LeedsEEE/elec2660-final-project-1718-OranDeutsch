//
//  SettingsTableViewController.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 04/12/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "SettingsTableViewController.h"

@interface SettingsTableViewController ()

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Calls existing settings and changes the title to match the current view
    
    [self.tabBarController setTitle:@"Settings"];
    
    self.currencyData = [Settings returnCurrencies];
    
    
    self.SelectPayeeTableController = [[SelectPayeeTableViewController alloc] init];
    
    self.payeeTable.dataSource = self.SelectPayeeTableController;
    self.payeeTable.delegate = self.SelectPayeeTableController;
    
    
    
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    //When the view appears the title is updated and the table for payees is refreshed
    
    [super viewWillAppear:animated];
    [self.tabBarController setTitle:@"Settings"];
    [self.payeeTable reloadData];
    
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
    
    //Makes the amount of rows in the pickerview equal to the amount of currencies stored
    
    rows = [self.currencyData count];
    
    
    
    return rows;
    
}

#pragma mark - Picker View Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{
    
    //populates each section of the picker view with the currency name and symbol
    
    Currency *tempCurrency = [self.currencyData objectAtIndex:row];
    
    
    
    NSString *rowvalue = [NSString stringWithFormat:@"%@ (%@)",
                          tempCurrency.name,
                          tempCurrency.symbol];
    
    
    
    return rowvalue;
    
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component{
    
    //updates the users currency of choice selected
    
    Currency *tempCurrency = [self.currencyData objectAtIndex:row];
    
    
    [Settings updateCurrency:tempCurrency.symbol];
    
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)deletePayee:(id)sender {
    
    //UIAlertController code sourced and changed from https://stackoverflow.com/questions/24190277/writing-handler-for-uialertaction
    
    
    
    //to get infomation on the
    NSIndexPath *indexPath = [self.payeeTable indexPathForSelectedRow];
    NSArray *tempPayeeArray = [Payee returnPayees];
    
        

    
    Payee *tempPayee = [[tempPayeeArray objectAtIndex:indexPath.row]objectForKey:@"payee"];
    
        //if the payee has existing debts the user is warned that the debts would need to be deleted, they have the option to cancel still
    
    
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Payee has saved debts, deleting the payee will remove their debts" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
            //if the user does have existing debts then after being alerted of this the user can accept and the view has to call a method to delete all the payees debts
            
    [Debt deleteDebtsFromPayee:tempPayee];
    [Payee deletePayeeFromID:[tempPayee.payeeID integerValue]];
    [self.payeeTable reloadData];
            
            
            //call toast libary to give the user visual feedback that the payee is deleted
            
        [self.view makeToast:@"Payee Deleted"
                    duration:3.0
                    position:CSToastPositionTop];
        
        
    }]];
        
        //add cancel button that does nothing
        
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }]];
    
    
    
    
    
    
    if ([Payee payeeHasDebts:tempPayee] == YES) {
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        
        [Payee deletePayeeFromID:[tempPayee.payeeID integerValue]];
        [self.payeeTable reloadData];
            
            //call toast libary to give the user visual feedback that the payee is deleted
            
        [self.view makeToast:@"Payee Deleted"
                    duration:3.0
                    position:CSToastPositionTop];
            
        
        
        
        

        
    
    }
    
    
    
}

- (IBAction)deleteAll:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Warning" message:@"EVERYTHING WILL BE DELETED THIS IS NON-REVERSIBLE " preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Continue" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //Calls all delete functions, they occupy seperate try catch statements incase the user uses this with empty core data entities
        
        @try{
            [Debt deleteAllDebts];
        }
        @catch (NSException *exception){}
        
        @try{
            [Payee deleteAllPayees];
        }
        @catch (NSException *exception){}
        
        @try{
            [Settings deleteAllSettings];
        }
        @catch (NSException *exception){}
        
        //The user is then sent to the welcome screen as the app now has lost its basic settings data
        
        //I used present view controller as a segue would result in navigation bars persisting
        
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"InitalViewViewController"];
        [self presentViewController:vc animated:YES completion:nil];
        
        
    }]];
    
    //add cancel button that does nothing
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }]];

    [self presentViewController:alertController animated:YES completion:nil];

}
@end
