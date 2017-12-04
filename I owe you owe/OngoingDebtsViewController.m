//
//  OngoingDebtsViewController.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 21/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "OngoingDebtsViewController.h"

@interface OngoingDebtsViewController ()

@end

@implementation OngoingDebtsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    self.iOweTableViewController = [[IOweTableViewController alloc] init];
    self.imOwedTableViewController = [[ImOwedTableViewController alloc] init];
    
    self.IOweTable.delegate = self.iOweTableViewController;
    self.ImOwedTable.delegate = self.imOwedTableViewController;
    self.IOweTable.dataSource = self.iOweTableViewController;
    self.ImOwedTable.dataSource = self.imOwedTableViewController;
    
    
    
    
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self.tabBarController setTitle:@"Unpaid Debts"];
    
    [self.IOweTable reloadData];
    [self.ImOwedTable reloadData];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    
    ViewDebtViewController *destinationViewController = [segue destinationViewController];
    
    
    
    
    
    if ([[segue identifier] isEqualToString:@"IOweSegue"]) {
        
        NSIndexPath *indexPath = [self.IOweTable indexPathForSelectedRow];
        
        NSArray *tempDebt = [Debt returnDebts:0 owed:0];

        NSInteger segueDebtID = [[[tempDebt objectAtIndex:indexPath.row] objectForKey:@"debtID"] integerValue];
        
        destinationViewController.debtID = segueDebtID;
        
        
    }
    
    if ([[segue identifier] isEqualToString:@"ImOwedSegue"]) {
        
        NSIndexPath *indexPath = [self.ImOwedTable indexPathForSelectedRow];
        
        NSArray *tempDebt = [Debt returnDebts:0 owed:1];
        
        NSNumber *segueDebtID = [[tempDebt objectAtIndex:indexPath.row] objectForKey:@"debtID"];
        
        destinationViewController.debtID = [segueDebtID integerValue];

        
    }
    

    
    
}

- (IBAction)debtRepayed:(UIStoryboardSegue *)segue{
    
    
    
    
}

@end
