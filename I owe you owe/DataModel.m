//
//  DataModel.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 21/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        self.ImOwedDebt = [NSMutableArray array];
        self.IOweDebt = [NSMutableArray array];

       
        
        
        Debt *debt1 = [[Debt alloc] init];
        debt1.debtId = 1;
        debt1.PayeeFirstName = @"Chris";
        debt1.PayeeFullName = @"Chris Smith";
        debt1.DisplayAmount = @"£20";
        debt1.IsPaid = FALSE;
        debt1.IOwe = FALSE;
        debt1.ImOwed = TRUE;
        
        Debt *debt2 = [[Debt alloc] init];
        debt2.debtId = 1;
        debt2.PayeeFirstName = @"Chris";
        debt2.PayeeFullName = @"Chris Smith";
        debt2.DisplayAmount = @"£20";
        debt2.IsPaid = FALSE;
        debt2.IOwe = FALSE;
        debt2.ImOwed = TRUE;
        
        Debt *debt3 = [[Debt alloc] init];
        debt3.debtId = 1;
        debt3.PayeeFirstName = @"Chris";
        debt3.PayeeFullName = @"Chris Smith";
        debt3.DisplayAmount = @"£20";
        debt3.IsPaid = FALSE;
        debt3.IOwe = FALSE;
        debt3.ImOwed = TRUE;
        
        Debt *debt4 = [[Debt alloc] init];
        debt4.debtId = 1;
        debt4.PayeeFirstName = @"Chris";
        debt4.PayeeFullName = @"Chris Smith";
        debt4.DisplayAmount = @"£20";
        debt4.IsPaid = FALSE;
        debt4.IOwe = FALSE;
        debt4.ImOwed = TRUE;
        
        Debt *debt5 = [[Debt alloc] init];
        debt5.debtId = 1;
        debt5.PayeeFirstName = @"Chris";
        debt5.PayeeFullName = @"Chris Smith";
        debt5.DisplayAmount = @"£20";
        debt5.IsPaid = FALSE;
        debt5.IOwe = FALSE;
        debt5.ImOwed = TRUE;
        
        [self.ImOwedDebt addObject:debt1];
        [self.ImOwedDebt addObject:debt2];
        [self.IOweDebt addObject:debt3];
        [self.IOweDebt addObject:debt4];
        [self.IOweDebt addObject:debt5];
        
    }
    return self;
}



@end
