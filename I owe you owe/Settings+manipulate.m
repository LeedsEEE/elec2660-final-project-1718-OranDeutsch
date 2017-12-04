//
//  Settings+manipulate.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 27/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "Settings+manipulate.h"

@implementation Settings (manipulate)




+ (void)updateCurrency: (NSString *)newCurrency{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSError *error;
    Settings *CurrentSettings = nil;
    
    
    request = [NSFetchRequest fetchRequestWithEntityName:@"Settings"];
    
    NSArray *fetchedObject = [context executeFetchRequest:request error:&error];
    
    
    
    @try {
        CurrentSettings = [fetchedObject objectAtIndex:0];
        
    }
    @catch (NSException *exception) {
        
        CurrentSettings = [NSEntityDescription insertNewObjectForEntityForName:@"Settings" inManagedObjectContext:context];
        
        NSLog(@"no settings found");
        
    }
    
    CurrentSettings.currency = newCurrency;
    
    
    [context save:nil];
    
}

+ (NSDictionary *) returnSettings {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSError *error;
    
    Settings *importedsettings = nil;
    
    //create a new fetch request of all objects in payee entity
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request = [NSFetchRequest fetchRequestWithEntityName:@"Settings"];
    
    
    // execute
    
    
    
    NSArray *fetchedSettings = [context executeFetchRequest:request error:&error];
    
    // takes the first (and only) entry for the called array and puts into in a dictinary
    // right now it is overkill but it allows for more string to be saved as settings and called later

    
    NSMutableDictionary *returnSettings = [[NSMutableDictionary alloc]init];
    
    importedsettings = [fetchedSettings objectAtIndex:0];
    
    returnSettings[@"currency"] = importedsettings.currency;
    
    
    return returnSettings;
    
}

+ (NSMutableArray *)returnCurrencies{
    
    
    //The currency infomation is placed into a small DataModel to keep consistency throughout the whole app
    
    
    NSMutableArray *Currencies = [NSMutableArray array];
    
    Currency *pound = [[Currency alloc] init];
    pound.name = @"Pound";
    pound.symbol = @"£";
    
    Currency *dollar = [[Currency alloc] init];
    dollar.name = @"Dollar";
    dollar.symbol = @"$";
    
    Currency *euro = [[Currency alloc] init];
    euro.name = @"Euro";
    euro.symbol = @"€";
    
    Currency *yen = [[Currency alloc] init];
    yen.name = @"Yen";
    yen.symbol = @"¥";
    
    Currency *yuan = [[Currency alloc] init];
    yuan.name = @"Yuan";
    yuan.symbol = @"¥";
    
    [Currencies addObject:pound];  //
    [Currencies addObject:dollar]; //
    [Currencies addObject:euro];   //
    [Currencies addObject:yen];    //
    [Currencies addObject:yuan];   //
    
    
    
    return Currencies;
    
}

+ (BOOL)firstTimeLoad{
    
    BOOL firstTime = nil;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSError *error;
    
    request = [NSFetchRequest fetchRequestWithEntityName:@"Settings"];
    NSUInteger newID = [context countForFetchRequest:request error:&error];
    
    if (newID > 0) {
        firstTime = NO;
    }else{
        firstTime = YES;
    }
    
    
    return firstTime;
}



@end
