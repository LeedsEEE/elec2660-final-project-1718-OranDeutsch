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

- (void) viewDidAppear:(BOOL)animated {
    
    //Does not display the data to the user if there is an error, this is legacy code when I was suffering from nill erros but remains as it is very useful for troubleshooting
    @try{
    [self loadData];
    }
    @catch(NSException *exception){
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //If the user wants to modify the debt the debtID is passed forward for the modify screen to import it in
    ModifyDebtTableViewController *destinationViewController = [segue destinationViewController];
    if ([[segue identifier] isEqualToString:@"modifyDebtSegue"]) {
        destinationViewController.debtID = self.debtID;
    }
}


- (IBAction)modificationComplete:(UIStoryboardSegue *)segue{
    
    [self loadData];
    [super viewDidLoad];
    
    //Calls toast libary
    [self.view makeToast:@"Debt Edited"];
    
    
}

- (IBAction)repayDebt:(id)sender {
    
    //Calls debt method to change the "isPaid" value of called object
    [Debt modifyIsPaidbyDebtID:self.debtID isPaid:1];
    
    
}

- (IBAction)modifyDebt:(id)sender {
    
}

-(void) loadData {
    
    //Populates all the UIOjects with infomation for the user
    
    //Calls the viewDebtFromId method to get a dictionary of infomation about the specific debt entry
    self.debtDictionary = [Debt ViewDebtFromId: self.debtID];
    NSString *firstName = [[[self.debtDictionary objectForKey:@"name"] componentsSeparatedByString:@" "] objectAtIndex:0];
    
    //Changes the title depending if the debt the user is viewing is owed to the user or is from the user
    if ([[self.debtDictionary objectForKey:@"iOweDebt"] integerValue] == 1) {
        self.titleLabel.text = [NSString stringWithFormat:@"Debt to %@",firstName];
    }else{
        self.titleLabel.text = [NSString stringWithFormat:@"Debt from %@",firstName];
    }
    
    
    //Populates some of the feilds with infomation from the imported dictionary
    self.payeeNameLabel.text = [self.debtDictionary objectForKey:@"name"];
    NSNumber *amount = [self.debtDictionary objectForKey:@"amount"];
    self.amountLabel.text = [Debt amountString:amount];
    
    //conversion method found on stack overflow by user : Adam Richardson
    //https://stackoverflow.com/questions/37117129/ios-convert-a-nsdate-object-into-a-string-to-get-the-current-time
    
    //Formatts the NSDate to be interprited by the user
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setCalendar:[NSCalendar currentCalendar]];
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateFormatter setDateFormat:@"d. MMMM YYYY"];
    
    //displays the formatted date
    self.dateStartedLabel.text = [dateFormatter stringFromDate:[self.debtDictionary objectForKey:@"dateStarted"]];
    self.infomationTextField.text = [self.debtDictionary objectForKey:@"infomation"];
    self.dateDueLabel.text = [dateFormatter stringFromDate:[self.debtDictionary objectForKey:@"dateDue"]];
    
    //only shows the due date if the user wants a notification to be sent for the app, otherwise reads N/A and fades out the label
    if ([[self.debtDictionary objectForKey:@"sendNotification"] integerValue] == 1) {
        self.dateDueLabel.text = [dateFormatter stringFromDate:[self.debtDictionary objectForKey:@"dateDue"]];
        self.dateDueLabel.alpha = 1;
    }else{
        self.dateDueLabel.text = @"N/A";
        self.dateDueLabel.alpha = 0.4;
    }
}
@end
