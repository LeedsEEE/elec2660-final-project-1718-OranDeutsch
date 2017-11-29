//
//  Debt+manipulate.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 27/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "Debt+manipulate.h"

@implementation Debt (manipulate)

+ (int)returnAmountOfDebts{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSError *error;
    
    
    
    request = [NSFetchRequest fetchRequestWithEntityName:@"Debt"];
    
    
    NSUInteger newID = [context countForFetchRequest:request error:&error];
    
    //loads up an array to check that generated debt ID value is unique, adds 1 until it is
    
    NSArray *debtIDs = [context executeFetchRequest:request error:&error];
    NSMutableArray *results = [[NSMutableArray alloc]init];
    
    
    
    Debt *debtEntity;
    for (debtEntity in debtIDs) {
        
        [results addObject: debtEntity.debtID];
        
    }
    
    
    while ([results containsObject:[NSNumber numberWithInt:(int)newID]]) {
        newID++;
    }
    
    
    return (int)newID;
    
}

+ (Debt *) AddDebtFromDictionary:(NSDictionary *)debtInfo{
    
    //This code uses elements of HuxTek's youtube tutorial series
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSError *error = nil;;
    
    Debt *newDebt = nil;
    Payee *selectedPayee = nil;
    
    //selects the payee based on the carried payeeID
    
    NSFetchRequest *payeeRequest = [[NSFetchRequest alloc] init];
    payeeRequest = [NSFetchRequest fetchRequestWithEntityName:@"Payee"];
    
    
    NSLog(@"payeeID == %@", [debtInfo valueForKey:@"payeeID"]);
                              
    
    payeeRequest.predicate = [NSPredicate predicateWithFormat:@"payeeID == %@", [debtInfo valueForKey:@"payeeID"]];
    selectedPayee = [[context executeFetchRequest:payeeRequest error:&error]objectAtIndex:0];
    
    newDebt = [NSEntityDescription insertNewObjectForEntityForName:@"Debt" inManagedObjectContext:context];
    
    
    //assigns the debt to user selected payee, code currently makes no use for this feautre but it allows for a lot of expandability
    
    newDebt.payee = selectedPayee;
    
    //assign new debt imported values
    
    float storedAmount = [[debtInfo valueForKey:@"amount"] floatValue];
    int debtID = [self returnAmountOfDebts];
    
    newDebt.dateDue = [debtInfo valueForKey:@"dateDue"];
    newDebt.dateStarted = [debtInfo valueForKey:@"dateStarted"];
    
    
    newDebt.amount = [NSNumber numberWithFloat:storedAmount];
    
    newDebt.debtID = [NSNumber numberWithInt:debtID];
    
    
    
    newDebt.imOwedDebt = [debtInfo valueForKey:@"imOwedDebt"];
    newDebt.iOweDebt = [debtInfo valueForKey:@"iOweDebt"];
    newDebt.isPaid = [debtInfo valueForKey:@"isPaid"];
    newDebt.sendNotification = [debtInfo valueForKey:@"sendNotification"];

    newDebt.infomation = [debtInfo valueForKey:@"infomation"];
    
    
    
    [context save:nil];
    
    return newDebt;

    
}



+ (NSArray *)returnDebts: (BOOL)isPaid owed:(BOOL)ImOwed{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSError *error;
    
    Debt *debtEntity = nil;
    
    request = [NSFetchRequest fetchRequestWithEntityName:@"Debt"];
    request.predicate = [NSPredicate predicateWithFormat:@"isPaid == %i AND imOwedDebt == %i",isPaid,ImOwed];
    
    NSArray *fetchedObject = [context executeFetchRequest:request error:&error];
    
    
    
    
    NSMutableArray *results = [[NSMutableArray alloc]init];
    
    for (debtEntity in fetchedObject) {
        
        [results addObject:[self debtToDictionary:debtEntity]];
        
    }
    
    return results;
        
}
 

 
+ (NSDictionary *)debtToDictionary:(Debt *)debtInfo{
    
    NSMutableDictionary *debtDict = [[NSMutableDictionary alloc] init];
    
    Payee *tempPayee = debtInfo.payee;
    
    debtDict[@"name"] = tempPayee.name;
    debtDict[@"payeeID"] = tempPayee.payeeID;
    
    
    debtDict[@"amount"] = debtInfo.amount;
    debtDict[@"isPaid"] = debtInfo.isPaid;
    debtDict[@"ImOwedDebt"] = debtInfo.imOwedDebt;
    debtDict[@"IOweDebt"] = debtInfo.iOweDebt;
    debtDict[@"debtID"] = debtInfo.debtID;

    
    return debtDict;
}

    

+ (NSDictionary *)ViewDebtFromId: (NSInteger)debtID{
    
    
    //Identical to return debts however just sends a single debt based on its ID
    //this function is used for views where more detail is shown on a specific debt entry
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSError *error;
    Debt *debtEntity = nil;
    
    request = [NSFetchRequest fetchRequestWithEntityName:@"Debt"];
    request.predicate = [NSPredicate predicateWithFormat:@"debtID == %i",debtID];
    
    NSArray *fetchedObject = [context executeFetchRequest:request error:&error];
    
    NSMutableArray *results = [[NSMutableArray alloc]init];
    
    for (debtEntity in fetchedObject) {
        
        [results addObject:[self debtToDictionary:debtEntity]];
        
    }
    
    return [results objectAtIndex:0];

    
}


+ (void)deleteDebtFromID: (int)DebtID{
    
    
}


@end
