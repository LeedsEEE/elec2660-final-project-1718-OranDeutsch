//
//  DebtModel.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 21/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Debt : NSObject

//All infomation that can be stored on a specific debt is defined here


@property (nonatomic, strong) NSString *PayeeFirstName;
@property (nonatomic, strong) NSString *PayeeFullName;
@property (nonatomic, strong) NSString *DisplayAmount;

//data on when the debt was created, expected and paid

@property (nonatomic, strong) NSDate *DateLoaned;
@property (nonatomic, strong) NSDate *DateDue;
@property (nonatomic, strong) NSDate *DatePaid;

//boolean defining if the debt has been paid

@property Boolean IsPaid;

//booleans defining if the debt is a loan from the user to someone else or from someone else to the user.

@property Boolean IOwe;
@property Boolean ImOwed;

@property NSInteger debtId;

@property float amount;


@end
