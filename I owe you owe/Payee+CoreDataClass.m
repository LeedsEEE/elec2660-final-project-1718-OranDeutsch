//
//  Payee+CoreDataClass.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 27/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "Payee+CoreDataClass.h"

@implementation Payee

+ (Payee *) AddPayeeFromDictionary:(NSDictionary *)payeeInfo{
    
    //This code uses elements of HuxTek's youtube tutorial series
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    //Checks through all other Payees to detect a duplicate
    Payee *newPayee = nil;
    
    NSError *error = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request = [NSFetchRequest fetchRequestWithEntityName:@"Payee"];
    request.predicate = [NSPredicate predicateWithFormat:@"name == %@",[payeeInfo valueForKey:@"name"]];
    
    NSUInteger duplicates = [context countForFetchRequest:request error:&error];
    
    if (duplicates == 0) {
        
        //Accesses core deta "Payee" entity and adds an object only if there are no other payees with the same name
        
        newPayee = (Payee *)[NSEntityDescription insertNewObjectForEntityForName:@"Payee" inManagedObjectContext:context];
        newPayee.payeeID = [NSNumber numberWithInt:[Payee newPayeeID]];
        newPayee.name = [payeeInfo valueForKey:@"name"];
        
        
        
        
        [context save:nil];
        
        
        
    }else{
        
        
        
        
    }
    
    //returns a value of nil if there is a duplicate
    
    return newPayee;
    
    
}

+ (NSArray *) returnPayees{
    
    //This code uses elements of HuxTek's youtube tutorial series
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSError *error;
    
    Payee *payeeEntity = nil;
    
    //create a new fetch request of all objects in payee entity
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request = [NSFetchRequest fetchRequestWithEntityName:@"Payee"];
    
    
    // execute
    
    
    
    NSArray *fetchedPayees = [context executeFetchRequest:request error:&error];
    
    // calls a sub routine to convert the array of objects to an array of dictionaries
    
    NSMutableArray *results = [[NSMutableArray alloc]init];
    
    for (payeeEntity in fetchedPayees) {
        
        NSMutableDictionary *tempPayeeDict = [[NSMutableDictionary alloc] init];
        
        tempPayeeDict[@"payee"] = payeeEntity;
        
        
        tempPayeeDict[@"name"] = payeeEntity.name;
        tempPayeeDict[@"payeeID"] = payeeEntity.payeeID;
        
        
        [results addObject: tempPayeeDict];
        
        tempPayeeDict = nil;
        
    }
    
    return results;
    
}

+ (int)newPayeeID{
    
    //This code uses elements of HuxTek's youtube tutorial series
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSError *error;
    
    //create a new fetch request of all objects in payee entity
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request = [NSFetchRequest fetchRequestWithEntityName:@"Payee"];
    
    NSUInteger newID = [context countForFetchRequest:request error:&error];
    
    //As an unselected tableview would output a selected row of "0" if there is no selected row I have to make sure a payee with ID of 0 would never exist
    
    if (newID == 0) {
        newID++;
    }
    
    //loads up an array to check that generated payee ID value is unique, adds 1 until it is
    
    
    NSArray *payeeIDs = [context executeFetchRequest:request error:&error];    
    NSMutableArray *results = [[NSMutableArray alloc]init];
    
    
    
    Payee *payeeEntity;
    for (payeeEntity in payeeIDs) {
        
        [results addObject: [NSNumber numberWithLong:[payeeEntity.payeeID integerValue]]];
        
    }
    
    
    while ([results containsObject:[NSNumber numberWithInt:newID]]) {
        newID++;
    }
    
    
    return (int)newID;
}


+ (NSDictionary *)payeeEntityToDictonary:(Payee *)payee{
    
    NSMutableDictionary *payeeDict = [[NSMutableDictionary alloc] init];
    
    //puts payee infomation into new dictionary
    
    payeeDict[@"name"] = payee.name;
    payeeDict[@"payeeID"] = payee.payeeID;
    
    
    return payeeDict;
    
    //I had an issue with data being carried over, this reset fixed it
    
    payeeDict = nil;
}


+ (void)deletePayeeFromID: (NSInteger)payeeID{
    
    
    //Appdelegate methods to import context
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    //empty objects defined
    
    NSError *error;
    Payee *payeeEtity = nil;
    
    //request condiction based on debtID
    
    
    request = [NSFetchRequest fetchRequestWithEntityName:@"Payee"];
    request.predicate = [NSPredicate predicateWithFormat:@"payeeID == %i",payeeID];
    
    NSArray *fetchedObject = [context executeFetchRequest:request error:&error];
    
    //As there are no repeat debtIDs it calls the item at index 0
    
    payeeEtity = [fetchedObject objectAtIndex:0];
    
    //deletes called debt
    
    [context deleteObject:payeeEtity];
    
    [context save:nil];
    
}

+ (BOOL)payeeHasDebts: (Payee *)payee{
    
    //This code uses elements of HuxTek's youtube tutorial series
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSError *error;
    
    //create a new fetch request of all objects in payee entity
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request = [NSFetchRequest fetchRequestWithEntityName:@"Debt"];
    request.predicate = [NSPredicate predicateWithFormat:@"payee == %@",payee];
    
    //counts the amount of debts the payee has, if they have 1 or more then return yes, otherwise send NO
    
    NSUInteger newID = [context countForFetchRequest:request error:&error];

    BOOL hasDebts;
    
    if (newID ==0) {
        hasDebts = NO;
    }else{
        hasDebts = YES;
    }
    
    
    return hasDebts;
}

@end
