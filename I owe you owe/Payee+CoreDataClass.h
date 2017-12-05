//
//  Payee+CoreDataClass.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 27/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import <UIKit/UIKit.h>

@class Debt;

NS_ASSUME_NONNULL_BEGIN

@interface Payee : NSManagedObject

+ (NSArray *) returnPayees;

+ (int)newPayeeID;

+ (NSDictionary *)payeeEntityToDictonary:(Debt *)payee;

+ (Payee *) AddPayeeFromDictionary:(NSDictionary *)debtInfo;

@end

NS_ASSUME_NONNULL_END

#import "Payee+CoreDataProperties.h"
