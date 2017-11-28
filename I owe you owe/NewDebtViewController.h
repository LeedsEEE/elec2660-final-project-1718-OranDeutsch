//
//  NewDebtViewController.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 21/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewDebtViewController : UIViewController <UITextFieldDelegate>




@property int payeeID;



@property (weak, nonatomic) IBOutlet UIButton *selectPayeeButton;
@property (strong, nonatomic) IBOutlet UIButton *selectAmountButton;
@property (strong, nonatomic) IBOutlet UIButton *selectDateButton;


@property (strong, nonatomic) NSString *payeeName;
@property (strong, nonatomic) NSDate *dueDate;
@property (strong, nonatomic) NSNumber *amount;

//exit segues from date/payee and amount selection

- (IBAction)payeeSelectComplete:(UIStoryboardSegue *)segue;
- (IBAction)dateSelectComplete:(UIStoryboardSegue *)segue;
- (IBAction)amountSelectComplete:(UIStoryboardSegue *)segue;

@end
