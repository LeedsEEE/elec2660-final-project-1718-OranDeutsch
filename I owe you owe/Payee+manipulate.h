//
//  Payee+manipulate.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 27/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "Payee+CoreDataClass.h"
#import "AppDelegate.h"

@interface Payee (manipulate) 



+ (NSArray *) returnPayees;

+ (int)newPayeeID;

+ (NSDictionary *)payeeEntityToDictonary:(Debt *)payee;

+ (Payee *) AddPayeeFromDictionary:(NSDictionary *)debtInfo;


@end
