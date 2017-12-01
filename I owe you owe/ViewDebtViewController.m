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
    
    
    
    
    self.debtDictionary = [Debt ViewDebtFromId: self.debtID];
    
    NSLog(@"%@",self.debtDictionary);
    
    NSString *firstName = [[[self.debtDictionary objectForKey:@"name"] componentsSeparatedByString:@" "] objectAtIndex:0];
    
    if ([[self.debtDictionary objectForKey:@"IOweDebt"] integerValue] == 1) {
        
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
    self.dateDueLabel.text = [dateFormatter stringFromDate:[self.debtDictionary objectForKey:@"dateDue"]];
    self.infomationTextField.text = [self.debtDictionary objectForKey:@"infomation"];
    
    
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

- (IBAction)repayDebt:(id)sender {

    [Debt modifyIsPaidbyDebtID:self.debtID isPaid:1];
     
     
}

- (IBAction)modifyDebt:(id)sender {
}
@end
