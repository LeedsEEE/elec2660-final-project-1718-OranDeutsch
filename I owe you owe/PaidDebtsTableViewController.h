//
//  PaidDebtsTableViewController.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 29/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Debt+CoreDataClass.h"
#import "ViewPaidDebtViewController.h"


@interface PaidDebtsTableViewController : UITableViewController

@property (nonatomic, weak) NSArray *paidDebts;

@end
