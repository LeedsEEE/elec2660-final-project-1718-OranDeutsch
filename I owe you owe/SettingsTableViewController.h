//
//  SettingsTableViewController.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 04/12/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings+CoreDataClass.h"
#import "Payee+CoreDataClass.h"
#import "Debt+CoreDataClass.h"
#import "SelectPayeeTableViewController.h"
#import "UIView+Toast.h"

@interface SettingsTableViewController : UITableViewController



//Imports the same table view datasource/delegate as the "select payee" as they both display the same infomation


@property (strong, nonatomic) UITableViewController *SelectPayeeTableController;

- (IBAction)deleteAll:(id)sender;

@property (nonatomic, strong) Settings *tempSettings;
@property (nonatomic, strong) NSMutableArray *currencyData;

@property (weak, nonatomic) IBOutlet UITableView *payeeTable;

- (IBAction)deletePayee:(id)sender;

@property (strong, nonatomic) IBOutlet UIPickerView *currencyPicker;

@end
