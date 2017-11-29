//
//  Payee+manipulate.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 27/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "Payee+manipulate.h"

@implementation Payee (manipulate)

+ (Payee *) AddPayeeFromDictionary:(NSDictionary *)payeeInfo{
    
    //This code uses elements of HuxTek's youtube tutorial series
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    //Accesses core deta "Payee" entity and adds an object
    
    Payee *newPayee = (Payee *)[NSEntityDescription insertNewObjectForEntityForName:@"Payee" inManagedObjectContext:context];
    
    if ([payeeInfo valueForKey:@"payeeID"] == NULL) {
        NSLog(@"null error");
    }
    
    
    newPayee.payeeID = [NSNumber numberWithInt:[Payee newPayeeID]];
    newPayee.name = [payeeInfo valueForKey:@"name"];
    
    

    [context save:nil];
    
    return newPayee;
    
}

+ (NSArray *) returnPayees{
    
    //This code uses elements of HuxTek's youtube tutorial series
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSError *error;
    
    Payee *payees = nil;
    
    //create a new fetch request of all objects in payee entity
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request = [NSFetchRequest fetchRequestWithEntityName:@"Payee"];

    
    // execute
    

    
    NSArray *fetchedPayees = [context executeFetchRequest:request error:&error];
    
    // calls a sub routine to convert the array of objects to an array of dictionaries
    
    NSMutableArray *results = [[NSMutableArray alloc]init];
    
    for (payees in fetchedPayees) {
        
        NSMutableDictionary *tempPayeeDict = [[NSMutableDictionary alloc] init];
        
        tempPayeeDict[@"name"] = payees.name;
        tempPayeeDict[@"payeeID"] = payees.payeeID;
        
        
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

    
    //loads up an array to check that generated payee ID value is unique, adds 1 until it is
    
    
    NSArray *payeeIDs = [context executeFetchRequest:request error:&error];
    
    
    NSMutableArray *results = [[NSMutableArray alloc]init];
    
    
    
    Payee *payeeEntity;
    for (payeeEntity in payeeIDs) {
        
        [results addObject: [NSNumber numberWithInt:(int)payeeEntity.payeeID]];
        
    }
    
    
    while ([results containsObject:[NSNumber numberWithInt:(int)newID]]) {
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


@end
