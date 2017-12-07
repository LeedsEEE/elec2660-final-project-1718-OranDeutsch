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
    
   
    //This view presents all debts the user has to other people and all the debts others have to them
    
    //To have two seperate tables the code has two seperate controllers which are imported
    
    
    self.iOweTableViewController = [[IOweTableViewController alloc] init];
    self.imOwedTableViewController = [[ImOwedTableViewController alloc] init];
    
    //Both tables are given seperate delegates and seperate dataviews
    
    self.IOweTable.delegate = self.iOweTableViewController;
    self.ImOwedTable.delegate = self.imOwedTableViewController;
    self.IOweTable.dataSource = self.iOweTableViewController;
    self.ImOwedTable.dataSource = self.imOwedTableViewController;
    
    //prevents the top and bottom bars from covering table view data
    
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
    
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    //Gives the user some visual feedback that there is no data to display
    
    if (([self.IOweTable numberOfRowsInSection:0] == 0) && ([self.ImOwedTable numberOfRowsInSection:0] == 0)) {
        
        [self.view makeToast:@"No debts to display"];
        
        
        NSLog(@"no debts");
    }

    //Resets the tables when the view appears as the data they read could have changed
    
    [self.tabBarController setTitle:@"Unpaid Debts"];
    
    [self.IOweTable reloadData];
    [self.ImOwedTable reloadData];
    
    

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    //if the user selects a debt then the debtID is found and sent, two segues are used as both tables are populated with different arrays which need calling depending on segue the app is following
    
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
    
    [super viewDidLoad];
    


    
}

@end
