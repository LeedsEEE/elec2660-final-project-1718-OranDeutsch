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
    
    
    [self.IOweTable reloadData];
    [self.ImOwedTable reloadData];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    
    if ([[segue identifier] isEqualToString:@"IOweSegue"]) {
        

        
    }
    
    if ([[segue identifier] isEqualToString:@"ImOwedSegue"]) {
        

        
    }

    
    
}

@end
