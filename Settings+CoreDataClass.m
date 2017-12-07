//
//  Settings+CoreDataClass.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 27/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "Settings+CoreDataClass.h"

@implementation Settings

+ (void)updateCurrency: (NSInteger)currencyID{
    
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
        
        
    }
    NSArray *currencies = [self returnCurrencies];
    Currency *tempCurrency = [currencies objectAtIndex:currencyID];
    
    
    CurrentSettings.currency = tempCurrency.symbol;
    CurrentSettings.currencyID = [NSNumber numberWithInt: (int32_t)currencyID];
    
    
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
    returnSettings[@"currencyID"] = importedsettings.currencyID;
    
    
    return returnSettings;
    
}


+ (void)deleteAllSettings{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    //empty objects defined
    
    NSError *error;
    Settings *settingsEntity = nil;
    
    //request condiction based on PayeeID
    request = [NSFetchRequest fetchRequestWithEntityName:@"Settings"];
    
    
    NSArray *fetchedObject = [context executeFetchRequest:request error:&error];
    
    for (settingsEntity in fetchedObject) {
        
        [context deleteObject:settingsEntity];
        
    }
    
    [context save:nil];

}


+ (BOOL)firstTimeLoad{
    
    //Returns YES or NO in a BOOL if this is the first time the app has been run
    
    //this is done with a count fetch request on the Settings enetity, if the entitiy returns 0 then the settings has not been setup yet meaning the app has not been ran yet
    
    BOOL firstTime = NO;
    
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

+ (NSMutableArray *)returnCurrencies{
    
    
    //The currency infomation is placed into a small DataModel to keep consistency throughout the whole app
    
    
    NSMutableArray *Currencies = [NSMutableArray array];
    
    Currency *pound = [[Currency alloc] init];
    pound.name = @"GBP";
    pound.symbol = @"£";
    
    Currency *dollar = [[Currency alloc] init];
    dollar.name = @"USD";
    dollar.symbol = @"$";
    
    Currency *euro = [[Currency alloc] init];
    euro.name = @"EUR";
    euro.symbol = @"€";
    
    Currency *yen = [[Currency alloc] init];
    yen.name = @"JPY";
    yen.symbol = @"¥";
    
    Currency *yuan = [[Currency alloc] init];
    yuan.name = @"RMB";
    yuan.symbol = @"¥";
    
    Currency *ruble = [[Currency alloc] init];
    ruble.name = @"RUB";
    ruble.symbol = @"₽";
    
    [Currencies addObject:pound];   //index0
    [Currencies addObject:dollar];  //index1
    [Currencies addObject:euro];    //index2
    [Currencies addObject:yen];     //index3
    [Currencies addObject:yuan];    //index4
    [Currencies addObject:ruble];   //index5
    
    
    
    return Currencies;
    
}


@end
