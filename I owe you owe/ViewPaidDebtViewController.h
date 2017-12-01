//
//  ViewPaidDebtViewController.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 30/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Debt+manipulate.h"

@interface ViewPaidDebtViewController : UIViewController

@property NSInteger debtID;

@property (nonatomic, strong) NSDictionary *debtDictionary;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateStartedLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateDueLabel;
@property (weak, nonatomic) IBOutlet UILabel *datePaidLabel;
@property (weak, nonatomic) IBOutlet UITextView *infomationField;

- (IBAction)markUnpaid:(id)sender;
@end
