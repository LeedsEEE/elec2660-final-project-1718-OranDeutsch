//
//  OngoingDebtsViewController.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 21/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IOweTableViewController.h"
#import "ImOwedTableViewController.h"
#import "ViewDebtViewController.h"
#import "UIView+Toast.h"

@interface OngoingDebtsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *IOweTable;
@property (weak, nonatomic) IBOutlet UITableView *ImOwedTable;
@property (strong, nonatomic) UITableViewController *iOweTableViewController;
@property (strong, nonatomic) UITableViewController *imOwedTableViewController;


- (IBAction)debtRepayed:(UIStoryboardSegue *)segue;



@end
