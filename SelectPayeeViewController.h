//
//  SelectPayeeViewController.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 27/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectPayeeTableViewController.h"




@interface SelectPayeeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *payeeTable;

@property (strong, nonatomic) UITableViewController *SelectPayeeTableController;


@property (weak, nonatomic) IBOutlet UIButton *newpayee;
@property (weak, nonatomic) IBOutlet UIButton *payeeFromContacts;

@end
