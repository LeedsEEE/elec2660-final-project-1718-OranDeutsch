//
//  SelectPayeeViewController.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 27/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "SelectPayeeViewController.h"


@interface SelectPayeeViewController () <UITextFieldDelegate>

@end

@implementation SelectPayeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Calls the select payee table from the SelectPayeeTableController
    self.SelectPayeeTableController = [[SelectPayeeTableViewController alloc] init];
    self.payeeNameField.delegate = self;
    self.payeeTable.dataSource = self.SelectPayeeTableController;
    self.payeeTable.delegate = self.SelectPayeeTableController;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Refreshes the table when it comes into view
    [self.payeeTable reloadData];
    
    
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NewDebtTableViewController *destinationViewController = [segue destinationViewController];
    
    NSIndexPath *indexPath = [self.payeeTable indexPathForSelectedRow];
    if ([[segue identifier] isEqualToString:@"payeeSelected"]) {
        
        //Finds the payeeID of the selected payee and sends it to the new debt view controller
        NSArray *tempPayees = [Payee returnPayees];
        NSNumber *tempPayeeID = [[tempPayees objectAtIndex: indexPath.row] objectForKey:@"payeeID"];
        destinationViewController.payeeName = [[tempPayees objectAtIndex: indexPath.row] objectForKey:@"name"];
        destinationViewController.payeeID = tempPayeeID;
    }
}


- (IBAction)payeeFromTextField:(id)sender {
    
    //If the user presses "create payee" button a payee is created and the keyboard closes
    [self.payeeNameField resignFirstResponder];
    [self createNewPayee];
    
}

- (IBAction)contactSelectComplete:(UIStoryboardSegue *)segue{
    
}


- (IBAction)importPayeeFromContacts:(id)sender {
    
    //Exit segue from the "import from contacts" view
    [self.payeeNameField resignFirstResponder];
    [self.payeeTable reloadData];
    
    
    
}

#pragma mark Text field Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //Closes the keyboard when the user presses enter on the keyboard and makes a new payee
    [self.payeeNameField resignFirstResponder];
    [self createNewPayee];
    return YES;
    
}

-(void) createNewPayee {
    
    //Pulls the payee name from the payeeName text field
    NSString *payeeName = self.payeeNameField.text;
    
    //Discounts empty or one letter names
    if (payeeName.length < 2) {
        
        //Sends an error message if the user has entered an invalid name
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Invalid Name" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
    
        //Generates a new payeeID and populates a dictionary with the new payee infomation
        int payeeID = [Payee newPayeeID];
        NSDictionary *newPayee = @{@"name" : payeeName,
                                   @"payeeID" : [NSNumber numberWithInt:payeeID]};
    
        //Calls a payee method to add the debt in the dictionary
        [Payee AddPayeeFromDictionary:newPayee];
        [self.payeeTable reloadData];
    
        //Calls toast libary for user feedback
        [self.view makeToast:[NSString stringWithFormat:@"%@ added to payees",[newPayee objectForKey:@"name"]]];
        self.payeeNameField.text = nil;
    }
}

@end
