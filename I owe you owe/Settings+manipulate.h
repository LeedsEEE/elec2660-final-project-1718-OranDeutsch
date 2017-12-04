//
//  Settings+manipulate.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 27/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "Settings+CoreDataClass.h"
#import "AppDelegate.h"
#import "Currency.h"

@interface Settings (manipulate)


@property (weak, nonatomic) NSMutableArray *Currencies;

+ (NSMutableArray *)returnCurrencies;

+ (void)updateCurrency: (NSString *)newCurrency;

+ (NSDictionary *) returnSettings;

+ (BOOL)firstTimeLoad;

@end
