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
    
    
    [self.selectAmountButton setTitle:[Debt amountString:self.amount] forState:UIControlStateNormal];
    
    
}





- (IBAction)toggleNotifications:(id)sender {
    if (self.notificatioSwitch.on == 1) {
        self.selectDateButton.alpha = 1.0;
        self.selectDateButton.enabled = YES;
        [self.selectDateButton setTitle:@"Select Date" forState:UIControlStateNormal];
    }else{
        self.selectDateButton.alpha = 0.4;
        self.selectDateButton.enabled = NO;
        
        self.dueDate = nil;
        [self.selectDateButton setTitle:@"not required" forState:UIControlStateNormal];
    }
    
    
}

- (IBAction)createNewDebt:(id)sender {
    
    //All user data and some metadata is collected into a dictionary and pushed to the new debt method
    
    
    
    if ([self.infomationField.text  isEqual: @"Enter debt description here"]) {
        self.infomationField.text = @"No description given";
    }
    
    //disable due date from being recorded if user does not want a notification
    
    if (self.notificatioSwitch.on == 0) {
        self.dueDate = [NSDate date];
    }
    
    
    #pragma mark invalid entry checking
    
    @try {
        
        
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
        

        
        NSString *log = [Debt AddDebtFromDictionary:newDebt].description;
        
        NSLog(@"%@", log);
    }
    
    @catch (NSException *exception) {
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Important Entry not selected" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }
    

    
}

-(void)viewDidDisappear:(BOOL)animated {
    
    
    
}

@end
