//
//  ImOwedTableViewController.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 21/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Debt+CoreDataClass.h"


@interface ImOwedTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *ImOwedDebts;

@end
