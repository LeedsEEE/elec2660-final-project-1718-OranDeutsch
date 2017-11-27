//
//  SavedDebts.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 21/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "debt.h"

@interface SavedDebts : NSObject

@property (strong, nonatomic) NSMutableArray *IOweDebt;
@property (strong, nonatomic) NSMutableArray *ImOwedDebt;
@property (strong, nonatomic) NSMutableArray *PaidDebt;

+ (SavedDebts *) sharedInstance;

@end
