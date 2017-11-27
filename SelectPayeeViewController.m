//
//  SelectPayeeViewController.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 27/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "SelectPayeeViewController.h"


@interface SelectPayeeViewController ()

@end

@implementation SelectPayeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.SelectPayeeTableController = [[SelectPayeeTableViewController alloc] init];
    
    self.payeeTable.dataSource = self.SelectPayeeTableController;
    self.payeeTable.delegate = self.SelectPayeeTableController;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NewDebtViewController *destinationViewController = [segue destinationViewController];
    
    NSIndexPath *indexPath = [self.payeeTable indexPathForSelectedRow];

    NSLog(@"row selected = %i", (int)indexPath.row);
    
    if ([[segue identifier] isEqualToString:@"payeeSelected"]) {
    
        
        NSArray *tempPayees = [Payee returnPayees];
        
        NSNumber *tempPayeeID = [[tempPayees objectAtIndex: indexPath.row] objectForKey:@"payeeID"];
        
        destinationViewController.payeeName = [[tempPayees objectAtIndex: indexPath.row] objectForKey:@"name"];
        destinationViewController.payeeID = [tempPayeeID intValue];
        
        
    }
    
    

}


- (IBAction)payeeFromTextField:(id)sender {
    
    NSString *payeeName = self.payeeNameField.text;
    int payeeID = [Payee newPayeeID];
    
    NSDictionary *newPayee = @{@"name" : payeeName,
                               @"payeeID" : [NSNumber numberWithInt:payeeID]};
    
    
    
    
    [Payee AddDebtFromDictionary:newPayee];
    [self.payeeTable reloadData];
    
    self.payeeNameField.text = @"payeeSelected";
    
    
}


- (IBAction)importPayeeFromContacts:(id)sender {
         
    
    
}

@end
