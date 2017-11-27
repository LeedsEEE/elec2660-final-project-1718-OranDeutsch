//
//  Payee+CoreDataProperties.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 27/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "Payee+CoreDataProperties.h"

@implementation Payee (CoreDataProperties)

+ (NSFetchRequest<Payee *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Payee"];
}

@dynamic name;
@dynamic payeeID;
@dynamic debt;

@end
