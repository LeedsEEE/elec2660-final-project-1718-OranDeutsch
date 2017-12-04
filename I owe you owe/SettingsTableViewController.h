//
//  SettingsTableViewController.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 04/12/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings+manipulate.h"

@interface SettingsTableViewController : UITableViewController


@property (nonatomic, strong) Settings *tempSettings;
@property (nonatomic, strong) NSMutableArray *currencyData;

@property (strong, nonatomic) IBOutlet UIPickerView *currencyPicker;

@end
