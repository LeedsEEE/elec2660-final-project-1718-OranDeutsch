//
//  ViewPaidDebtViewController.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 30/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "ViewPaidDebtViewController.h"

@interface ViewPaidDebtViewController ()



@end

@implementation ViewPaidDebtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //calls a dedicated method to call the data from my core data class and populate the view with all the infomation relevent to the user
    [self loadData];
    
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


#pragma mark exit segues

- (IBAction)deleteDebt:(id)sender {
    
    //deletes the debt perminatly
    [Debt deleteDebtFromID:(int)self.debtID];
}

- (IBAction)markUnpaid:(id)sender {
    
    //Calls a method to change the "ispaid" component of a debt object, in this case marks is as unpaid
    [Debt modifyIsPaidbyDebtID:self.debtID isPaid:0];
}

-(void)loadData {
    
    
    //Modifies all the elements to match the imported debt
    self.debtDictionary = [Debt ViewDebtFromId: self.debtID];
    
    //Displays a dynamic title depending on if the user owes or is owed the debt
    NSString *firstName = [[[self.debtDictionary objectForKey:@"name"] componentsSeparatedByString:@" "] objectAtIndex:0];
    
    if ([[self.debtDictionary objectForKey:@"iOweDebt"] integerValue] == 1) {
        self.titleLabel.text = [NSString stringWithFormat:@"Debt to %@",firstName];
    }else{
        self.titleLabel.text = [NSString stringWithFormat:@"Debt from %@",firstName];
    }
    
    //Assigns view objects values
    self.nameLabel.text = [self.debtDictionary objectForKey:@"name"];
    NSNumber *amount = [self.debtDictionary objectForKey:@"amount"];
    self.amountLabel.text = [Debt amountString:amount];
    
    //conversion method found on stack overflow by user : Adam Richardson
    //https://stackoverflow.com/questions/37117129/ios-convert-a-nsdate-object-into-a-string-to-get-the-current-time
    
    //Formats the stored NSData into a string the user can interprit
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setCalendar:[NSCalendar currentCalendar]];
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateFormatter setDateFormat:@"d. MMMM YYYY"];
    
    //Applies the formatting to the displayed dates
    self.dateStartedLabel.text = [dateFormatter stringFromDate:[self.debtDictionary objectForKey:@"dateStarted"]];
    self.datePaidLabel.text = [dateFormatter stringFromDate:[self.debtDictionary objectForKey:@"datePaid"]];
    
    //only presents the date due if the debt has one, otherwise just says N/A and fades out slightly
    if ([[self.debtDictionary objectForKey:@"sendNotification"] integerValue] == 1) {
        self.dateDueLabel.text = [dateFormatter stringFromDate:[self.debtDictionary objectForKey:@"dateDue"]];
        self.dateDueLabel.alpha = 1;
    }else{
        self.dateDueLabel.text = @"N/A";
        self.dateDueLabel.alpha = 0.4;
    }
    
    
    //Populates the infomation text field
    self.infomationField.text = [self.debtDictionary objectForKey:@"infomation"];

    
    
}
@end
