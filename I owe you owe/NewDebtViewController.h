//
//  NewDebtViewController.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 21/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewDebtViewController : UIViewController <UITextFieldDelegate>

- (IBAction)payeeSelectComplete:(UIStoryboardSegue *)segue;

@property (strong, nonatomic) NSString *payeeName;
@property int payeeID;



@property (weak, nonatomic) IBOutlet UIButton *selectPayeeButton;

@end
