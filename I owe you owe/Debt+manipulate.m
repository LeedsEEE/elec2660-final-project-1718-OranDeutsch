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
    
    
    NSUInteger amount = [context countForFetchRequest:request error:&error];
    
    
    return (int)amount;
    
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

/*

+ (NSArray *)returnDebts: isPaid:(BOOL)isPaid IOwe:(BOOL)IOwe{
    
    
}

+ (NSDictionary *)debtToDictionary:(Debt *)debtInfo{
    
    
}

+ (NSDictionary *)ViewDebtFromId: (int)debtID{
    
    
}

+ (void)deleteDebtFromID: (int)DebtID{
    
    
}
*/

@end
