//
//  Debt+CoreDataClass.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 28/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "Debt+CoreDataClass.h"
#import "Payee+CoreDataProperties.h"


@implementation Debt

#pragma mark return value methods

+ (int)returnNewDebtID{
    
    //Standard app delegate decleration
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSError *error;
    
    //Simple request for all objects in the "Debt" entity
    request = [NSFetchRequest fetchRequestWithEntityName:@"Debt"];
    
    //Returns the quantity of objects in the "Debt" entity
    NSUInteger newID = [context countForFetchRequest:request error:&error];
    
    //loads up an array to check that generated debt ID value is unique, adds 1 until it is
    NSArray *debtIDs = [context executeFetchRequest:request error:&error];
    NSMutableArray *results = [[NSMutableArray alloc]init];
    
    //creats an array of debt entities
    Debt *debtEntity;
    for (debtEntity in debtIDs) {
        [results addObject: debtEntity.debtID];
    }
    
    //Runs a while loop that changes the debtID if it had a duplicate and ends once the ID is unique
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
    
    //A predicate is ran to call the payee with the payeeID passed in debtinfo, this is to attach the object to the debt so it can be found based on payee
    payeeRequest.predicate = [NSPredicate predicateWithFormat:@"payeeID == %@", [debtInfo valueForKey:@"payeeID"]];
    selectedPayee = [[context executeFetchRequest:payeeRequest error:&error]objectAtIndex:0];
    
    //Inserts the object into the core data stack
    newDebt = [NSEntityDescription insertNewObjectForEntityForName:@"Debt" inManagedObjectContext:context];
    
    
    //assigns the debt to user selected payee, code currently makes no use for this feautre but it allows for a lot of expandability
    newDebt.payee = selectedPayee;
    
    
    //assign new debt imported values
    float storedAmount = [[debtInfo valueForKey:@"amount"] floatValue];
    int debtID = [self returnNewDebtID];
    newDebt.dateDue = [debtInfo valueForKey:@"dateDue"];
    newDebt.dateStarted = [debtInfo valueForKey:@"dateStarted"];
    newDebt.amount = [NSNumber numberWithFloat:storedAmount];
    newDebt.debtID = [NSNumber numberWithInt:debtID];
    newDebt.imOwedDebt = [debtInfo valueForKey:@"imOwedDebt"];
    newDebt.iOweDebt = [debtInfo valueForKey:@"iOweDebt"];
    newDebt.isPaid = [debtInfo valueForKey:@"isPaid"];
    newDebt.sendNotification = [debtInfo valueForKey:@"sendNotification"];
    newDebt.infomation = [debtInfo valueForKey:@"infomation"];
    
    
    //Save changes to the new object
    [context save:nil];
    
    //calls the internal notification methods to create a notification based on infomation of the newly created debt if the user requested a notification
    if ([[debtInfo valueForKey:@"sendNotification"] integerValue] == 1) {
        
        //Calls the create notificaiton method if the user has specified they want a notificaiton sent
        [self createNotification:debtID];
    }else{
        NSLog(@"User did not request notification");
    }
    
    return newDebt;
    
    
}



+ (NSArray *)returnDebts: (BOOL)isPaid owed:(BOOL)ImOwed{
    //Standard appDelegate method
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSError *error;
    Debt *debtEntity = nil;
    
    //Creates a new request for the Debt entity in Core Data
    request = [NSFetchRequest fetchRequestWithEntityName:@"Debt"];
    
    //returns all debts if user is requesting paid dates and sorts request by date paid
    if (isPaid == 1) {
        
        //If the debt is paid then it will import both owed and loaned debts as they share a table
        request.predicate = [NSPredicate predicateWithFormat:@"isPaid == %i",isPaid];

    } else {
        
        //If the debt is unpaid then it only calls debts the user is owed or debts the user owes, not both
        request.predicate = [NSPredicate predicateWithFormat:@"isPaid == %i AND imOwedDebt == %i",isPaid,ImOwed];
    }
    
    
    NSArray *fetchedObject = [context executeFetchRequest:request  error:&error];
    
    //Runs a loop that adds each object to an array in the form of a dictionary to be passed through
    NSMutableArray *results = [[NSMutableArray alloc]init];
    for (debtEntity in fetchedObject) {
        [results addObject:[self debtToDictionary:debtEntity]];
    }
    
    return results;
    
}



+ (NSDictionary *)debtToDictionary:(Debt *)debtInfo{
    
    //To avoid nil errors I used dictionaries whenever I called data in a view controller, my dictionary used the exact same names as the names in me debt entity
    NSMutableDictionary *debtDict = [[NSMutableDictionary alloc] init];
    
    //Adds data into the dictionary of the payee the debt is assigned to even though the data is not stored in the Debt entity, this makes it easier to populate tables
    Payee *tempPayee = debtInfo.payee;
    debtDict[@"name"] = tempPayee.name;
    debtDict[@"payeeID"] = tempPayee.payeeID;
    debtDict[@"payee"] = debtInfo.payee;
    
    //populates the rest of the new object into the new dictionary
    debtDict[@"amount"] = debtInfo.amount;
    debtDict[@"isPaid"] = debtInfo.isPaid;
    debtDict[@"imOwedDebt"] = debtInfo.imOwedDebt;
    debtDict[@"iOweDebt"] = debtInfo.iOweDebt;
    debtDict[@"debtID"] = debtInfo.debtID;
    debtDict[@"dateStarted"] = debtInfo.dateStarted;
    debtDict[@"dateDue"] = debtInfo.dateDue;
    debtDict[@"datePaid"] = debtInfo.datePaid;
    debtDict[@"infomation"] = debtInfo.infomation;
    debtDict[@"sendNotification"] = debtInfo.sendNotification;
    
    
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
    
    //Predicates the request to only return debt objects with matching ID
    request = [NSFetchRequest fetchRequestWithEntityName:@"Debt"];
    request.predicate = [NSPredicate predicateWithFormat:@"debtID == %i",debtID];
    
    NSArray *fetchedObject = [context executeFetchRequest:request error:&error];
    NSMutableArray *results = [[NSMutableArray alloc]init];
    
    //Uses the debt to dictionary method to populate the results array even though one object is returned
    for (debtEntity in fetchedObject) {
        [results addObject:[self debtToDictionary:debtEntity]];
    }
    
    return [results objectAtIndex:0];
    
    
}

#pragma mark Edit or delete debt methods

+ (void)modifyIsPaidbyDebtID: (NSInteger)debtID isPaid:(BOOL)isPaid {
    
    //Standard appdelegate and nsmanagedobject methods
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSError *error;
    Debt *debtEntity = nil;
    
    //Calls a specific debt based on the debtID
    request = [NSFetchRequest fetchRequestWithEntityName:@"Debt"];
    request.predicate = [NSPredicate predicateWithFormat:@"debtID == %i",debtID];
    NSArray *fetchedObject = [context executeFetchRequest:request error:&error];
    
    //Edits the called entity to the paid date and the new isPaid boolean value
    debtEntity = [fetchedObject objectAtIndex:0];
    debtEntity.isPaid = [NSNumber numberWithBool:isPaid];
    debtEntity.datePaid = [NSDate date];
    
    //If the debt is marked as paid the notification is canceled, if the debt is marked as unpaid then the notification is re-enabled if the user requests so
    if ([debtEntity.isPaid integerValue] == 1) {
        [self deleteNotification: debtID];
    }else if ([debtEntity.sendNotification integerValue] == 1){
        [self createNotification: debtID];
    }
    
    [context save:nil];
    
}


+ (void)deleteDebtFromID: (int)DebtID{
    
    
    //Appdelegate methods to import context
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    //empty objects defined
    NSError *error;
    Debt *debtEntity = nil;
    
    //request condiction based on debtID
    request = [NSFetchRequest fetchRequestWithEntityName:@"Debt"];
    request.predicate = [NSPredicate predicateWithFormat:@"debtID == %i",DebtID];
    
    NSArray *fetchedObject = [context executeFetchRequest:request error:&error];
    
    //As there are no repeat debtIDs it calls the item at index 0
    debtEntity = [fetchedObject objectAtIndex:0];
    [self deleteNotification:DebtID];
    
    //deletes called debt
    [context deleteObject:debtEntity];
    
    [context save:nil];
    
}

+ (void)deleteDebtsFromPayee: (Payee *)payee{
    
    //Appdelegate methods to import context
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    
    //empty objects defined
    NSError *error;
    Debt *debtEntity = nil;
    
    
    //request condiction based on debtID
    request = [NSFetchRequest fetchRequestWithEntityName:@"Debt"];
    request.predicate = [NSPredicate predicateWithFormat:@"payee == %@",payee];
    
    //A loop which every single fetchedobject is deleted as they all will have the same payee
    NSArray *fetchedObject = [context executeFetchRequest:request error:&error];
    for (debtEntity in fetchedObject) {
        [context deleteObject:debtEntity];
    }
    [context save:nil];
    
}

+ (void)deleteAllDebts{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    //empty objects defined
    NSError *error;
    Debt *debtEntity = nil;
    
    //request condiction based on debtID
    request = [NSFetchRequest fetchRequestWithEntityName:@"Debt"];
    
    //Every single debt is deleted in this for loop
    NSArray *fetchedObject = [context executeFetchRequest:request error:&error];
    for (debtEntity in fetchedObject) {
        [context deleteObject:debtEntity];
    }
    
    [context save:nil];
}

#pragma mark notification functions

+ (void)createNotification: (NSInteger)debtID{
    
    //imports the debt infomation based on the passed DebtID
    NSDictionary *tempDebt = [Debt ViewDebtFromId:debtID];
    
    //Declares a new notification
    UNMutableNotificationContent *newDebtNotification = [[UNMutableNotificationContent alloc] init];
    NSString *amount = [Debt amountString:[tempDebt objectForKey:@"amount"]];
    NSString *notificationBodyText = nil;
    
    //The new notification is assigned a identifier matching the debt it is notifing the user about
    NSString *notificationIdentifier = [NSString stringWithFormat:@"%@", [tempDebt objectForKey:@"debtID"]];
    
    //Changes the message depending if the debt is owed to the user or is a loan given out by the user
    if ([[tempDebt objectForKey:@"IOweDebt"] integerValue] == 1) {
        notificationBodyText = [NSString stringWithFormat:@"Debt to %@ of %@",[tempDebt objectForKey:@"name"], amount];
    }else{
        notificationBodyText = [NSString stringWithFormat:@"Debt from %@ of %@",[tempDebt objectForKey:@"name"], amount];
    }
    
    
    //The new strings are assigned to the notification content
    newDebtNotification.title = [NSString localizedUserNotificationStringForKey:@"Debt Due!" arguments:nil];
    newDebtNotification.body = [NSString localizedUserNotificationStringForKey:notificationBodyText arguments:nil];
    newDebtNotification.sound = [UNNotificationSound defaultSound];
    newDebtNotification.badge = @([[UIApplication sharedApplication] applicationIconBadgeNumber]);
    
    //The trigger date is created from the date due and some NSCalender methods
    NSDateComponents *triggerDate = [[NSCalendar currentCalendar]
                                     components:NSCalendarUnitYear +
                                     NSCalendarUnitMonth + NSCalendarUnitDay +
                                     NSCalendarUnitHour + NSCalendarUnitMinute +
                                     NSCalendarUnitSecond fromDate:[tempDebt objectForKey:@"dateDue"]];
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:NO];
    
    //Creates the new notifcation request
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:notificationIdentifier
                                                                          content:newDebtNotification
                                                                          trigger:trigger];
    
    //Creates the new notifcation
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"Local Notification created for : %@", [tempDebt objectForKey:@"dateDue"]);
        }
        else {
            NSLog(@"Error : Local Notification failed");
        }
    }];
    
    
}

+ (void)deleteNotification: (NSInteger)debtID{
    
    
    //Found and modified from stackoverflow
    //https://stackoverflow.com/questions/43773383/how-cancel-local-single-notification-in-objective-c
    
    //Loads the debtID into a string
    NSDictionary *tempDebt = [Debt ViewDebtFromId:debtID];
    NSString *notificationIdentifier = [NSString stringWithFormat:@"%@", [tempDebt objectForKey:@"debtID"]];
    
    //Deletes all debts with the matching debtID
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    NSArray *array = [NSArray arrayWithObjects:notificationIdentifier, nil];
    [center removePendingNotificationRequestsWithIdentifiers:array];
    
    
}




#pragma mark supporting finctions

+ (NSString *)amountString: (NSNumber *)amount{
    
    //Creates a string from an amount value and the user selected currency
    NSString *currencySymbol = [[Settings returnSettings] objectForKey:@"currency"];
    NSString *output = [NSString stringWithFormat:@"%@%.2f",currencySymbol,[amount floatValue]];
    
    return output;
    
}



@end
