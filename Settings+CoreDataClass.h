//
//  Settings+CoreDataClass.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 27/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Currency.h"

NS_ASSUME_NONNULL_BEGIN

@interface Settings : NSManagedObject

+ (NSMutableArray *)returnCurrencies;

+ (void)updateCurrency: (NSString *)newCurrency;

+ (NSDictionary *) returnSettings;

+ (BOOL)firstTimeLoad;

@end

NS_ASSUME_NONNULL_END

#import "Settings+CoreDataProperties.h"
