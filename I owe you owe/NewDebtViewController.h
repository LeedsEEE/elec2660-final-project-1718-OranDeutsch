//
//  NewDebtViewController.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 21/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"


@interface NewDebtViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *NameFeild;
@property (weak, nonatomic) IBOutlet UITextField *AmountFeild;

@property (strong, nonatomic) Debt *debt;
@property (nonatomic, assign) DataModel *data;

@end
