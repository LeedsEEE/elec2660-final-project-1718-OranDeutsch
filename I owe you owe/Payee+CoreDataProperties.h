//
//  Payee+CoreDataProperties.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 27/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "Payee+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Payee (CoreDataProperties)

+ (NSFetchRequest<Payee *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) NSNumber *payeeID;
@property (nullable, nonatomic, retain) NSSet<Debt *> *debt;

@end

@interface Payee (CoreDataGeneratedAccessors)

- (void)addDebtObject:(Debt *)value;
- (void)removeDebtObject:(Debt *)value;
- (void)addDebt:(NSSet<Debt *> *)values;
- (void)removeDebt:(NSSet<Debt *> *)values;

@end

NS_ASSUME_NONNULL_END
