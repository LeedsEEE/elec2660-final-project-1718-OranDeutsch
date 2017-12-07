//
//  Settings+CoreDataProperties.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 27/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "Settings+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Settings (CoreDataProperties)

+ (NSFetchRequest<Settings *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *currency;
@property (nullable, nonatomic, copy) NSNumber *currencyID;


@end

NS_ASSUME_NONNULL_END
