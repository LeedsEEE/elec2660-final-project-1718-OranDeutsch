//
//  NewDebtTableViewController.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 04/12/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Debt+CoreDataClass.h"
#import "appDelegate.h"
#import "UIView+Toast.h"




@interface NewDebtTableViewController : UITableViewController

- (IBAction)saveDebt:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *payeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@property (weak, nonatomic) IBOutlet UIPickerView *amountPicker;
@property (weak, nonatomic) IBOutlet UISwitch *ImOwedSwitch;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;

@property (weak, nonatomic) IBOutlet UISwitch *notificationSwitch;
- (IBAction)toggleNotifications:(id)sender;




@property (strong, nonatomic) NSString *payeeName;
@property (strong, nonatomic) NSDate *dueDate;
@property (strong, nonatomic) NSNumber *amount;
@property (strong, nonatomic) NSNumber *payeeID;

@end
