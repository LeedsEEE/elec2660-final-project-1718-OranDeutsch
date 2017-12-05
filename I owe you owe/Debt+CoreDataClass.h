//
//  Debt+CoreDataClass.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 28/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Payee+CoreDataClass.h"
#import "Settings+CoreDataClass.h"
#import "AppDelegate.h"


@class Payee;

NS_ASSUME_NONNULL_BEGIN

@interface Debt : NSManagedObject

+ (int)returnNewDebtID;

+ (Debt *)AddDebtFromDictionary:(NSDictionary *)debtInfo;

+ (NSArray *)returnDebts:(BOOL)isPaid owed:(BOOL)ImOwed;

+ (NSDictionary *)debtToDictionary:(Debt *)debtInfo;

+ (NSDictionary *)ViewDebtFromId: (NSInteger)debtID;

+ (void)deleteDebtFromID:(int)DebtID;

+ (void)deleteDebtsFromPayee: (Payee *)payee;

+ (void)deleteAllDebts;

+ (void)modifyIsPaidbyDebtID: (NSInteger)debtID isPaid:(BOOL)newIsPaid;

+ (void)createNotification: (NSInteger)debtID;

+ (void)deleteNotification: (NSInteger)debtID;

+ (NSString *)amountString: (NSNumber *)amount;

+ (BOOL)payeeHasDebts: (Payee *)payee;

@end

NS_ASSUME_NONNULL_END

#import "Debt+CoreDataProperties.h"
