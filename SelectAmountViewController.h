//
//  SelectAmountViewController.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 28/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewDebtViewController.h"

@interface SelectAmountViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIPickerView *amountPicker;

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@property (strong) NSNumber *amount;




@end
