//
//  ViewDebtViewController.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 21/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Debt+manipulate.h"

@interface ViewDebtViewController : UIViewController

@property NSInteger debtID;
@property NSDictionary *debtDictionary;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;



- (IBAction)repayDebt:(id)sender;
- (IBAction)modifyDebt:(id)sender;

@end
