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
    // Do any additional setup after loading the view.
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


@end
