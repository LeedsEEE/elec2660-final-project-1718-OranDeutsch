//
//  SelectPayeeViewController.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 27/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectPayeeTableViewController.h"
#import "NewDebtTableViewController.h"
#import "UIView+Toast.h"




@interface SelectPayeeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *payeeTable;

@property (strong, nonatomic) UITableViewController *SelectPayeeTableController;


- (IBAction)payeeFromTextField:(id)sender;
- (IBAction)importPayeeFromContacts:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *payeeNameField;
@property (weak, nonatomic) IBOutlet UIButton *payeeFromContacts;




@end
