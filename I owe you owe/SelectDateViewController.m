//
//  SelectDateViewController.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 28/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "SelectDateViewController.h"

@interface SelectDateViewController ()

@end

@implementation SelectDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NewDebtViewController *destinationViewController = [segue destinationViewController];
    
    
    
    if ([[segue identifier] isEqualToString:@"dateSelected"]) {
        
        
        destinationViewController.dueDate = [self.datePicker date];
        
        NSLog(@"sent date = %@", [self.datePicker date]);
        
        
    }

}


- (IBAction)selectDate:(id)sender {
    

    
}
@end
