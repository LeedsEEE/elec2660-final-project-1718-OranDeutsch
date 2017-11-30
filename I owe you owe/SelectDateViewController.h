//
//  SelectDateViewController.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 28/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewDebtViewController.h"

@interface SelectDateViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;


- (IBAction)selectDate:(id)sender;

@end
