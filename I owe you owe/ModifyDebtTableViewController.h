//
//  ModifyDebtTableViewController.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 04/12/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Debt+manipulate.h"
 #include <math.h>

@interface ModifyDebtTableViewController : UITableViewController

@property NSInteger debtID;

@property (nonatomic, strong) NSDictionary *debtDictionary;


@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *amountPicker;
@property (weak, nonatomic) IBOutlet UISwitch *notificationSwitch;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *infomationField;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) NSString *payeeName;
@property (strong, nonatomic) NSDate *dueDate;
@property (strong, nonatomic) NSNumber *amount;


- (IBAction)saveChanges:(id)sender;
- (IBAction)toggleNotification:(id)sender;

@end
