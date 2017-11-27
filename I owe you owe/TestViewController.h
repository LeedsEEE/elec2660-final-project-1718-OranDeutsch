//
//  TestViewController.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 21/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"
#import "Debt.h"
#import "

@interface TestViewController : UIViewController

@property (strong, nonatomic) DataModel *model;
@property (strong, nonatomic) Debt *debt;


- (IBAction)pressed:(id)sender;


@end
