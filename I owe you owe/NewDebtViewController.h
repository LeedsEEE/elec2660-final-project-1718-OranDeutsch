//
//  NewDebtViewController.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 21/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Debt+manipulate.h"



@interface NewDebtViewController : UIViewController <UITextFieldDelegate>





@property (strong, nonatomic) IBOutlet UISwitch *ImOwedSwitch;

@property (strong, nonatomic) IBOutlet UITextView *infomationField;
@property (strong, nonatomic) IBOutlet UISwitch *notificatioSwitch;



@property (weak, nonatomic) IBOutlet UIButton *selectPayeeButton;
@property (strong, nonatomic) IBOutlet UIButton *selectAmountButton;
@property (strong, nonatomic) IBOutlet UIButton *selectDateButton;

//value holders for various external input elements

@property (strong, nonatomic) NSString *payeeName;
@property (strong, nonatomic) NSDate *dueDate;
@property (strong, nonatomic) NSNumber *amount;
@property (strong, nonatomic) NSNumber *payeeID;

//exit segues from date/payee and amount selection

- (IBAction)payeeSelectComplete:(UIStoryboardSegue *)segue;
- (IBAction)dateSelectComplete:(UIStoryboardSegue *)segue;
- (IBAction)amountSelectComplete:(UIStoryboardSegue *)segue;




- (IBAction)createNewDebt:(id)sender;


@end
