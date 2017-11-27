//
//  Debt+CoreDataProperties.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 27/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "Debt+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Debt (CoreDataProperties)

+ (NSFetchRequest<Debt *> *)fetchRequest;

@property (nonatomic) float amount;
@property (nullable, nonatomic, copy) NSDate *dateDue;
@property (nullable, nonatomic, copy) NSDate *datePaid;
@property (nullable, nonatomic, copy) NSDate *dateStarted;
@property (nonatomic) int16_t debtID;
@property (nonatomic) BOOL imOwedDebt;
@property (nullable, nonatomic, copy) NSString *infomation;
@property (nonatomic) BOOL iOweDebt;
@property (nonatomic) BOOL isPaid;
@property (nonatomic) BOOL sendNotification;
@property (nullable, nonatomic, retain) Payee *payee;

@end

NS_ASSUME_NONNULL_END
