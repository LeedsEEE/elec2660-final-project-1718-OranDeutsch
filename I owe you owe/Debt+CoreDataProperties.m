//
//  Debt+CoreDataProperties.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 27/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "Debt+CoreDataProperties.h"

@implementation Debt (CoreDataProperties)

+ (NSFetchRequest<Debt *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Debt"];
}

@dynamic amount;
@dynamic dateDue;
@dynamic datePaid;
@dynamic dateStarted;
@dynamic debtID;
@dynamic imOwedDebt;
@dynamic infomation;
@dynamic iOweDebt;
@dynamic isPaid;
@dynamic sendNotification;
@dynamic payee;

@end
