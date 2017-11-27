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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
