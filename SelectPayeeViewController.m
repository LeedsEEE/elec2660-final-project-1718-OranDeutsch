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
    
    
    [self.payeeTable reloadData];
    
    
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NewDebtTableViewController *destinationViewController = [segue destinationViewController];
    
    NSIndexPath *indexPath = [self.payeeTable indexPathForSelectedRow];

    
    if ([[segue identifier] isEqualToString:@"payeeSelected"]) {
    
        
        NSArray *tempPayees = [Payee returnPayees];
        
        NSNumber *tempPayeeID = [[tempPayees objectAtIndex: indexPath.row] objectForKey:@"payeeID"];
        
        destinationViewController.payeeName = [[tempPayees objectAtIndex: indexPath.row] objectForKey:@"name"];
        destinationViewController.payeeID = tempPayeeID;
        
        
        
        
    }
    
    

}


- (IBAction)payeeFromTextField:(id)sender {
    
    NSString *payeeName = self.payeeNameField.text;
    int payeeID = [Payee newPayeeID];
    
    NSDictionary *newPayee = @{@"name" : payeeName,
                               @"payeeID" : [NSNumber numberWithInt:payeeID]};
    
    
    
    
    [Payee AddPayeeFromDictionary:newPayee];
    [self.payeeTable reloadData];
    
    //Calls toast libary for user feedback
    
    [self.view makeToast:[NSString stringWithFormat:@"%@ added to payees",[newPayee objectForKey:@"name"]]];
    
    self.payeeNameField.text = nil;
    
    
    
    
}

- (IBAction)contactSelectComplete:(UIStoryboardSegue *)segue{
    
    
    
}


- (IBAction)importPayeeFromContacts:(id)sender {
         
    [self.payeeTable reloadData];
    
    
    
}

#pragma mark Text field Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}



@end
