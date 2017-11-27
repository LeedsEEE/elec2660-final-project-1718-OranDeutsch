//
//  SavedDebts.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 21/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "debt.h"

@interface SavedDebts : UIViewController


@property (strong, nonatomic) NSMutableArray *IOweDebt;
@property (strong, nonatomic) NSMutableArray *ImOwedDebt;
@property (strong, nonatomic) NSMutableArray *PaidDebt;

@end
