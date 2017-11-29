//
//  NewDebtViewController.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 21/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "NewDebtViewController.h"


@interface NewDebtViewController ()

@end

@implementation NewDebtViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    


    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark exit navigation

- (IBAction)payeeSelectComplete:(id)sender {
    
    [self.selectPayeeButton setTitle:self.payeeName forState:UIControlStateNormal];
    
    
}

- (IBAction)dateSelectComplete:(UIStoryboardSegue *)segue{
    
    
    //conversion method found on stack overflow by user : Adam Richardson
    //https://stackoverflow.com/questions/37117129/ios-convert-a-nsdate-object-into-a-string-to-get-the-current-time
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setCalendar:[NSCalendar currentCalendar]];
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateFormatter setDateFormat:@"M.d.y"];
    
    NSString *dateString = [dateFormatter stringFromDate:self.dueDate];
    
    NSLog(@"returned date = %@", self.dueDate);
    
    [self.selectDateButton setTitle:dateString forState:UIControlStateNormal];
    
    
}
- (IBAction)amountSelectComplete:(UIStoryboardSegue *)segue{
    
    
    NSString *amountpreview = [NSString stringWithFormat:@"%.2f",[self.amount floatValue]];
    
    
    
    [self.selectAmountButton setTitle:amountpreview forState:UIControlStateNormal];
    
    
}

- (IBAction)createNewDebt:(id)sender {
    
    //All user data and some metadata is collected into a dictionary and pushed to the new debt method
    
    NSLog(@"out of function payee id == %@", self.payeeID);
    
    
    if ([self.infomationField.text  isEqual: @"Enter debt description here"]) {
        self.infomationField.text = @"No description given";
    }
    
    NSDictionary *newDebt = @{@"payee" : self.payeeName,
                               @"payeeID" : self.payeeID,
                               @"amount": self.amount,
                               @"isPaid": [NSNumber numberWithBool:0],
                               @"debtID": [NSNumber numberWithInt:-1],
                               @"dateStarted": [NSDate date],
                               @"dateDue" : self.dueDate,
                               @"infomation": self.infomationField.text,
                              @"imOwedDebt" : [NSNumber numberWithInt:self.ImOwedSwitch.on],
                               @"iOweDebt" : [NSNumber numberWithInt:!(self.ImOwedSwitch.on)],
                              @"sendNotification" : [NSNumber numberWithInt:(self.notificatioSwitch.on)]};
    
    NSLog(@"out of function dictionary payee id == %i", (int)[newDebt objectForKey:@"payeeID"]);
    
    NSString *log = [Debt AddDebtFromDictionary:newDebt].description;
    
    
    NSLog(@"%@", log);
    
}


@end
