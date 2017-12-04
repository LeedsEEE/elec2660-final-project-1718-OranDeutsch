//
//  ViewDebtViewController.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 21/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "ViewDebtViewController.h"


@interface ViewDebtViewController ()

@end

@implementation ViewDebtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self loadData];
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    ModifyDebtTableViewController *destinationViewController = [segue destinationViewController];
    
    
    
    if ([[segue identifier] isEqualToString:@"modifyDebtSegue"]) {
        
        
        destinationViewController.debtID = self.debtID;
        
        
    }
}


- (IBAction)modificationComplete:(UIStoryboardSegue *)segue{
    
        [self loadData];
    
    
    
}

- (IBAction)repayDebt:(id)sender {

    [Debt modifyIsPaidbyDebtID:self.debtID isPaid:1];
     
     
}

- (IBAction)modifyDebt:(id)sender {
    
    
}

-(void) loadData {
    
    self.debtDictionary = [Debt ViewDebtFromId: self.debtID];
    
    NSString *firstName = [[[self.debtDictionary objectForKey:@"name"] componentsSeparatedByString:@" "] objectAtIndex:0];
    
    if ([[self.debtDictionary objectForKey:@"iOweDebt"] integerValue] == 1) {
        
        self.titleLabel.text = [NSString stringWithFormat:@"Debt to %@",firstName];
        
    }else{
        
        self.titleLabel.text = [NSString stringWithFormat:@"Debt from %@",firstName];
        
        
    }
    
    
    
    self.payeeNameLabel.text = [self.debtDictionary objectForKey:@"name"];
    
    NSNumber *amount = [self.debtDictionary objectForKey:@"amount"];
    
    self.amountLabel.text = [Debt amountString:amount];
    
    //conversion method found on stack overflow by user : Adam Richardson
    //https://stackoverflow.com/questions/37117129/ios-convert-a-nsdate-object-into-a-string-to-get-the-current-time
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setCalendar:[NSCalendar currentCalendar]];
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateFormatter setDateFormat:@"d. MMMM YYYY"];
    
    self.dateStartedLabel.text = [dateFormatter stringFromDate:[self.debtDictionary objectForKey:@"dateStarted"]];
    self.infomationTextField.text = [self.debtDictionary objectForKey:@"infomation"];
    
    self.dateDueLabel.text = [dateFormatter stringFromDate:[self.debtDictionary objectForKey:@"dateDue"]];
    
    if ([[self.debtDictionary objectForKey:@"sendNotification"] integerValue] == 1) {
        
    }else{
        
        self.dateDueLabel.text = @"N/A";
    }

    
    
}
@end
