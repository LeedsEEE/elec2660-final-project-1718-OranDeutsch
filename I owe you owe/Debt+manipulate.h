//
//  Debt+manipulate.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 27/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "Debt+CoreDataClass.h"
#import "Payee+CoreDataClass.h"
#import "AppDelegate.h"

@interface Debt (manipulate)

+ (int)returnAmountOfDebts;

+ (Debt *) AddDebtFromDictionary:(NSDictionary *)debtInfo;

+ (NSArray *)returnDebts: (BOOL)isPaid owed:(BOOL)ImOwed;

+ (NSDictionary *)debtToDictionary:(Debt *)debtInfo;

+ (NSDictionary *)ViewDebtFromId: (int)debtID;

+ (void)deleteDebtFromID: (int)DebtID;


@end
