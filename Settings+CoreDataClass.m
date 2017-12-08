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
    
    
    //Standard appdelegate methods
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSError *error;
    Settings *CurrentSettings = nil;
    
    //Sends a request for all objects in the settings enetity
    request = [NSFetchRequest fetchRequestWithEntityName:@"Settings"];
    NSArray *fetchedObject = [context executeFetchRequest:request error:&error];
    
    
    //If there are no called settings (the app cant find any objects in an array then a new settings object is created
    if ([self firstTimeLoad] == YES) {
        CurrentSettings = [fetchedObject objectAtIndex:0];
    }else{
        CurrentSettings = [NSEntityDescription insertNewObjectForEntityForName:@"Settings" inManagedObjectContext:context];
    }
    
    //Calls the return currencies method and selects the users desired currency from it
    NSArray *currencies = [self returnCurrencies];
    Currency *tempCurrency = [currencies objectAtIndex:currencyID];
    
    //Updates and saves the object
    CurrentSettings.currency = tempCurrency.symbol;
    CurrentSettings.currencyID = [NSNumber numberWithInt: (int32_t)currencyID];
    [context save:nil];
    
}

+ (NSDictionary *) returnSettings {
    
    //Standard appdelegate methods
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
    //Standard appdelegate methods
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    //empty objects defined
    NSError *error;
    Settings *settingsEntity = nil;
    
    //request condiction based on PayeeID
    request = [NSFetchRequest fetchRequestWithEntityName:@"Settings"];
    
    //Loops through an array of hopefully only one object, if there are none then the loop is ignored
    NSArray *fetchedObject = [context executeFetchRequest:request error:&error];
    for (settingsEntity in fetchedObject) {
        [context deleteObject:settingsEntity];
    }
    
    [context save:nil];

}

#pragma mark Supporting methods


+ (BOOL)firstTimeLoad{
    
    //Returns YES or NO in a BOOL if this is the first time the app has been run
    
    //this is done with a count fetch request on the Settings enetity, if the entitiy returns 0 then the settings has not been setup yet meaning the app has not been ran yet
    BOOL firstTime = NO;
    
    //Standard appdelegate methods
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSError *error;
    
    //Counts the amount of objects in the settings entity
    request = [NSFetchRequest fetchRequestWithEntityName:@"Settings"];
    NSUInteger newID = [context countForFetchRequest:request error:&error];
    
    //If there are no objects then the bool is set to YES, otherwise NO
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
    
    //Currencies get added to the array in a simple template to add more later
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
